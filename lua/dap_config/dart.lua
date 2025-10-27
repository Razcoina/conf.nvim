local dap = require "dap"

dap.adapters.dart = {
  type = "executable",
  command = "dart",
  args = { "debug_adapter" },
  -- windows users will need to set 'detached' to false
  options = {
    detached = false,
  },
}

dap.adapters.flutter = {
  type = "executable",
  command = "flutter",
  args = { "debug_adapter" },
  -- windows users will need to set 'detached' to false
  options = {
    detached = false,
  },
}

dap.adapters.dummy = {
  type = "executable",
  command = "true",
}

dap.configurations.dart = {
  {
    type = "dart",
    request = "launch",
    name = "Launch current dart file",

    dartSdkPath = vim.fn.expand "$HOME" .. "/Android/flutter/bin/cache/dart-sdk/bin/dart",
    flutterSdkPath = vim.fn.expand "$HOME" .. "/Android/flutter/bin/flutter",

    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "flutter",
    request = "launch",
    name = "Launch flutter project on a device",

    dartSdkPath = vim.fn.expand "$HOME" .. "/Android/flutter/bin/cache/dart-sdk/bin/dart",
    flutterSdkPath = vim.fn.expand "$HOME" .. "/Android/flutter/bin/flutter",

    program = "${workspaceFolder}/lib/main.dart",
    cwd = "${workspaceFolder}",
  },
  {
    type = "dummy",
    request = "launch",
    name = "Start an emulator",
  },
}

-- Helper function to select a device or emulator to run
-- Runs every time a flutter (or dummy) config is launched
dap.listeners.on_config["flutter-pick-device"] = function(config)
  if config.type == "flutter" and config.name == "Launch flutter project on a device" then
    -- Get available devices
    local devices_json = vim.fn.system "flutter devices --machine"
    local ok, devices = pcall(vim.fn.json_decode, devices_json)

    if not ok or not devices then
      vim.notify("Failed to get flutter devices", vim.log.levels.ERROR)

      -- Cancel rather than launching a useless session
      -- Abort (dummy adapter)
      return dap.configurations.dart[3]
    end

    -- Build selection list
    local choices = {}
    for i, dev in ipairs(devices) do
      table.insert(choices, string.format("%d. %s (%s)", i, dev.name, dev.id))
    end

    -- Ask user for device
    local choice = vim.fn.inputlist(choices)

    if choice > 0 and choice <= #devices then
      local device_id = devices[choice].id

      -- Inject into the session configuration
      config.toolArgs = { "-d", device_id }
    elseif choice == 0 then
      -- Abort (dummy adapter)
      return dap.configurations.dart[3]
    else
      vim.notify("No valid device selected, running on default", vim.log.levels.WARN)
    end
  elseif config.type == "dummy" and config.name == "Start an emulator" then
    -- Get available emulators (plain text, since no --machine flag)
    local emu_output = vim.fn.systemlist "flutter emulators"
    local emulators = {}

    -- Parse emulator names & ids
    for _, line in ipairs(emu_output) do
      if line == "No emulators available." then
        vim.notify("No emulators found", vim.log.levels.ERROR)
        break
      end

      -- Matches lines like: "Pixel_3a_API_30 • pixel_3a • Google"
      local id, name = line:match "^(%S+)%s+•%s+([%w%s_%-]+)%s+•"
      if name and id and id ~= "Id" then
        table.insert(emulators, { name = name, id = id })
      end
    end

    if #emulators == 0 then
      vim.notify("Failed to parse emulators", vim.log.levels.ERROR)

      -- Abort
      return vim.deepcopy(config)
    end

    -- Build selection list
    local choices = {}
    for i, emu in ipairs(emulators) do
      table.insert(choices, string.format("%d. %s (%s)", i, emu.name, emu.id))
    end

    -- Ask user for emulator
    local choice = vim.fn.inputlist(choices)

    if choice > 0 and choice <= #emulators then
      local emulator_id = emulators[choice].id

      -- Try launching the emulator
      -- Save your computer's RAM
      vim.notify "NOTICE: Only run one emulator at a time!"
      vim.fn.system { "flutter", "emulators", "--launch", emulator_id }

      print 'Please start debugging with the configuration "Launch flutter project on a device" and select the emulator'
    else
      vim.notify("No valid emulator selected", vim.log.levels.ERROR)

      -- Abort
      return vim.deepcopy(config)
    end
  end

  return vim.deepcopy(config)
end

-- Auto command to trigger hot reload every time there is a change in the source files
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  desc = "Trigger hot reload every time there is a change in the file",
  group = vim.api.nvim_create_augroup("FlutterHotReload", { clear = true }),
  pattern = "*.dart",
  callback = function()
    -- Fail-safe
    vim.cmd "write"

    local session = dap.session()
    if session and session.config.type == "flutter" then
      dap.session():request "hotReload"
    end
  end,
})
