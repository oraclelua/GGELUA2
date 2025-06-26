-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-12 04:35:17

local string = string
local _ENV = require 'ghpsocket.hpsocket'

function 取版本()
    local v = GetHPSocketVersion()
    return string.format('%d.%d.%d.%d', v >> 24, v >> 16 & 255, v >> 8 & 255, v & 255)
end

function 取主机地址(host)
    return GetIPAddress(host)
end

function 枚举主机地址(host)
    return EnumHostIPAddresses(host)
end

function 取错误()
    return GetLastError()
end

SS_STARTING = '正在启动'
SS_STARTED = '已经启动'
SS_STOPPING = '正在停止'
SS_STOPPED = '已经停止'

SO_UNKNOWN = '未知'
SO_ACCEPT = '接受'
SO_CONNECT = '连接'
SO_SEND = '发送'
SO_RECEIVE = '接收'
SO_CLOSE = '断开'
return _ENV
