-- Sema Theme Configuration Module
-- Provides additional configuration and utilities for the Sema theme

local M = {}

-- Theme configuration with complexity-first principle
M.config = {
  -- Enable complexity-based highlighting
  complexity_highlighting = true,
  
  -- Priority levels for different code elements
  priorities = {
    control_flow = 1,        -- Highest priority
    interfaces_traits = 2,   -- Second priority  
    magic_values = 3,        -- Third priority
    mutations = 4,           -- Fourth priority
    basic_syntax = 5,        -- Lowest priority
  },
  
  -- Visual emphasis settings
  emphasis = {
    control_flow = { bold = true, intensity = 'high' },
    interfaces = { intensity = 'medium' },
    magic_numbers = { intensity = 'medium' },
    mutations = { underline = true, intensity = 'medium' },
    basic = { intensity = 'low' },
  },
  
  -- Additional semantic token customization
  semantic_tokens = {
    -- Emphasize unsafe operations
    ['*.unsafe'] = { style = 'bold', priority = 1 },
    -- Underline mutable operations
    ['*.mutable'] = { style = 'underline', priority = 4 },
    -- Italicize consuming operations
    ['*.consuming'] = { style = 'italic', priority = 4 },
    -- Highlight public declarations
    ['*.public.declaration'] = { priority = 2 },
  },
}

-- Function to check if a highlight group should be emphasized
function M.should_emphasize(group)
  local emphasis_groups = {
    -- Control flow groups (highest priority)
    ['Conditional'] = true,
    ['Repeat'] = true,
    ['Exception'] = true,
    ['@keyword.control'] = true,
    ['@keyword.control.return'] = true,
    ['@keyword.control.exception'] = true,
    
    -- Interface/trait groups
    ['@type.interface'] = true,
    ['@lsp.type.interface'] = true,
    ['@type.parameter'] = true,
    
    -- Magic values
    ['Number'] = true,
    ['Float'] = true,
    ['@number'] = true,
    ['@float'] = true,
  }
  
  return emphasis_groups[group] or false
end

-- Function to get color intensity based on priority
function M.get_intensity(priority)
  local intensities = {
    [1] = 1.0,   -- Full intensity for control flow
    [2] = 0.85,  -- High intensity for interfaces
    [3] = 0.75,  -- Medium-high for magic values
    [4] = 0.65,  -- Medium for mutations
    [5] = 0.5,   -- Low for basic syntax
  }
  return intensities[priority] or 0.5
end

-- Function to apply complexity-based adjustments to highlight groups
function M.apply_complexity_rules()
  if not M.config.complexity_highlighting then
    return
  end
  
  -- Additional complexity-focused highlight adjustments for Tree-sitter
  local adjustments = {
    -- De-emphasize basic syntax elements
    ['Delimiter'] = { link = 'Normal' },
    ['@punctuation'] = { link = 'Normal' },
    ['@punctuation.bracket'] = { link = 'Normal' },
    ['@punctuation.delimiter'] = { link = 'Normal' },
    
    -- Further emphasize control flow complexity
    ['@keyword.control'] = { bold = true },
    ['@keyword.control.conditional'] = { bold = true },
    ['@keyword.control.repeat'] = { bold = true },
    ['@keyword.control.exception'] = { bold = true },
    ['@keyword.coroutine'] = { bold = true },
    
    -- Highlight complex patterns
    ['@string.regex'] = { bold = true },
    ['@function.call.recursive'] = { fg = '#5898B7', bold = true, underline = true },
    
    -- Mark mutation operations clearly
    ['@operator.assignment'] = { fg = '#BB7D72' },
    ['@function.method.mutating'] = { underline = true },
    ['@variable.member.mutating'] = { underline = true },
    
    -- Language-specific complexity markers
    ['@keyword.async'] = { fg = '#5898B7', bold = true },
    ['@keyword.await'] = { fg = '#5898B7', bold = true },
    ['@type.qualifier.mut'] = { fg = '#BB7D72', underline = true },
    ['@type.qualifier.const'] = { fg = '#866870' },
    ['@attribute.unsafe'] = { fg = '#BB7D72', bold = true },
  }
  
  for group, settings in pairs(adjustments) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

-- Function to create custom highlight groups for complexity indicators
function M.setup_complexity_indicators()
  -- Define custom groups for complexity visualization
  vim.api.nvim_set_hl(0, 'ComplexityHigh', { fg = '#BB7D72', bold = true })
  vim.api.nvim_set_hl(0, 'ComplexityMedium', { fg = '#5898B7' })
  vim.api.nvim_set_hl(0, 'ComplexityLow', { fg = '#696969' })
  
  -- Cyclomatic complexity indicators
  vim.api.nvim_set_hl(0, 'CyclomaticComplex', { bg = '#FFE4E4' })
  vim.api.nvim_set_hl(0, 'CyclomaticModerate', { bg = '#E4F0FF' })
  
  -- Nesting depth indicators
  vim.api.nvim_set_hl(0, 'NestingDeep', { bg = '#FFF0E4' })
  vim.api.nvim_set_hl(0, 'NestingModerate', { bg = '#F0F0F0' })
end

-- Initialize the theme with complexity-first principles
function M.setup(opts)
  opts = opts or {}
  
  -- Merge user options with defaults
  M.config = vim.tbl_deep_extend('force', M.config, opts)
  
  -- Load the base theme
  require('nvim.colors.sema')
  
  -- Apply complexity-based rules
  M.apply_complexity_rules()
  
  -- Setup complexity indicators
  M.setup_complexity_indicators()
  
  -- Set up autocommands for dynamic complexity highlighting
  if M.config.complexity_highlighting then
    vim.api.nvim_create_augroup('SemaComplexity', { clear = true })
    
    -- Highlight deeply nested code
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
      group = 'SemaComplexity',
      callback = function()
        -- This is where you could integrate with complexity analysis tools
        -- For now, it's a placeholder for future enhancements
      end,
    })
  end
end

return M