-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-12 05:29:11

local HPS = require('HPSocket.HPSocket')
local BaseServer = require('HPSocket.BaseServer')
local PullServer = class('PullServer', BaseServer)
PullServer._hp = false
PullServer._准备事件 = false
PullServer._连接事件 = false
PullServer._发送事件 = false
PullServer._断开事件 = false
PullServer._停止事件 = false
PullServer._接收事件 = false
PullServer.准备事件 = false
PullServer.连接事件 = false
PullServer.发送事件 = false
PullServer.断开事件 = false
PullServer.停止事件 = false
PullServer.接收事件 = false

function PullServer:PullServer()
    self._hp = require 'ghpsocket.pullserver' (self)
end

--准备监听通知
function PullServer:OnPrepareListen(soListen)
    if self._准备事件 then
        ggexpcall(self._准备事件, self, soListen)
    elseif self.准备事件 then
        ggexpcall(self.准备事件, self, soListen)
    end
    return 0
end

--接收连接通知
function PullServer:OnAccept(dwConnID, soClient) --连接进入
    local ip, port = self._hp:GetRemoteAddress(dwConnID)
    if self._连接事件 then
        ggexpcall(self._连接事件, self, dwConnID, ip, port)
    elseif self.连接事件 then
        ggexpcall(self.连接事件, self, dwConnID, ip, port)
    end
    return 0
end

--已发送数据通知
function PullServer:OnSend(dwConnID, pData, iLength) --发送事件
    if self._发送事件 then
        ggexpcall(self._发送事件, self, pData, iLength)
    elseif self.发送事件 then
        ggexpcall(self.发送事件, self, pData, iLength)
    end
    return 1
end

function PullServer:OnClose(dwConnID, enOperation, iErrorCode) --连接退出
    if self._断开事件 then
        ggexpcall(self._断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    elseif self.断开事件 then
        ggexpcall(self.断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    end
    return 0
end

--关闭通信组件通知
function PullServer:OnShutdown()
    if self._停止事件 then
        ggexpcall(self._停止事件, self)
    elseif self.停止事件 then
        ggexpcall(self.停止事件, self)
    end
    return 0
end

function PullServer:OnReceive(dwConnID, iLength) --数据到达
    if self._接收事件 then
        ggexpcall(self._接收事件, self, dwConnID, iLength)
    elseif self.接收事件 then
        ggexpcall(self.接收事件, self, dwConnID, iLength)
    end
    return 0
end

--====================================================================================
function PullServer:取数据(id, ptr, len, p)
    if p then
        return self._hp:Peek(id, ptr, len) == 0
    end
    return self._hp:Fetch(id, ptr, len) == 0
end

return PullServer
