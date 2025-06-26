-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2023-11-06 18:30:36
local AES = require("GOL.AES")

local adler32 = require('zlib').adler32
local m_pack = require('cmsgpack').pack
local m_unpack = require('cmsgpack.safe').unpack

local c_isyieldable = coroutine.isyieldable --lua5.3
local c_runing = coroutine.running
local c_yield = coroutine.yield

local PackAgent = require('HPSocket.PackAgent')
local RPCAgent = class('RPCAgent', PackAgent)

function RPCAgent:RPCAgent(mcall)
    if mcall then --用主线程回调数据
        self._mdata = {}

        引擎:注册事件(
            self,
            {
                更新事件 = function()
                    if next(self._mdata) then
                        for _, v in ipairs(self._mdata) do
                            self:_接收事件(v[1], v[2], true)
                        end
                        self._mdata = {}
                    end
                end
            }
        )
    end
    PackAgent.PackAgent(self) --初始化父类
    self._超时 = 引擎:定时(
        60000,
        function(ms)
            local ot = os.time() - 60
            for k, v in pairs(self._CBK) do
                if ot > v[2] then
                    coroutine.close(v[1])
                    self._CBK[k] = nil
                end
            end
            return ms
        end
    )

    self._REG = {} --private  注册表
    self._CBK = {} --private  回调表
    self.REG = {}
    return setmetatable(
        self.REG,
        {
            __newindex = function(_, k, v)
                if type(v) == 'function' then
                    self._REG[k] = v
                    self._REG[adler32(k)] = v
                end
            end,
            __index = self._REG
        }
    )
end

function RPCAgent:__index(k)                             --调用方法
    local co, main = c_runing()
    local funp = type(k) == 'string' and adler32(k) or k -- 将函数名转成整数
    if co and not main and c_isyieldable() then          --如果有协程，则有返回值
        return function(self, id, ...)
            if id then
                local cop = adler32(tostring(co))
                self._CBK[cop] = { co, os.time() }
                self:发送(id, { funp, cop, ... })
                return c_yield()
            end
        end
    end
    return function(self, id, ...)
        if id then
            self:发送(id, { funp, 0, ... })
        end
    end
end

function RPCAgent:发送(id, ...)
    -- return self._hp:Send(id, AES:encrypt(m_pack(...)))
    return self._hp:Send(id, m_pack(...))
end

local function cofunc(self, id, cop, func, ...)
    self:发送(id, { 0, cop, func(self, id, ...) })
end

local function t_unpack(t, i)
    local max = 0
    for k, v in pairs(t) do
        max = math.max(max, k)
    end
    return table.unpack(t, i, max)
end

function RPCAgent:_接收事件(id, data, mc)
    if rawget(self, '接收事件') then
        self:接收事件(id, data)
        return
    end
    if rawget(self, '_mdata') and not mc then
        table.insert(self._mdata, { id, data })
        return
    end

    -- local t = m_unpack(AES:decrypt(data))
    local t = m_unpack(data)
    if type(t) == 'table' then
        local funp, cop = t[1], t[2]
        if funp == 0 then --返回
            local co = self._CBK[cop]
            if co and coroutine.status(co[1]) == 'suspended' then
                self._CBK[cop] = nil
                coroutine.xpcall(co[1], t_unpack(t, 3))
            end
        else
            local func = self._REG[funp]
            if func then
                if cop == 0 then --没有返回
                    coroutine.xpcall(func, self, id, t_unpack(t, 3))
                else
                    local r = coroutine.xpcall(cofunc, self, id, cop, func, t_unpack(t, 3))
                    if r == coroutine.FALSE then
                        self:发送(id, { 0, cop, nil })
                    end
                end
            elseif rawget(self, 'RPC事件') then --未注册的函数
                func = self.RPC事件
                if cop == 0 then --没有返回
                    func(self, id, funp, t_unpack(t, 3))
                else
                    local r = coroutine.xpcall(cofunc, self, id, cop, func, funp, t_unpack(t, 3))
                    if r == coroutine.FALSE then
                        self:发送(id, { 0, cop, nil })
                    end
                end
            elseif cop ~= 0 then
                self:发送(id, { 0, cop, nil })
            end
        end
    else
        --warn
    end
end

return RPCAgent
