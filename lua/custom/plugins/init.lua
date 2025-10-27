-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { -- Tabs for open buffers
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "DaikyXendo/nvim-material-icon",
    config = function()
      local bufferline = require "bufferline"
      bufferline.setup {
        options = {
          mode = "buffers",
          style_preset = bufferline.style_preset.default,
          themable = true,
          numbers = "none",
          close_command = "bdelete! %d",
          right_mouse_command = "buffer %d",
          left_mouse_command = "buffer %d",
          middle_mouse_command = "bdelete! %d",
          indicator = { style = "underline" },
          diagnostics = "nvim_lsp",
          diagnostics_update_on_event = true,
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          show_tab_indicators = true,
          show_duplicate_prefix = true,
          separator_style = "thin",
          enforce_regular_tabs = false,
          show_close_icon = false,
          always_show_bufferline = true,
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
          offsets = {
            {
              filetype = "neo-tree",
              text = "Explorer",
              text_align = "left",
              separator = true,
            },
          },
          diagnostics_indicator = function(count, level, diagnostics_dict)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " " or (e == "warning" and " " or " ")
              s = s .. n .. sym
            end
            return s
          end,
        },
      }

      --- Keymaps
      -- Navigation
      vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })

      vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })

      vim.keymap.set("n", "<leader>u1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to visible buffer number [1]" })
      vim.keymap.set("n", "<leader>u2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to visible buffer number [2]" })
      vim.keymap.set("n", "<leader>u3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to visible buffer number [3]" })
      vim.keymap.set("n", "<leader>u4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to visible buffer number [4]" })
      vim.keymap.set("n", "<leader>u5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to visible buffer number [5]" })
      vim.keymap.set("n", "<leader>u6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to visible buffer number [6]" })
      vim.keymap.set("n", "<leader>u7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to visible buffer number [7]" })
      vim.keymap.set("n", "<leader>u8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to visible buffer number [8]" })
      vim.keymap.set("n", "<leader>u9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to visible buffer number [9]" })

      -- Movement
      vim.keymap.set("n", "<leader>uh", "<cmd>BufferLineMovePrev<CR>", { desc = "Move current buffer backwards" })
      vim.keymap.set("n", "<leader>ul", "<cmd>BufferLineMoveNext<CR>", { desc = "Move current buffer forward" })

      -- Closing
      vim.keymap.set("n", "<leader>ucc", "<cmd>bdelete<CR>", { desc = "[C]lose [C]urrent buffer" })
      vim.keymap.set("n", "<leader>uco", "<cmd>BufferLineCloseOthers<CR>", { desc = "[C]lose all [O]ther buffers" })
      vim.keymap.set("n", "<leader>uch", "<cmd>BufferLineCloseLeft<CR>", { desc = "[C]lose all buffers to the left" })
      vim.keymap.set("n", "<leader>ucl", "<cmd>BufferLineCloseRight<CR>", { desc = "[C]lose all buffers to the right" })

      vim.keymap.set("n", "<leader>w", "<cmd>bdelete<CR>", { desc = "Close current buffer" }) -- Shortcut

      -- Sorting
      vim.keymap.set(
        "n",
        "<leader>usd",
        "<cmd>BufferLineSortByDirectory<CR>",
        { desc = "[S]ort buffers by [D]irectory" }
      )
      vim.keymap.set(
        "n",
        "<leader>use",
        "<cmd>BufferLineSortByExtension<CR>",
        { desc = "[S]ort buffers by [E]xtension" }
      )

      -- Others
      vim.keymap.set("n", "<leader>up", "<cmd>BufferLineTogglePin<CR>", { desc = "[P]in current buffer" })
      vim.keymap.set("n", "<leader>uP", "<cmd>BufferLinePick<CR>", { desc = "[P]ick buffer" })
    end,
  },

  { -- Terminal
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup {
        size = 15,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        float_opts = {
          border = "curved",
        },
        close_on_exit = false,
        shell = vim.o.shell,
      }
    end,
  },

  { -- Color highlighting
    "catgoose/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        css_fn = true,
        tailwind = true,
        always_update = true,
      },
    },
  },

  { -- Scrollbar
    "petertriho/nvim-scrollbar",
    opts = {},
  },

  { -- Status line
    "nvim-lualine/lualine.nvim",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    opts = {
      options = {
        theme = "tomorrow_night",
      },
    },
  },

  -- Disabled until hover switch is back in working order
  -- { -- Hover
  --   "lewis6991/hover.nvim",
  --   config = function()
  --     require("hover").setup {
  --       --- List of modules names to load as providers.
  --       --- @type (string|Hover.Config.Provider)[]
  --       providers = {
  --         "hover.providers.diagnostic",
  --         "hover.providers.lsp",
  --         "hover.providers.dap",
  --         "hover.providers.man",
  --         "hover.providers.dictionary",
  --         -- Optional, disabled by default:
  --         -- 'hover.providers.gh',
  --         -- 'hover.providers.gh_user',
  --         -- 'hover.providers.jira',
  --         -- 'hover.providers.fold_preview',
  --         -- 'hover.providers.highlight',
  --       },
  --       preview_opts = {
  --         border = "single",
  --       },
  --       -- Whether the contents of a currently open hover window should be moved
  --       -- to a :h preview-window when pressing the hover keymap.
  --       preview_window = false,
  --       title = true,
  --     }
  --
  --     -- Keymaps
  --     vim.keymap.set("n", "K", function()
  --       require("hover").open()
  --     end, { desc = "hover.nvim (open)" })
  --
  --     vim.keymap.set("n", "gK", function()
  --       require("hover").enter()
  --     end, { desc = "hover.nvim (enter)" })
  --
  --     vim.keymap.set("n", "<leader><left>", function()
  --       require("hover").switch "previous"
  --     end, { desc = "hover.nvim (previous source)" })
  --
  --     vim.keymap.set("n", "<leader><right>", function()
  --       require("hover").switch "next"
  --     end, { desc = "hover.nvim (next source)" })
  --   end,
  -- },
}
