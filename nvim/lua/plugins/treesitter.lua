-- Tree-sitter configuration

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- List of parsers to install
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "dockerfile",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- Highlighting
        highlight = {
          enable = true,
          -- Disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          additional_vim_regex_highlighting = false,
        },

        -- Indentation
        indent = {
          enable = true,
          disable = { "yaml" },
        },

        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },

        -- Text objects
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["as"] = "@statement.outer",
              ["is"] = "@statement.inner",
            },
            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]l"] = "@loop.outer",
              ["]a"] = "@parameter.outer",
              ["]b"] = "@block.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]L"] = "@loop.outer",
              ["]A"] = "@parameter.outer",
              ["]B"] = "@block.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[l"] = "@loop.outer",
              ["[a"] = "@parameter.outer",
              ["[b"] = "@block.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[L"] = "@loop.outer",
              ["[A"] = "@parameter.outer",
              ["[B"] = "@block.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sa"] = "@parameter.inner",
              ["<leader>sf"] = "@function.outer",
            },
            swap_previous = {
              ["<leader>sA"] = "@parameter.inner",
              ["<leader>sF"] = "@function.outer",
            },
          },
        },
      })

      -- Tree-sitter based folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- Disable folding at startup
    end,
  },

  -- Tree-sitter context (shows current function/class at top of screen)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 3,
      min_window_height = 0,
      line_numbers = true,
      multiline_threshold = 20,
      trim_scope = "outer",
      mode = "cursor",
      separator = nil,
      zindex = 20,
    },
  },

  -- Autotag for HTML/JSX
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
        -- Per filetype config
        per_filetype = {
          ["html"] = {
            enable_close = true,
          },
          ["jsx"] = {
            enable_close = true,
          },
          ["tsx"] = {
            enable_close = true,
          },
          ["vue"] = {
            enable_close = true,
          },
          ["svelte"] = {
            enable_close = true,
          },
          ["xml"] = {
            enable_close = true,
          },
        },
      })
    end,
  },
}