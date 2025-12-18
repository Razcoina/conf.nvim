--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- "undeclared variable" fix for up Laravel
Laravel = nil

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Show current line and column in the corner
vim.o.ruler = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Enable 24-bit RGB colors
vim.o.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Draw vertical rulers at columns 80 and 120
vim.o.colorcolumn = "80,120"

-- Force indentation to be spaces instead of tab, and 2 spaces long
vim.o.expandtab = true -- convert tabs to spaces
vim.o.shiftwidth = 2 -- size of indent
vim.o.tabstop = 2 -- how many spaces a <Tab> counts for
vim.o.smartindent = true -- auto-indent new lines

-- Use Treesitter for folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Start with all folds open
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank { timeout = 500 }
  end,
})

-- Simple auto-save without triggering auto-format
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    if vim.bo.modified then
      vim.cmd "silent! write"
    end
  end,
})

-- Restore cursor to the last edit position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  desc = "Return cursor to last edit position",
  group = vim.api.nvim_create_augroup("kickstart-restore-cursor", { clear = true }),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespace before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Trim trailing whitespace",
  group = vim.api.nvim_create_augroup("kickstart-trim-whitespace", { clear = true }),
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd [[ %s/\s\+$//e ]]
    vim.fn.winrestview(save)
  end,
})

-- Auto reload files changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  desc = "Reload file if changed outside of Neovim",
  group = vim.api.nvim_create_augroup("kickstart-autoreload", { clear = true }),
  command = "checktime",
})

-- Convert tabs to spaces when saving
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Convert tabs to spaces",
  group = vim.api.nvim_create_augroup("kickstart-retab", { clear = true }),
  callback = function()
    vim.cmd "retab"
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Helper functions and variables ]]
-- get global node_modules path
local npm_root_global = vim.fn.system("npm root -g"):gsub("\n", "")

-- give eslint_d the pid of nvim
vim.env.ESLINT_D_PPID = vim.fn.getpid()

-- Set Xdebug idekey to allow for easy debugging
vim.env.XDEBUG_CONFIG = "idekey=NEOVIM"

-- Optimizations for Go
vim.env.CGO_ENABLED = "1"

--- Find config file with project override
--- Checks for a local config in cwd first. If present, return nil (let tool use it).
--- If not, fall back to a global config in stdpath('config').
--- @param basenames string[] List of possible config filenames (without directory)
--- @return string|nil Path to global config if no local config is found, otherwise nil
local function resolve_config(basenames)
  local cwd = vim.fn.getcwd()
  local configdir = vim.fn.stdpath "config"

  -- 1. Look for any matching local config
  for _, name in ipairs(basenames) do
    local local_path = cwd .. "/" .. name
    if vim.fn.filereadable(local_path) == 1 then
      return nil -- found project config, let tool use it
    end
  end

  -- 2. Fall back to global config in stdpath("config")
  for _, name in ipairs(basenames) do
    local global_path = configdir .. "/" .. name
    if vim.fn.filereadable(global_path) == 1 then
      return global_path
    end
  end

  -- 3. Nothing found
  return nil
end

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  "NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically

  "tpope/vim-fugitive", -- A Git wrapper so awesome, it should be illegal

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },
      },

      -- Document existing key chains
      spec = {
        { "<leader>s", group = "[S]earch" },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        { "<leader>sD", group = "[S]earch [D]ebug" },
        { "gr", group = "LSP: Code Actions" },
        { "<leader>l", group = "[L]aravel" },
        { "<leader>u", group = "B[u]fferLine" },
        { "<leader>uc", group = "[C]lose" },
        { "<leader>us", group = "[S]ort" },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-dap.nvim",
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        "nvim-telescope/telescope-fzf-native.nvim",

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = "make",

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { "DaikyXendo/nvim-material-icon", enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ["ui-select"] = { require("telescope.themes").get_dropdown() },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")
      pcall(require("telescope").load_extension, "dap")

      -- See `:help telescope.builtin`
      local builtin = require "telescope.builtin"
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- See `:help telescope-dap`
      local dap = require("telescope").extensions.dap
      vim.keymap.set("n", "<leader>sDd", dap.commands, { desc = "[S]earch [D]AP [D]ebug commands" })
      vim.keymap.set("n", "<leader>sDc", dap.configurations, { desc = "[S]earch [D]AP [C]onfigurations" })
      vim.keymap.set("n", "<leader>sDb", dap.list_breakpoints, { desc = "[S]earch [D]AP [B]reakpoints" })
      vim.keymap.set("n", "<leader>sDv", dap.variables, { desc = "[S]earch [D]AP [V]ariables" })
      vim.keymap.set("n", "<leader>sDf", dap.frames, { desc = "[S]earch [D]AP [F]rames" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files { cwd = vim.fn.stdpath "config" }
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },

  { -- Main LSP Configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { "mason-org/mason.nvim", opts = {} },
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      { "j-hui/fidget.nvim", opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      "saghen/blink.cmp",

      -- JSON schemas for Neovim
      "b0o/schemastore.nvim",
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, {
              buffer = event.buf,
              desc = "LSP: " .. desc,
            })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

          -- Find references for the word under your cursor.
          map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map("grs", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map("grw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

          -- Run the CodeLens action available on the current line.
          map("grc", vim.lsp.codelens.run, "[G]oto [R]un [C]odelens")

          -- Toggle inlay hints in your code.
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, "[T]oggle Inlay [H]ints")

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has "nvim-0.11" == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
          then
            local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds {
                  group = "kickstart-lsp-highlight",
                  buffer = event2.buf,
                }
              end,
            })
          end

          -- The following autocommand and updates codelens when needed
          vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
            group = vim.api.nvim_create_augroup("kickstart-lsp-codelens", { clear = true }),
            callback = function()
              vim.lsp.codelens.refresh { bufnr = 0 }
            end,
          })
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- Ensure the servers and other tools are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      local tools = {
        -- LSPs
        "clangd", -- C/C++
        "neocmakelsp", --CMake
        "css-lsp", -- CSS
        "gopls", -- Go
        "html-lsp", -- HTML
        "jdtls", -- Java
        "vtsls", -- JavaScript/TypeScript
        "json-lsp", -- JSON
        "kotlin-lsp", -- Kotlin
        "lua-language-server", -- lua
        "marksman", -- Markdown
        "intelephense", -- PHP
        "zuban", -- Python
        "bash-language-server", -- Shell
        "taplo", -- TOML
        "vue-language-server", -- Vue
        "lemminx", -- XML
        "yaml-language-server", -- YAML
        "ltex-ls-plus", -- Markdown, Text, others

        -- Linters
        -- "stylelint", -- CSS (instelled through npm)
        "golangci-lint", -- Go (also formatter)
        -- "markuplint", -- HTML (instelled through npm)
        "checkstyle", -- Java
        -- "eslint_d", -- JavaScript/TypeScript (instelled through npm)
        "ktlint", -- Kotlin (also formatter)
        "checkmake", -- Makefile
        "markdownlint", -- Markdown
        "yamllint", -- YAML

        -- Formatters
        "blade-formatter", -- Blade
        "clang-format", -- C/C++
        "gersemi", -- CMake
        "google-java-format", -- Java
        "stylua", -- Lua
        "php-cs-fixer", -- PHP
        "isort", -- Python
        "black", -- Python
        "beautysh", -- Shell
        "xmlformatter", -- XML
        "prettier", -- HTML, CSS, JavaScript, TypeScript, Markdown, JSON, Vue

        -- DAPs (Debuggers)
        "codelldb", -- C/C++
        "delve", -- Go
        "java-debug-adapter", -- Java
        "java-test", -- Java
        "firefox-debug-adapter", -- JavaScript/TypeScript (web debug)
        "js-debug-adapter", -- JavaScript/TypeScript (everything else)
        "kotlin-debug-adapter", -- Kotlin
        "local-lua-debugger-vscode", -- Lua
        "php-debug-adapter", -- PHP
        "debugpy", -- Python
      }

      require("mason-tool-installer").setup { ensure_installed = tools }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- Get project name and workspace directory (JAVA specific)
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      local workspace_dir = vim.fn.stdpath "cache" .. "/jdtls/" .. project_name

      -- Config file location for Taplo (TOML specific)
      local taplo_config = resolve_config { ".taplo.toml", "taplo.toml" }
      local taplo_arg = taplo_config and { "--config", taplo_config } or {}

      -- Language servers initialization and configuration
      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs

      vim.lsp.config("clangd", { -- C/C++
        cmd = {
          vim.fn.stdpath "data" .. "/mason/bin/clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--log=verbose",
        },
        root_markers = {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git",
        },
      })

      vim.lsp.config("neocmake", { -- CMake
        cmd = { "neocmakelsp", "--stdio" },
        filetypes = { "cmake" },
        single_file_support = true,
        capabilities = require("blink.cmp").get_lsp_capabilities {
          textDocument = {
            completion = {
              completionItem = { snippetSupport = true },
            },
          },
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
              relative_pattern_support = true,
            },
          },
        },
        init_options = {
          format = { enable = true }, -- enable LSP formatting
          lint = { enable = true }, -- enable built-in linter
          scan_cmake_in_package = true, -- deep scan
          semantic_token = false, -- let Treesitter handle highlights
        },
      })

      vim.lsp.config("cssls", { -- CSS
        settings = {
          css = {
            format = { enable = false },
            validate = false,
          },
          less = {
            format = { enable = false },
            validate = false,
          },
          scss = {
            format = { enable = false },
            validate = false,
          },
        },
      })

      vim.lsp.config("dartls", { -- Dart
        init_options = {
          onlyAnalyzeProjectsWithOpenFiles = false,
        },
        settings = {
          dart = {
            lineLength = 120,
            completeFunctionCalls = true,
            showTodos = true,
            renameFilesWithClasses = "always",
            enableSnippets = true,
            updateImportsOnRename = true,
            inlayHints = true,
          },
        },
      })

      vim.lsp.config("gopls", {}) -- Go

      vim.lsp.config("html", { -- HTML
        settings = {
          html = {
            completion = {
              attributeDefaultValue = "singlequotes",
            },
            format = { enable = false },
          },
        },
        filetypes = { "html", "templ", "php" },
      })

      vim.lsp.config("jdtls", { -- Java
        cmd = {
          vim.fn.stdpath "data" .. "/mason/bin/jdtls",
          "-configuration",
          vim.fn.stdpath "cache" .. "/jdtls/config",
          "-data",
          workspace_dir,
        },
        workspace_folders = {
          {
            uri = vim.uri_from_fname(vim.fn.getcwd()),
            name = project_name,
          },
        },
        init_options = {
          bundles = {
            vim.fn.glob(
              vim.fn.stdpath "data"
                .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
              true
            ),
          },
        },
        settings = {
          java = {
            autobuild = { enabled = false },
            eclipse = { downloadSources = true },
            format = { enabled = false },
            implementationCodeLens = "all",
            import = {
              gradle = {
                enabled = true,
                annotationProcessing = true,
                offline = false,
              },
              maven = {
                enabled = true,
                offline = false,
              },
            },
            maven = {
              downloadSources = true,
              updateSnapshots = true,
            },
            inlayHints = { parameterNames = { enabled = "all" } },
            jdt = {
              ls = {
                androidSupport = { enabled = true },
                javac = { enabled = false },
                protobufSupport = { enabled = true },
              },
            },
            maxConcurrentBuilds = 4,
            references = {
              includeAccessors = true,
              includeDecompiledSources = true,
            },
            saveActions = { organizeImports = true, cleanup = false },
            signatureHelp = {
              enabled = true,
              description = { enabled = true },
            },
            edit = {
              validateAllOpenBuffersOnChanges = true,
              smartSemicolonDetection = { enabled = true },
            },
            telemetry = { enabled = false },
          },
          redhat = { telemetry = { enabled = false } },
        },
      })

      vim.lsp.config("vtsls", { -- JavaScript/TypeScript
        settings = {
          javascript = {
            format = { enable = false },
            inlayHints = {
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = true },
            },
            preferences = {
              organizeImports = {
                unicodeCollation = "unicode",
                accentCollation = true,
                caseFirst = "upper",
                caseSensitivity = "caseSensitive",
                locale = "auto",
                numericCollation = true,
                typeOrder = "last",
              },
            },
            referencesCodeLens = {
              enabled = true,
              showOnAllFunctions = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = { enabled = "always" },
            validate = { enable = true },
          },
          ["js/ts"] = {
            implicitProjectConfig = {
              checkJs = true,
              experimentalDecorators = true,
            },
          },
          typescript = {
            format = { enable = false },
            implementationsCodeLens = {
              enabled = true,
              showOnInterfaceMethods = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = true },
            },
            preferences = {
              organizeImports = {
                unicodeCollation = "unicode",
                accentCollation = true,
                caseFirst = "upper",
                caseSensitivity = "caseSensitive",
                locale = "auto",
                numericCollation = true,
                typeOrder = "last",
              },
              preferTypeOnlyAutoImports = true,
            },
            referencesCodeLens = {
              enabled = true,
              showOnAllFunctions = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            tsserver = {
              maxTsServerMemory = 4096,
              node = "node",
              watchOptions = {
                fallbackPolling = "dynamicPriorityPolling",
                synchronousWatchDirectory = false,
                watchDirectory = "useFsEvents",
                watchFile = "useFsEvents",
              },
            },
            updateImportsOnFileMove = { enabled = "always" },
            validate = { enable = true },
          },
          vtsls = {
            autoUseWorkspaceTsdk = true,
            tsserver = {
              globalPlugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vim.fn.expand "$MASON/packages"
                    .. "/vue-language-server"
                    .. "/node_modules/@vue/language-server",
                  languages = { "vue" },
                  configNamespace = "typescript",
                },
              },
            },
          },
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      })

      vim.lsp.config("jsonls", { -- JSON
        settings = {
          format = { enable = false },
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      vim.lsp.config("kotlin-lsp", { -- Kotlin
        cmd = { vim.fn.stdpath "data" .. "/mason/bin/kotlin-lsp", "--stdio" },
        filetypes = { "kotlin" },
        root_markers = {
          "settings.gradle",
          "settings.gradle.kts",
          "pom.xml",
          "build.gradle",
          "build.gradle.kts",
          "workspace.json",
        },
      })

      vim.lsp.config("lua_ls", { -- Lua
        cmd = { vim.fn.stdpath "data" .. "/mason/bin/lua-language-server" },
        settings = {
          Lua = {
            codeLens = { enable = true },
            diagnostics = {
              workspaceEvent = "OnChange",
            },
            format = { enable = false },
            completion = {
              callSnippet = "Both",
              keywordSnippet = "Both",
            },
            telemetry = { enable = false },
          },
        },
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath "config"
              and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
            then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using (most
              -- likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
              -- Tell the language server how to find Lua modules same way as Neovim
              -- (see `:h lua-module-load`)
              path = { "lua/?.lua", "lua/?/init.lua" },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                -- Depending on the usage, you might want to add additional paths here.
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
              -- Or pull in all of 'runtimepath'.
              -- NOTE: this is a lot slower and will cause issues when working on
              -- your own configuration.
              -- See https://github.com/neovim/nvim-lspconfig/issues/3189
              -- library = {
              --   vim.api.nvim_get_runtime_file('', true),
              -- }
            },
          })
        end,
      })

      vim.lsp.config("marksman", {}) -- Markdown

      vim.lsp.config("intelephense", { -- PHP
        init_options = {
          globalStoragePath = vim.fn.expand "$XDG_CONFIG_HOME" .. "/intelephense/storage",
          licenceKey = vim.fn.expand "$XDG_CONFIG_HOME" .. "/intelephense/key.txt",
        },
        settings = {
          intelephense = {
            codeLens = {
              implementations = { enable = true },
              overrides = { enable = true },
              parent = { enable = true },
              references = { enable = true },
              usages = { enable = true },
            },
            completion = { suggestObjectOperatorStaticMethods = true },
            -- files = {},
            format = { enable = false },
            phpdoc = { useFullyQualifiedNames = true },
            references = {
              exclude = {
                "**/vendor/**",
                "**/storage/**",
                "**/cache/**",
                "**/node_modules/**",
              },
            },
            rename = {
              exclude = {
                "**/vendor/**",
                "**/storage/**",
                "**/cache/**",
                "**/node_modules/**",
              },
              namespaceMode = "all",
            },
            telemetry = { enabled = false },
            trace = { server = "messages" },
          },
        },
      })

      vim.lsp.config("zuban", { -- Python
        cmd_env = {
          VIRTUAL_ENV = os.getenv "CONDA_PREFIX",
        },
      })

      vim.lsp.config("bashls", { -- Shell
        filetypes = { "bash", "sh", "zsh" },
      })

      vim.lsp.config("taplo", { -- TOML
        cmd = vim.list_extend(
          { "taplo", "lsp" }, -- base command
          vim.list_extend(taplo_arg, { "stdio" }) -- append taplo_arg and "stdio"
        ),
        root_markers = { "" },
      })

      vim.lsp.config("vue_ls", { -- Vue
        settings = {
          vue = {
            inlayHints = {
              destructuredProps = true,
              inlineHandlerLeading = true,
              missingProps = true,
              optionsWrapper = true,
              vBindShorthand = true,
            },
            trace = { server = "messages" },
          },
        },
      })

      vim.lsp.config("lemminx", {}) -- XML

      vim.lsp.config("yamlls", { -- YAML
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            format = { enable = false },
            schemas = require("schemastore").yaml.schemas(),
            schemaStore = {
              enable = false,
              url = "",
            },
          },
        },
      })

      vim.lsp.config("ltex_plus", {}) -- Markdown, Text, others

      -- Enable all LSPs with specified configs
      vim.lsp.enable {
        "clangd", -- C/C++
        "neocmake", -- CMake
        "cssls", -- CSS
        "dartls", -- Dart
        "gopls", -- Go
        "html", -- HTML
        "jdtls", -- Java
        "vtsls", -- JavaScript/TypeScript
        "jsonls", -- JSON
        "kotlin-lsp", -- Kotlin
        "lua_ls", -- Lua
        "marksman", -- Markdown
        "intelephense", -- PHP
        "zuban", -- Python
        "bashls", -- Shell
        "taplo", -- TOML
        "vue_ls", -- Vue
        "lemminx", -- XML
        "yamlls", -- YAML
        "ltex_plus", -- Markdown, Text, others
      }
    end,
  },

  { -- Linting
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        blade = { "markuplint", "stylelint", "eslint_d" },
        css = { "stylelint" },
        less = { "stylelint" },
        scss = { "stylelint" },
        go = { "golangcilint" },
        html = { "markuplint", "stylelint", "eslint_d" },
        java = { "checkstyle" },
        javascript = { "eslint_d" },
        kotlin = { "ktlint" },
        make = { "checkmake" },
        markdown = { "markdownlint" },
        php = { "markuplint", "stylelint", "eslint_d" },
        typescript = { "eslint_d" },
        vue = { "markuplint", "stylelint", "eslint_d" },
        yaml = { "yamllint" },
      }

      -- Linters settings
      -- CSS
      local stylelintconfigPath = resolve_config {
        "stylelint.config.mjs",
        "stylelint.config.cjs",
        "stylelint.config.js",
      }
      local stylelint = lint.linters.stylelint

      if stylelintconfigPath then
        stylelint.args = vim.list_extend(
          stylelint.args or {},
          { "--config-basedir", npm_root_global, "--config", stylelintconfigPath }
        )
      end

      -- Go
      local golangciPath = resolve_config {
        ".golangci.yml",
        ".golangci.yaml",
        ".golangci.toml",
        ".golangci.json",
      }
      local golangci = lint.linters.golangcilint

      if golangciPath then
        golangci.args = vim.list_extend(golangci.args or {}, { "--config", golangciPath })
      end

      -- HTML
      local markuplintrcPath = resolve_config {
        ".markuplintrc",
        ".markuplintrc.json",
        ".markuplintrc.yaml",
        ".markuplintrc.yml",
        ".markuplintrc.js",
        ".markuplintrc.cjs",
        ".markuplintrc.ts",
        "markuplint.config.js",
        "markuplint.config.cjs",
        "markuplint.config.ts",
      }
      local markuplint = lint.linters.markuplint

      if markuplintrcPath then
        markuplint.args = vim.list_extend(markuplint.args or {}, { "--config", markuplintrcPath })
      end

      -- JavaScript/TypeScript
      local eslintconfigPath = resolve_config {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
      }
      local eslint = lint.linters.eslint_d

      if eslintconfigPath then
        eslint.args = vim.list_extend(eslint.args or {}, { "--config", eslintconfigPath })
      end

      -- Kotlin
      local ktlint_config = resolve_config { ".editorconfig" }
      local ktlint = lint.linters.ktlint

      if ktlint_config then
        ktlint.args = vim.list_extend(ktlint.args or {}, { "--editorconfig=" .. ktlint_config })
      end

      -- YAML
      local yamllint_config = resolve_config { ".yamllint", ".yamllint.yaml", ".yamllint.yml" }
      local yamllint = lint.linters.yamllint

      if yamllint_config then
        yamllint.args = vim.list_extend(yamllint.args or {}, { "--config-file ", yamllint_config })
      end

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.bo.modifiable then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  { -- Autoformat
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format {
            async = true,
            lsp_format = "fallback",
          }
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    config = function()
      -- Locations of config files
      local bladeformatterrcPath = resolve_config { ".bladeformatterrc.json", ".bladeformatterrc" } -- Blade
      local clangFormatPath = resolve_config { ".clang-format" } -- C/C++
      local gersemircPath = resolve_config { ".gersemirc" } -- CMake
      local golangciPath = resolve_config { -- Go
        ".golangci.yml",
        ".golangci.yaml",
        ".golangci.toml",
        ".golangci.json",
      }
      local editorconfigPath = resolve_config { ".editorconfig" } -- Kotlin
      local styluaPath = resolve_config { ".stylua.toml", "stylua.toml" } -- Lua
      local phpcsfixerPath = resolve_config { ".php-cs-fixer.dist.php" } -- PHP
      local blackConfigPath = resolve_config { "pyproject.toml" } -- Python
      local prettierrcPath = resolve_config { -- HTML, CSS, JavaScript, TypeScript, Markdown, JSON, Vue
        ".prettierrc",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettierrc.json5",
        ".prettierrc.js",
        "prettier.config.js",
        ".prettierrc.ts",
        "prettier.config.ts",
        ".prettierrc.mjs",
        "prettier.config.mjs",
        ".prettierrc.mts",
        "prettier.config.mts",
        ".prettierrc.cjs",
        "prettier.config.cjs",
        ".prettierrc.cts",
        "prettier.config.cts",
        ".prettierrc.toml",
      }
      local stylelintconfigPath = resolve_config { -- CSS extra
        "stylelint.config.mjs",
        "stylelint.config.cjs",
        "stylelint.config.js",
      }

      require("conform").setup {
        notify_on_error = true,

        -- For debugging, uncomment the next line and run :ConformInfo
        -- log_level = vim.log.levels.DEBUG,

        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },

        formatters_by_ft = {
          blade = { "stylelint", "blade-formatter" },
          c = { "clang-format" },
          cpp = { "clang-format" },
          cmake = { "gersemi" },
          css = { "stylelint", "prettier" },
          go = { "golangci-lint" },
          less = { "stylelint", "prettier" },
          scss = { "stylelint", "prettier" },
          html = { "stylelint", "prettier" },
          java = { "google-java-format" },
          javascript = { "prettier" },
          json = { "prettier" },
          json5 = { "prettier" },
          jsonc = { "prettier" },
          kotlin = { "ktlint" },
          lua = { "stylua" },
          markdown = { "prettier" },
          php = { "stylelint", "php_cs_fixer" },
          python = { "isort", "black" },
          typescript = { "prettier" },
          bash = { "beautysh" },
          sh = { "beautysh" },
          zsh = { "beautysh" },
          vue = { "stylelint", "prettier" },
          xml = { "xmlformatter" },
          yaml = { "prettier" },
        },

        -- formatter settings
        formatters = {
          ["blade-formatter"] = { -- Blade
            append_args = bladeformatterrcPath and { "--config", bladeformatterrcPath } or {},
          },
          ["clang-format"] = { -- C/C++
            append_args = clangFormatPath and { "--style=file:" .. clangFormatPath, "--fallback-style=LLVM" }
              or { "--style=file", "--fallback-style=LLVM" },
          },
          gersemi = { -- CMake
            append_args = gersemircPath and { "--config", gersemircPath } or {},
          },
          ["golangci-lint"] = {
            append_args = golangciPath and { "--config", golangciPath } or {},
          },
          ktlint = { -- Kotlin
            append_args = editorconfigPath and { "--editorconfig=" .. editorconfigPath } or {},
          },
          stylua = { -- Lua
            append_args = styluaPath and { "--config-path", styluaPath } or {},
          },
          php_cs_fixer = { -- PHP
            append_args = phpcsfixerPath and { "--config=" .. phpcsfixerPath } or {},
          },
          black = { -- Python
            append_args = blackConfigPath and { "--config", blackConfigPath } or {},
          },
          beautysh = { -- Shell
            append_args = { "--indent-size", 2, "--force-function-style", "paronly" },
          },
          xmlformatter = { -- XML
            append_args = {
              "--indent",
              "2",
              "--selfclose",
              "--eof-newline",
              "--preserve",
              "pre,literal",
              "--blanks",
            },
          },
          prettierd = { -- HTML, CSS, JavaScript, TypeScript, Markdown, JSON, Vue
            append_args = prettierrcPath and { "--config", prettierrcPath } or {},
          },
          stylelint = { -- CSS extra
            append_args = stylelintconfigPath
                and { "--config-basedir", npm_root_global, "--config", stylelintconfigPath }
              or {},
          },
        },
      }
    end,
  },

  { -- Debugging
    "mfussenegger/nvim-dap",

    dependencies = {
      -- Creates a beautiful debugger UI
      "rcarriga/nvim-dap-ui",

      -- Inlines the values for variables as virtual text
      { "theHamsta/nvim-dap-virtual-text", opts = { virt_text_pos = "eol" } },

      -- Required dependency for nvim-dap-ui
      "nvim-neotest/nvim-nio",

      -- Installs the debug adapters for you
      "mason-org/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",

      -- Add your own debuggers here
      -- Java must have 'mfussenegger/nvim-dap' as a dependency so it cannot be here
      "leoluz/nvim-dap-go", -- go
    },
    keys = {
      -- Basic debugging keymaps, feel free to change to your liking!
      {
        "<F5>",
        function()
          -- Auto discover Java classes and start debugging
          -- For every other file type, just start debugging
          if vim.bo.filetype == "java" then
            local jdtls_dap = require "jdtls.dap"

            jdtls_dap.setup_dap_main_class_configs {
              verbose = true,

              on_ready = function()
                require("dap").continue()
              end,
            }
          else
            require("dap").continue()
          end
        end,
        desc = "Debug: Start/Continue",
      },
      {
        "<F1>",
        function()
          require("dap").step_into()
        end,
        desc = "Debug: Step Into",
      },
      {
        "<F2>",
        function()
          require("dap").step_over()
        end,
        desc = "Debug: Step Over",
      },
      {
        "<F3>",
        function()
          require("dap").step_out()
        end,
        desc = "Debug: Step Out",
      },
      {
        "<F4>",
        function()
          require("dap").step_back()
        end,
        desc = "Debug: Step Back",
      },
      {
        "<leader>b",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Debug: Toggle Breakpoint",
      },
      {
        "<leader>B",
        function()
          require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
        end,
        desc = "Debug: Set Breakpoint",
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      {
        "<F6>",
        function()
          require("dap").terminate { all = true, hierarchy = true }
        end,
        desc = "Debug: Terminate all sessions",
      },
      {
        "<F7>",
        function()
          require("dapui").toggle()
        end,
        desc = "Debug: See last session result",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      require("mason-nvim-dap").setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          "codelldb", -- C/C++
          "delve", -- Go
          "java-debug-adapter", -- Java
          "java-test", -- Java
          "firefox-debug-adapter", -- JavaScript/TypeScript (web debug)
          "js-debug-adapter", -- JavaScript/TypeScript (everything else)
          "kotlin-debug-adapter", -- Kotlin
          "local-lua-debugger-vscode", -- Lua
          "php-debug-adapter", -- PHP
          "debugpy", -- Python
        },
      }

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = {
          expanded = "▾",
          collapsed = "▸",
          current_frame = "*",
        },
        controls = {
          icons = {
            pause = "⏸",
            play = "▶",
            step_into = "⏎",
            step_over = "⏭",
            step_out = "⏮",
            step_back = "b",
            run_last = "▶▶",
            terminate = "⏹",
            disconnect = "⏏",
          },
        },
      }

      -- Change breakpoint icons
      vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
      vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
      local breakpoint_icons = vim.g.have_nerd_font
          and {
            Breakpoint = "",
            BreakpointCondition = "",
            BreakpointRejected = "",
            LogPoint = "",
            Stopped = "",
          }
        or {
          Breakpoint = "●",
          BreakpointCondition = "⊜",
          BreakpointRejected = "⊘",
          LogPoint = "◆",
          Stopped = "⭔",
        }
      for type, icon in pairs(breakpoint_icons) do
        local tp = "Dap" .. type
        local hl = (type == "Stopped") and "DapStop" or "DapBreak"
        vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
      end

      -- Automatically open DAP-UI and focus the REPL in insert mode
      dap.listeners.after.event_initialized["repl_focus"] = function()
        -- Open DAP-UI if not already open
        dapui.open()

        -- Find the REPL window
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype == "dap-repl" then
            -- Focus the REPL window
            vim.api.nvim_set_current_win(win)
            -- Optional: Enter insert mode
            -- vim.cmd 'startinsert'
            break
          end
        end
      end

      dap.defaults.fallback.external_terminal = {
        command = "/usr/bin/konsole",
        args = { "-e" },
      }
      dap.defaults.fallback.focus_terminal = true

      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Adapter definitions & configurations
      require "dap_config.dart"
      require "dap_config.html"
      require "dap_config.javascript"
      require "dap_config.kotlin"
      require "dap_config.lua"
      require "dap_config.python"

      -- Install golang specific config
      require("dap-go").setup {
        delve = {
          -- On Windows delve must be run attached or it crashes.
          -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
          detached = vim.fn.has "win32" == 0,
        },
        tests = {
          -- enables verbosity when running the test.
          verbose = true,
        },
      }
    end,
  },

  -- Extra features for Java
  { "mfussenegger/nvim-jdtls", dependencies = { "mfussenegger/nvim-dap" } },

  { -- Extra features for Laravel
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<leader>ll",
        function()
          Laravel.pickers.laravel()
        end,
        desc = "Laravel: Open Laravel Picker",
      },
      {
        "<leader>lv",
        function()
          Laravel.commands.run "view:finder"
        end,
        desc = "Laravel: Open View Finder",
      },
      {
        "<leader>la",
        function()
          Laravel.pickers.artisan()
        end,
        desc = "Laravel: Open Artisan Picker",
      },
      {
        "<leader>lt",
        function()
          Laravel.commands.run "actions"
        end,
        desc = "Laravel: Open Actions Picker",
      },
      {
        "<leader>lr",
        function()
          Laravel.pickers.routes()
        end,
        desc = "Laravel: Open Routes Picker",
      },
      {
        "<leader>lh",
        function()
          Laravel.run "artisan docs"
        end,
        desc = "Laravel: Open Documentation",
      },
      {
        "<leader>lm",
        function()
          Laravel.pickers.make()
        end,
        desc = "Laravel: Open Make Picker",
      },
      {
        "<leader>lc",
        function()
          Laravel.pickers.commands()
        end,
        desc = "Laravel: Open Commands Picker",
      },
      {
        "<leader>lo",
        function()
          Laravel.pickers.resources()
        end,
        desc = "Laravel: Open Resources Picker",
      },
      {
        "<leader>lp",
        function()
          Laravel.commands.run "command_center"
        end,
        desc = "Laravel: Open Command Center",
      },
    },
    event = { "VeryLazy" },
    opts = {
      lsp_server = "intelephense",
      features = {
        pickers = {
          provider = "telescope",
        },
      },
    },
  },

  { -- Blade navigation (Laravel)
    "ricardoramirezr/blade-nav.nvim",
    dependencies = { "saghen/blink.cmp" },
    ft = { "blade", "php" },
    opts = {},
  },

  { -- Autocompletion
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = {
      -- Snippet Engine
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load()
              require("luasnip").filetype_extend("php", { "html" }) -- Use html snippets in php files
              require("luasnip").filetype_extend("blade", { "html" }) -- Use html snippets in blade files
            end,
          },
        },
        opts = {},
      },

      { -- Allow loading nvim-cmp sources
        "Saghen/blink.compat",
        -- use v2.* for blink.cmp v1.*
        version = "2.*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
      },

      "folke/lazydev.nvim",
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = "super-tab",

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { "lsp", "path", "snippets", "lazydev", "laravel", "blade-nav" },
        providers = {
          ["blade-nav"] = {
            module = "blade-nav.blink",
            opts = {
              close_tag_on_complete = true,
            },
          },
          laravel = {
            name = "laravel",
            module = "blink.compat.source", -- enable cmp compatibility
            score_offset = 95, -- prioritize over LSP
          },
          lazydev = {
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      snippets = { preset = "luasnip" },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = "prefer_rust_with_warning" },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },

      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
    },
  },

  { -- Theme
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    "EdenEast/nightfox.nvim",
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("nightfox").setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme "carbonfox"
    end,
  },

  { -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.nvim",
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require "mini.statusline"
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end

      -- Extras
      require("mini.comment").setup()
      require("mini.move").setup()

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    -- branch = "main",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    dependencies = {
      { -- Show current context (sticky header)
        "nvim-treesitter/nvim-treesitter-context",
        opts = { max_lines = 3, multiline_threshold = 1 },
      },
      { -- Extra textobjects powered by treesitter
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
      { -- Colorize matching brackets and parenthesis
        "hiphish/rainbow-delimiters.nvim",
      },
    },
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = {
          "ruby",
          "markdown",
          "markdown_inline",
          "vim",
          "vimdoc",
        },
      },
      indent = {
        enable = true,
        disable = { "ruby", "python", "yaml", "markdown" },
      },

      -- Enable incremental selection (built-in to nvim-treesitter)
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },

      -- Enable textobjects
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Jump forward to textobj
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require "kickstart.plugins.indent_line",
  require "kickstart.plugins.autopairs",
  require "kickstart.plugins.neo-tree",
  require "kickstart.plugins.gitsigns", -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = "custom.plugins" },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤",
    },
  },
})

-- Improve visibility for matching brackets and parenthesis
vim.api.nvim_set_hl(0, "MatchParen", { fg = "#D0D0D0", bg = "#300594" })

-- Make cursor more visible in different modes
vim.o.guicursor =
  "n-v-c-sm:block,i-ci-ve:ver25-blinkon500-blinkoff500,r-cr-o:hor20-blinkon500-blinkoff500,t:block-blinkon500-blinkoff500"
