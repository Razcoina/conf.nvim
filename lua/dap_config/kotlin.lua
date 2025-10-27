local dap = require "dap"

dap.adapters.kotlin = {
  type = "executable",
  command = "kotlin-debug-adapter",
  args = { "--interpreter=vscode" },
  options = { auto_continue_if_many_stopped = false },
}

dap.configurations.kotlin = {
  {
    type = "kotlin",
    request = "launch",
    name = "Debug this project",
    console = "internalTerminal",
    projectRoot = "${workspaceFolder}/app",

    -- may differ, when in doubt, whatever your project structure may be,
    -- it has to correspond to the class file located at `build/classes/`
    -- and of course you have to build before you debug
    mainClass = function()
      local f = io.open(vim.fn.getcwd() .. "/app/build.gradle.kts", "r")

      print()

      if not f then
        return vim.fn.input "Path to main class > "
      end

      local content = f:read "*all"

      f:close()

      return content:match "mainClass%s*=%s*[\"']([%w%.]+)[\"']"
    end,

    jsonLogFile = "",
    enableJsonLogging = false,
  },

  {
    -- Use this for unit tests
    -- First, run
    -- ./gradlew --info cleanTest test --debug-jvm
    -- then attach the debugger to it
    type = "kotlin",
    request = "attach",
    name = "Attach to debugging session",
    port = 5005,
    args = {},
    projectRoot = vim.fn.getcwd,
    hostName = "localhost",
    timeout = 2000,
  },
}

-- Run Gradle build automatically before launching Kotlin
dap.listeners.on_config["kotlin-build"] = function(config)
  -- Only trigger for Kotlin launch sessions
  if config.type == "kotlin" and config.request == "launch" then
    print "Building Kotlin project before launch..."
    local result = vim.fn.system(vim.fn.getcwd() .. "/gradlew build")
    print(result)
  end
  return vim.deepcopy(config)
end
