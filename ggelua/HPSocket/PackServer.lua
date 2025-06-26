-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-12 05:00:46

local HPS = require('HPSocket.HPSocket')
local BaseServer = require('HPSocket.BaseServer')
local PackServer = class('PackServer', BaseServer)
PackServer._hp = false
PackServer._准备事件 = false
PackServer._连接事件 = false
PackServer._发送事件 = false
PackServer._断开事件 = false
PackServer._停止事件 = false
PackServer._接收事件 = false
PackServer.准备事件 = false
PackServer.连接事件 = false
PackServer.发送事件 = false
PackServer.断开事件 = false
PackServer.停止事件 = false
PackServer.接收事件 = false

function PackServer:PackServer(Flag, Size)
    self._hp = require 'ghpsocket.packserver' (self)
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

--准备监听通知
function PackServer:OnPrepareListen(soListen)
    if self._准备事件 then
        ggexpcall(self._准备事件, self, soListen)
    elseif self.准备事件 then
        ggexpcall(self.准备事件, self, soListen)
    end
    return 0
end

--接收连接通知
function PackServer:OnAccept(dwConnID, soClient) --连接进入
    local ip, port = self._hp:GetRemoteAddress(dwConnID)
    if self._连接事件 then
        ggexpcall(self._连接事件, self, dwConnID, ip, port)
    elseif self.连接事件 then
        ggexpcall(self.连接事件, self, dwConnID, ip, port)
    end
    return 0
end

--已发送数据通知
function PackServer:OnSend(dwConnID, pData, iLength) --发送事件
    if self._发送事件 then
        ggexpcall(self._发送事件, self, pData, iLength)
    elseif self.发送事件 then
        ggexpcall(self.发送事件, self, pData, iLength)
    end
    return 1
end

function PackServer:OnClose(dwConnID, enOperation, iErrorCode) --连接退出
    if self._断开事件 then
        ggexpcall(self._断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    elseif self.断开事件 then
        ggexpcall(self.断开事件, self, dwConnID, HPS[enOperation], iErrorCode)
    end
    return 0
end

--关闭通信组件通知
function PackServer:OnShutdown()
    if self._停止事件 then
        ggexpcall(self._停止事件, self)
    elseif self.停止事件 then
        ggexpcall(self.停止事件, self)
    end
    return 0
end

function PackServer:OnReceive(dwConnID, pData) --数据到达
    if self._接收事件 then
        ggexpcall(self._接收事件, self, dwConnID, pData)
    elseif self.接收事件 then
        ggexpcall(self.接收事件, self, dwConnID, pData)
    end
    return 0
end

--====================================================================================
--/* 设置数据包最大长度（有效数据包最大长度不能超过 4194303/0x3FFFFF 字节，默认：262144/0x40000） */
function PackServer:置数据最大长度(dwMaxPackSize)
    assert(dwMaxPackSize <= 0x3FFFFF, '不符合范围')
    self._hp:SetMaxPackSize(dwMaxPackSize)
end

--/* 设置包头标识（有效包头标识取值范围 0 ~ 1023/0x3FF，当包头标识为 0 时不校验包头，默认：0） */
function PackServer:置包头标识(usPackHeaderFlag)
    assert(usPackHeaderFlag <= 0x3FF, '不符合范围')
    self._hp:SetPackHeaderFlag(usPackHeaderFlag)
end

--/* 获取数据包最大长度 */
function PackServer:取数据包最大长度()
    return self._hp:GetMaxPackSize()
end

--/* 获取包头标识 */
function PackServer:取包头标识()
    return self._hp:GetPackHeaderFlag()
end

return PackServer
