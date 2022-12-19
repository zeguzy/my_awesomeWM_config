-- pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")

-- 自动聚焦
require("awful.autofocus")

-- 帮助热键
require("awful.hotkeys_popup.keys")


-- Notification library
local naughty = require("naughty")
local gears = require("gears")
naughty.config.defaults.shape = gears.shape.rounded_rect
naughty.config.defaults.position = "top_center"


-- 错误处理
-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function(err)
      -- Make sure we don't go into an endless error loop
      if in_error then return end
      in_error = true

      naughty.notify({
          preset = naughty.config.presets.critical,
          title = "Oops, an error happened!",
          text = tostring(err)
      })
      in_error = false
  end)
end
-- }}}


-- 主题
require('themes')

-- 默认的应用程序
require('default')

-- layout
require('layout')

require('Wibar')

--- 鼠标绑定 和 键位绑定
require('bindings')

-- 窗口匹配规则
require('rules')

-- 执行自启动脚本
awful.spawn.with_shell("~/.config/awesome/script/autorun.sh")

-- 新窗口
require('client')


