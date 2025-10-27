local dap = require "dap"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "js-debug-adapter",
    args = { "${port}" },
  },
}

dap.configurations.javascript = {
  {
    name = "[node] Launch current file",
    type = "pwa-node",
    request = "launch",

    console = "integratedTerminal",
    cwd = "${workspaceFolder}",
    program = "${file}",
    args = {},
  },
  {
    name = "Launch index.html in Firefox",
    type = "firefox",
    request = "launch",

    firefoxExecutable = "/usr/bin/librewolf",
    firefoxArgs = { "-start-debugger-server", "-new-tab" },

    reAttach = true,
    file = "${workspaceFolder}/index.html",
  },
  {
    name = "Launch localhost in Firefox",
    type = "firefox",
    request = "launch",

    firefoxExecutable = "/usr/bin/librewolf",
    firefoxArgs = { "-start-debugger-server", "-new-tab" },

    reAttach = true,
    url = "http://localhost:8000",
    webRoot = "${workspaceFolder}",
  },
}

-- Extend to TypeScript
dap.configurations.typescript = dap.configurations.javascript
