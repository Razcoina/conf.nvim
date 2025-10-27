local dap = require "dap"

dap.configurations.html = {
  {
    name = "Launch index.html in Firefox",
    type = "firefox",
    request = "launch",

    firefoxExecutable = "/usr/bin/librewolf",
    firefoxArgs = { "-start-debugger-server", "-new-tab" },

    reAttach = true,
    file = "${workspaceFolder}/index.html",

    pathMappings = {
      { url = "file:///", path = "${workspaceFolder}/" },
    },
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

dap.configurations.vue = dap.configurations.html
