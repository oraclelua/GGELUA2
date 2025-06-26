-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-12 09:12:01

local HPS = require('HPSocket.HPSocket')
local BaseServer = require('HPSocket.BaseServer')
local PullAgent = class('PullAgent', BaseServer)
PullAgent.置预投递数量 = false
PullAgent.置等候队列大小 = false
PullAgent.取预投递数量 = false
PullAgent.取等候队列大小 = false
PullAgent.取监听地址 = false
PullAgent._hp = false
PullAgent._准备事件 = false
PullAgent._连接事件 = false
PullAgent._发送事件 = false
PullAgent._断开事件 = false
PullAgent._关闭事件 = false
PullAgent._接收事件 = false
PullAgent.准备事件 = false
PullAgent.连接事件 = false
PullAgent.发送事件 = false
PullAgent.断开事件 = false
PullAgent.关闭事件 = false
PullAgent.接收事件 = false

function PullAgent:PullAgent()
    self._hp = require 'ghpsocket.pullagent' (self)
end

--数据到达
function PullAgent:OnReceive(dwConnID, pData)
    if self._接收事件 then
        ggexpcall(self._接收事件, self, dwConnID, pData)
    elseif self.接收事件 then
        ggexpcall(self.接收事件, self, dwConnID, pData)
    end
    return 0
end

--准备连接
function PullAgent:OnPrepareConnect(dwConnID, socket)
    if self._准备事件 then
        ggexpcall(self._准备事件, self, dwConnID, socket)
    elseif self.准备事件 then
        ggexpcall(self.准备事件, self, dwConnID, socket)
    end
    return 0
end

--连接完成
function PullAgent:OnConnect(dwConnID)
    local ip, port = self._hp:GetRemoteHost(dwConnID)
    if self._连接事件 then
        ggexpcall(self._连接事件, self, dwConnID, ip, port)
    elseif self.连接事件 then
        ggexpcall(self.连接事件, self, dwConnID, ip, port)
    end
    return 0
end

--关闭服务
function PullAgent:OnShutdown(dwConnID)
    if self._关闭事件 then
        ggexpcall(self._关闭事件, self, dwConnID)
    elseif self.关闭事件 then
        ggexpcall(self.关闭事件, self, dwConnID)
    end
    return 0
end

--已发送数据通知
function PullAgent:OnSend(dwConnID, pData, iLength)
    if self._发送事件 then
        ggexpcall(self._发送事件, self, dwConnID, pData, iLength)
    elseif self.发送事件 then
        ggexpcall(self.发送事件, self, dwConnID, pData, iLength)
    end
    return 1
end

--连接断开
function PullAgent:OnClose(dwConnID, enOperation, iErrorCode)
    if self.断开事件 then
        ggexpcall(self.断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    elseif self.断开事件 then
        ggexpcall(self.断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    end
    return 0
end

function PullAgent:连接(ip, port)
    return self._hp:Connect(ip, port)
end
--获取某个连接的远程主机信息
function PullAgent:取远程信息(dwConnID)
    return self._hp:GetRemoteHost(dwConnID)
end

return PullAgent
