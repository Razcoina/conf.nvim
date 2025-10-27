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
  },
  {
    name = "Debug current file (integrated console)",
    type = "python",
    request = "launch",
    console = "integratedTerminal",
    cwd = "${workspaceFolder}",
    program = "${file}",
    args = {},
  },
}
