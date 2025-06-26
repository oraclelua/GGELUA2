-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-12 09:10:10

local HPS = require('HPSocket.HPSocket')
local BaseServer = require('HPSocket.BaseServer')
local PackAgent = class('PackAgent', BaseServer)
PackAgent.置预投递数量 = false
PackAgent.置等候队列大小 = false
PackAgent.取预投递数量 = false
PackAgent.取等候队列大小 = false
PackAgent.取监听地址 = false
PackAgent._hp = false
PackAgent._准备事件 = false
PackAgent._连接事件 = false
PackAgent._发送事件 = false
PackAgent._断开事件 = false
PackAgent._关闭事件 = false
PackAgent._接收事件 = false
PackAgent.准备事件 = false
PackAgent.连接事件 = false
PackAgent.发送事件 = false
PackAgent.断开事件 = false
PackAgent.关闭事件 = false
PackAgent.接收事件 = false

function PackAgent:PackAgent(Flag, Size)
    self._hp = require 'ghpsocket.packagent' (self)
    if type(Flag) == 'number' and Flag <= 0x3FF then
        self._hp:SetPackHeaderFlag(Flag)
    else
        Flag = 0
        for _, v in ipairs { string.byte('GGELUA_FLAG', 1, #'GGELUA_FLAG') } do
            Flag = Flag + v
        end
        self._hp:SetPackHeaderFlag(Flag)
    end
    if type(Size) == 'number' and Size <= 0x3FFFFF then
        self._hp:SetMaxPackSize(Size)
    end
end

--数据到达
function PackAgent:OnReceive(dwConnID, pData)
    if self._接收事件 then
        ggexpcall(self._接收事件, self, dwConnID, pData)
    elseif self.接收事件 then
        ggexpcall(self.接收事件, self, dwConnID, pData)
    end
    return 0
end

--准备连接
function PackAgent:OnPrepareConnect(dwConnID, socket)
    if self._准备事件 then
        ggexpcall(self._准备事件, self, dwConnID, socket)
    elseif self.准备事件 then
        ggexpcall(self.准备事件, self, dwConnID, socket)
    end
    return 0
end

--连接完成
function PackAgent:OnConnect(dwConnID)
    local ip, port = self._hp:GetRemoteHost(dwConnID)
    if self._连接事件 then
        ggexpcall(self._连接事件, self, dwConnID, ip, port)
    elseif self.连接事件 then
        ggexpcall(self.连接事件, self, dwConnID, ip, port)
    end
    return 0
end

--关闭服务
function PackAgent:OnShutdown(dwConnID)
    if self._关闭事件 then
        ggexpcall(self._关闭事件, self, dwConnID)
    elseif self.关闭事件 then
        ggexpcall(self.关闭事件, self, dwConnID)
    end
    return 0
end

--已发送数据通知
function PackAgent:OnSend(dwConnID, pData, iLength)
    if self._发送事件 then
        ggexpcall(self._发送事件, self, dwConnID, pData, iLength)
    elseif self.发送事件 then
        ggexpcall(self.发送事件, self, dwConnID, pData, iLength)
    end
    return 1
end

--连接断开
function PackAgent:OnClose(dwConnID, enOperation, iErrorCode)
    if self.断开事件 then
        ggexpcall(self.断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    elseif self.断开事件 then
        ggexpcall(self.断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    end
    return 0
end

--====================================================================================
--IPackSocket
--====================================================================================
--/* 设置数据包最大长度（有效数据包最大长度不能超过 4194303/0x3FFFFF 字节，默认：262144/0x40000） */
function PackAgent:置数据最大长度(dwMaxPackSize)
    assert(dwMaxPackSize <= 0x3FFFFF, '不符合范围')
    self._hp:SetMaxPackSize(dwMaxPackSize)
end

--/* 设置包头标识（有效包头标识取值范围 0 ~ 1023/0x3FF，当包头标识为 0 时不校验包头，默认：0） */
function PackAgent:置包头标识(usPackHeaderFlag)
    assert(usPackHeaderFlag <= 0x3FF, '不符合范围')
    self._hp:SetPackHeaderFlag(usPackHeaderFlag)
end

--/* 获取数据包最大长度 */
function PackAgent:取数据包最大长度()
    return self._hp:GetMaxPackSize()
end

--/* 获取包头标识 */
function PackAgent:取包头标识()
    return self._hp:GetPackHeaderFlag()
end

function PackAgent:连接(ip, port)
    return self._hp:Connect(ip, port)
end
--获取某个连接的远程主机信息
function PackAgent:取远程信息(dwConnID)
    return self._hp:GetRemoteHost(dwConnID)
end

return PackAgent
