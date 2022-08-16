-- pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")

-- 自动聚焦
require("awful.autofocus")

-- 帮助热键
require("awful.hotkeys_popup.keys")

-- 错误处理
require('error_handler')

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

-- 通知
require('naughtys')

