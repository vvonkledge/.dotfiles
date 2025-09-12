-- Sema Light Theme for Neovim
-- Based on the complexity-first highlighting principle

local M = {}

function M.setup()
  vim.cmd('hi clear')
  if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
  end
  vim.o.termguicolors = true
  vim.g.colors_name = 'sema'

  -- Base colors from the VS Code theme
  local colors = {
    -- Background and foreground
    bg = '#FFFFFF',
    fg = '#333333',
    
    -- UI elements
    cursor_line = '#E4E4E4',
    selection = '#BEBEBD',
    cursor = '#161616',
    line_number = '#A4A4A4',
    line_number_active = '#161616',
    
    -- Priority colors (based on complexity-first principle)
    -- 1. Control flow (HIGHEST PRIORITY)
    control_flow = '#5898B7',      -- Blue for control flow
    control_keyword = '#5D7587',   -- Muted blue for basic keywords
    
    -- 2. Interfaces and traits
    interface = '#5898B7',          -- Blue for interfaces
    type_param = '#5898B7',         -- Blue for type parameters
    
    -- 3. Magic numbers and strings
    number = '#AB7DA7',             -- Purple for numbers
    string = '#667953',             -- Green for strings
    constant = '#866870',           -- Muted purple for constants
    
    -- 4. Mutation operations
    mutable = '#BB7D72',            -- Red-ish for dangerous operations
    
    -- Standard types and identifiers
    type = '#757358',               -- Brown for types
    property = '#6F6F89',           -- Purple-gray for properties
    enum_member = '#6F6F89',        -- Purple-gray for enum members
    
    -- Special elements
    macro = '#6A775E',              -- Green-ish for macros
    comment = '#161616',            -- Dark for comments
    attribute = '#696969',          -- Gray for attributes
    
    -- Diff colors
    diff_add = '#667953',
    diff_delete = '#BB7D72',
    diff_change = '#5898B7',
    
    -- Additional UI colors
    inactive = '#696969',
    border = '#A4A4A4',
    widget_bg = '#E4E4E4',
  }

  -- Editor highlighting groups
  local groups = {
    -- Core editor
    Normal = { fg = colors.fg, bg = colors.bg },
    NormalFloat = { fg = colors.fg, bg = colors.bg },
    NormalNC = { fg = colors.fg, bg = colors.bg },
    
    -- Cursor and selection
    Cursor = { fg = colors.bg, bg = colors.cursor },
    CursorLine = { bg = colors.cursor_line },
    CursorLineNr = { fg = colors.line_number_active, bold = true },
    Visual = { bg = colors.selection },
    VisualNOS = { bg = colors.selection },
    
    -- Line numbers
    LineNr = { fg = colors.line_number },
    SignColumn = { bg = colors.bg },
    FoldColumn = { fg = colors.line_number, bg = colors.bg },
    Folded = { fg = colors.inactive, bg = colors.widget_bg },
    
    -- Status line
    StatusLine = { fg = colors.fg, bg = colors.widget_bg },
    StatusLineNC = { fg = colors.inactive, bg = colors.bg },
    
    -- Tabs
    TabLine = { fg = colors.inactive, bg = colors.bg },
    TabLineFill = { bg = colors.bg },
    TabLineSel = { fg = colors.line_number_active, bg = colors.cursor_line },
    
    -- Popup menu
    Pmenu = { fg = colors.fg, bg = colors.widget_bg },
    PmenuSel = { fg = colors.fg, bg = colors.selection },
    PmenuSbar = { bg = colors.widget_bg },
    PmenuThumb = { bg = colors.selection },
    
    -- Search and matches
    Search = { fg = colors.fg, bg = colors.selection },
    IncSearch = { fg = colors.bg, bg = colors.control_flow },
    MatchParen = { fg = colors.control_flow, bold = true },
    
    -- Messages
    ErrorMsg = { fg = colors.mutable },
    WarningMsg = { fg = colors.type },
    ModeMsg = { fg = colors.fg },
    MoreMsg = { fg = colors.string },
    Question = { fg = colors.control_flow },
    
    -- Splits
    VertSplit = { fg = colors.border },
    WinSeparator = { fg = colors.border },
    
    -- Diff
    DiffAdd = { fg = colors.diff_add },
    DiffChange = { fg = colors.diff_change },
    DiffDelete = { fg = colors.diff_delete },
    DiffText = { fg = colors.diff_change, bold = true },
    
    -- Spell
    SpellBad = { undercurl = true, sp = colors.mutable },
    SpellCap = { undercurl = true, sp = colors.type },
    SpellLocal = { undercurl = true, sp = colors.control_flow },
    SpellRare = { undercurl = true, sp = colors.constant },
    
    -- Priority 1: Control Flow (HIGHEST PRIORITY - most prominent)
    Conditional = { fg = colors.control_flow, bold = true },
    Repeat = { fg = colors.control_flow, bold = true },
    Label = { fg = colors.control_flow },
    Exception = { fg = colors.control_flow, bold = true },
    Keyword = { fg = colors.control_keyword },
    Statement = { fg = colors.control_keyword },
    
    -- Priority 2: Interfaces and Traits
    Structure = { fg = colors.interface },
    Typedef = { fg = colors.interface },
    StorageClass = { fg = colors.interface },
    
    -- Priority 3: Magic Numbers and Strings  
    Number = { fg = colors.number },
    Float = { fg = colors.number },
    String = { fg = colors.string },
    Character = { fg = colors.string },
    Constant = { fg = colors.constant },
    Boolean = { fg = colors.enum_member },
    
    -- Priority 4: Mutation Operations
    Operator = { fg = colors.fg },  -- Keep operators subtle
    Special = { fg = colors.property },
    SpecialChar = { fg = colors.property },
    
    -- Types (less emphasis than control flow)
    Type = { fg = colors.type },
    
    -- Functions and identifiers (minimal highlighting)
    Function = { fg = colors.fg },
    Identifier = { fg = colors.fg },
    
    -- Properties and fields
    Field = { fg = colors.property },
    Property = { fg = colors.property },
    
    -- Preprocessor and macros
    PreProc = { fg = colors.macro },
    Macro = { fg = colors.macro },
    Define = { fg = colors.macro },
    Include = { fg = colors.macro },
    PreCondit = { fg = colors.macro },
    
    -- Comments (italic for regular, normal for documentation)
    Comment = { fg = colors.comment, italic = true },
    SpecialComment = { fg = colors.comment },
    Todo = { fg = colors.control_flow, bold = true },
    
    -- Delimiters (keep subtle)
    Delimiter = { fg = colors.fg },
    
    -- Underlined
    Underlined = { underline = true },
    
    -- Errors and warnings
    Error = { fg = colors.mutable },
    Warning = { fg = colors.type },
    Info = { fg = colors.control_flow },
    Hint = { fg = colors.property },
    
    -- LSP and Diagnostics
    DiagnosticError = { fg = colors.mutable },
    DiagnosticWarn = { fg = colors.type },
    DiagnosticInfo = { fg = colors.control_flow },
    DiagnosticHint = { fg = colors.property },
    DiagnosticUnderlineError = { undercurl = true, sp = colors.mutable },
    DiagnosticUnderlineWarn = { undercurl = true, sp = colors.type },
    DiagnosticUnderlineInfo = { undercurl = true, sp = colors.control_flow },
    DiagnosticUnderlineHint = { undercurl = true, sp = colors.property },
    
    -- TreeSitter specific groups with complexity-first highlighting
    -- Priority 1: Control Flow (HIGHEST PRIORITY - bold and prominent)
    ['@keyword.control'] = { fg = colors.control_flow, bold = true },
    ['@keyword.control.return'] = { fg = colors.control_flow, bold = true },
    ['@keyword.control.exception'] = { fg = colors.control_flow, bold = true },
    ['@keyword.control.conditional'] = { fg = colors.control_flow, bold = true },
    ['@keyword.control.repeat'] = { fg = colors.control_flow, bold = true },
    ['@keyword.control.import'] = { fg = colors.control_keyword },
    ['@exception'] = { fg = colors.control_flow, bold = true },
    ['@keyword.return'] = { fg = colors.control_flow, bold = true },
    ['@keyword.conditional'] = { fg = colors.control_flow, bold = true },
    ['@keyword.repeat'] = { fg = colors.control_flow, bold = true },
    ['@conditional'] = { fg = colors.control_flow, bold = true },
    ['@repeat'] = { fg = colors.control_flow, bold = true },
    
    -- Priority 2: Interfaces and Traits
    ['@type.interface'] = { fg = colors.interface },
    ['@type.parameter'] = { fg = colors.type_param },
    ['@storageclass.lifetime'] = { fg = colors.interface },
    ['@type.qualifier'] = { fg = colors.interface },
    
    -- Priority 3: Magic Numbers and Strings
    ['@number'] = { fg = colors.number },
    ['@number.float'] = { fg = colors.number },
    ['@float'] = { fg = colors.number },
    ['@string'] = { fg = colors.string },
    ['@string.regex'] = { fg = colors.string, bold = true },  -- Regex patterns are complex
    ['@string.escape'] = { fg = colors.property },
    ['@string.special'] = { fg = colors.property },
    ['@character'] = { fg = colors.string },
    ['@character.special'] = { fg = colors.property },
    ['@boolean'] = { fg = colors.enum_member },
    
    -- Priority 4: Mutation Operations
    ['@variable.member'] = { fg = colors.property },
    ['@variable.builtin'] = { fg = colors.control_keyword },
    ['@field'] = { fg = colors.property },
    ['@property'] = { fg = colors.property },
    
    -- Constants (potentially magic values)
    ['@constant'] = { fg = colors.constant },
    ['@constant.builtin'] = { fg = colors.enum_member },
    ['@constant.macro'] = { fg = colors.constant },
    
    -- Types (lower priority)
    ['@type'] = { fg = colors.type },
    ['@type.builtin'] = { fg = colors.type },
    ['@type.definition'] = { fg = colors.type },
    
    -- Functions and methods (minimal highlighting)
    ['@function'] = { fg = colors.fg },
    ['@function.builtin'] = { fg = colors.fg },
    ['@function.call'] = { fg = colors.fg },
    ['@function.macro'] = { fg = colors.macro },
    ['@function.method'] = { fg = colors.fg },
    ['@function.method.call'] = { fg = colors.fg },
    ['@method'] = { fg = colors.fg },
    ['@method.call'] = { fg = colors.fg },
    ['@constructor'] = { fg = colors.type },
    
    -- Variables (minimal highlighting)
    ['@variable'] = { fg = colors.fg },
    ['@variable.parameter'] = { fg = colors.fg },
    ['@variable.parameter.builtin'] = { fg = colors.fg },
    ['@parameter'] = { fg = colors.fg },
    
    -- Keywords (lower priority than control flow)
    ['@keyword'] = { fg = colors.control_keyword },
    ['@keyword.function'] = { fg = colors.control_keyword },
    ['@keyword.operator'] = { fg = colors.control_keyword },
    ['@keyword.storage'] = { fg = colors.control_keyword },
    ['@keyword.type'] = { fg = colors.type },
    ['@keyword.modifier'] = { fg = colors.control_keyword },
    ['@keyword.coroutine'] = { fg = colors.control_flow, bold = true },  -- Async is complex
    
    -- Comments
    ['@comment'] = { fg = colors.comment, italic = true },
    ['@comment.documentation'] = { fg = colors.comment },
    ['@comment.error'] = { fg = colors.mutable, bold = true },
    ['@comment.warning'] = { fg = colors.type, bold = true },
    ['@comment.todo'] = { fg = colors.control_flow, bold = true },
    ['@comment.note'] = { fg = colors.interface },
    
    -- Punctuation (minimal highlighting)
    ['@punctuation'] = { fg = colors.fg },
    ['@punctuation.delimiter'] = { fg = colors.fg },
    ['@punctuation.bracket'] = { fg = colors.fg },
    ['@punctuation.special'] = { fg = colors.property },
    
    -- Operators (minimal highlighting except assignment)
    ['@operator'] = { fg = colors.fg },
    ['@operator.assignment'] = { fg = colors.mutable },  -- Mutation indicator
    
    -- Attributes and annotations
    ['@attribute'] = { fg = colors.attribute },
    ['@attribute.builtin'] = { fg = colors.attribute },
    ['@annotation'] = { fg = colors.attribute },
    
    -- Namespaces and modules
    ['@namespace'] = { fg = colors.fg },
    ['@namespace.builtin'] = { fg = colors.fg },
    ['@module'] = { fg = colors.fg },
    ['@module.builtin'] = { fg = colors.fg },
    
    -- Labels (part of control flow)
    ['@label'] = { fg = colors.control_flow },
    
    -- Symbols
    ['@symbol'] = { fg = colors.constant },
    
    -- Tags (HTML/JSX)
    ['@tag'] = { fg = colors.control_flow },
    ['@tag.attribute'] = { fg = colors.property },
    ['@tag.delimiter'] = { fg = colors.fg },
    ['@tag.builtin'] = { fg = colors.control_flow },
    
    -- Markup
    ['@markup'] = { fg = colors.fg },
    ['@markup.strong'] = { bold = true },
    ['@markup.emphasis'] = { italic = true },
    ['@markup.underline'] = { underline = true },
    ['@markup.strike'] = { strikethrough = true },
    ['@markup.heading'] = { fg = colors.control_flow, bold = true },
    ['@markup.link'] = { fg = colors.control_flow, underline = true },
    ['@markup.link.url'] = { fg = colors.control_flow, underline = true },
    ['@markup.list'] = { fg = colors.property },
    ['@markup.list.checked'] = { fg = colors.string },
    ['@markup.list.unchecked'] = { fg = colors.mutable },
    ['@markup.raw'] = { fg = colors.string },
    ['@markup.math'] = { fg = colors.number },
    
    -- Diff
    ['@diff.plus'] = { fg = colors.diff_add },
    ['@diff.minus'] = { fg = colors.diff_delete },
    ['@diff.delta'] = { fg = colors.diff_change },
    
    -- Additional semantic tokens for complex patterns
    ['@function.recursive'] = { fg = colors.control_flow, bold = true, underline = true },
    ['@variable.mutation'] = { fg = colors.mutable, underline = true },
    ['@parameter.reference'] = { fg = colors.property, italic = true },
    ['@type.polymorphic'] = { fg = colors.interface, italic = true },
    
    -- Legacy Tree-sitter groups (for backwards compatibility)
    ['@text'] = { fg = colors.fg },
    ['@text.emphasis'] = { italic = true },
    ['@text.strong'] = { bold = true },
    ['@text.underline'] = { underline = true },
    ['@text.strike'] = { strikethrough = true },
    ['@text.uri'] = { fg = colors.control_flow, underline = true },
    
    -- Language specific
    ['@lsp.type.class'] = { fg = colors.type },
    ['@lsp.type.enum'] = { fg = colors.type },
    ['@lsp.type.interface'] = { fg = colors.interface },
    ['@lsp.type.struct'] = { fg = colors.type },
    ['@lsp.type.type'] = { fg = colors.type },
    ['@lsp.type.typeParameter'] = { fg = colors.type_param },
    ['@lsp.type.parameter'] = { fg = colors.fg },
    ['@lsp.type.variable'] = { fg = colors.fg },
    ['@lsp.type.property'] = { fg = colors.property },
    ['@lsp.type.enumMember'] = { fg = colors.enum_member },
    ['@lsp.type.function'] = { fg = colors.fg },
    ['@lsp.type.method'] = { fg = colors.fg },
    ['@lsp.type.macro'] = { fg = colors.macro },
    ['@lsp.type.decorator'] = { fg = colors.attribute },
    
    -- Git signs
    GitSignsAdd = { fg = colors.diff_add },
    GitSignsChange = { fg = colors.diff_change },
    GitSignsDelete = { fg = colors.diff_delete },
    
    -- Telescope
    TelescopeNormal = { fg = colors.fg, bg = colors.bg },
    TelescopeBorder = { fg = colors.border },
    TelescopeSelection = { bg = colors.selection },
    TelescopeSelectionCaret = { fg = colors.control_flow },
    TelescopeMultiSelection = { bg = colors.cursor_line },
    TelescopeMatching = { fg = colors.control_flow, bold = true },
    
    -- NvimTree
    NvimTreeNormal = { fg = colors.fg, bg = colors.bg },
    NvimTreeFolderIcon = { fg = colors.control_flow },
    NvimTreeFolderName = { fg = colors.fg },
    NvimTreeOpenedFolderName = { fg = colors.control_flow },
    NvimTreeEmptyFolderName = { fg = colors.inactive },
    NvimTreeRootFolder = { fg = colors.control_flow, bold = true },
    NvimTreeSpecialFile = { fg = colors.constant },
    NvimTreeExecFile = { fg = colors.string },
    NvimTreeGitDirty = { fg = colors.diff_change },
    NvimTreeGitNew = { fg = colors.diff_add },
    NvimTreeGitDeleted = { fg = colors.diff_delete },
    
    -- Indent Blankline
    IndentBlanklineChar = { fg = colors.border },
    IndentBlanklineContextChar = { fg = colors.inactive },
    
    -- WhichKey
    WhichKey = { fg = colors.control_flow },
    WhichKeyGroup = { fg = colors.type },
    WhichKeyDesc = { fg = colors.fg },
    WhichKeySeparator = { fg = colors.inactive },
    WhichKeyFloat = { bg = colors.widget_bg },
    
    -- Dashboard
    DashboardHeader = { fg = colors.control_flow },
    DashboardCenter = { fg = colors.fg },
    DashboardFooter = { fg = colors.inactive },
  }

  -- Apply highlights
  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end

  -- Terminal colors
  vim.g.terminal_color_0 = colors.cursor_line  -- Black
  vim.g.terminal_color_1 = colors.mutable       -- Red
  vim.g.terminal_color_2 = colors.string        -- Green
  vim.g.terminal_color_3 = colors.type          -- Yellow
  vim.g.terminal_color_4 = colors.control_flow  -- Blue
  vim.g.terminal_color_5 = colors.constant      -- Magenta
  vim.g.terminal_color_6 = colors.property      -- Cyan
  vim.g.terminal_color_7 = colors.fg            -- White
  vim.g.terminal_color_8 = colors.inactive      -- Bright Black
  vim.g.terminal_color_9 = colors.mutable       -- Bright Red
  vim.g.terminal_color_10 = '#6A775E'           -- Bright Green
  vim.g.terminal_color_11 = colors.type         -- Bright Yellow
  vim.g.terminal_color_12 = colors.control_keyword -- Bright Blue
  vim.g.terminal_color_13 = colors.constant     -- Bright Magenta
  vim.g.terminal_color_14 = colors.property     -- Bright Cyan
  vim.g.terminal_color_15 = colors.cursor       -- Bright White
end

M.setup()

return M