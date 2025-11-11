local dap = require "dap"

dap.configurations.python = {
  {
    name = "Debug current file (external console)",
    type = "python",
    request = "launch",
    console = "externalTerminal",
    cwd = "${workspaceFolder}",
    program = "${file}",
    args = {},
    pythonPath = function()
      local cwd = vim.fn.getcwd()

      -- Check project-local virtualenvs first
      local venv_paths = {
        cwd .. "/venv/bin/python",
        cwd .. "/.venv/bin/python",
      }

      for _, path in ipairs(venv_paths) do
        if vim.fn.executable(path) == 1 then
          return path
        end
      end

      -- Check for currently active conda environment
      local conda_python = os.getenv "CONDA_PREFIX"
      if conda_python then
        local conda_bin = conda_python .. "/bin/python"
        if vim.fn.executable(conda_bin) == 1 then
          return conda_bin
        end
      end

      -- Fallback to system Python
      return "/usr/bin/python"
    end,
  },
  {
    name = "Debug current file (integrated console)",
    type = "python",
    request = "launch",
    console = "integratedTerminal",
    cwd = "${workspaceFolder}",
    program = "${file}",
    args = {},
    pythonPath = function()
      local cwd = vim.fn.getcwd()

      -- Check project-local virtualenvs first
      local venv_paths = {
        cwd .. "/venv/bin/python",
        cwd .. "/.venv/bin/python",
      }

      for _, path in ipairs(venv_paths) do
        if vim.fn.executable(path) == 1 then
          return path
        end
      end

      -- Check for currently active conda environment
      local conda_python = os.getenv "CONDA_PREFIX"
      if conda_python then
        local conda_bin = conda_python .. "/bin/python"
        if vim.fn.executable(conda_bin) == 1 then
          return conda_bin
        end
      end

      -- Fallback to system Python
      return "/usr/bin/python"
    end,
  },
}
