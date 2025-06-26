-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-04-14 06:58:54
-- @Last Modified time  : 2022-09-03 13:31:57

local _list = setmetatable({}, { __mode = 'v' })
local 日志 = require('GGE.日志')
local GGE服务 = class('GGE服务', 日志)

function GGE服务:GGE服务(name)
    _list[self] = self
    self._timer = setmetatable({}, { __mode = 'kv' })
    self._tick = {}
    if name then
        self:GGE日志(name, name)
    end
end

function GGE服务:定时(ms, fun, ...)
    if type(fun) == 'function' then
        local t = { ms = ms, time = os.clock() * 1000 + ms, fun = fun, arg = { ... } }
        self._timer[t] = t
        t.删除 = function()
            self._timer[t] = nil
        end
        return t
    end
    local co, main = coroutine.running()
    if not main then
        self._tick[co] = os.clock() * 1000
        coroutine.yield()
        self._tick[co] = nil
        return true
    end
end

function GGE服务:_UPDATE()
    if self.更新 then
        ggexpcall(self.更新, self)
    end
    if next(self._tick) then --协程定时
        local oc = os.clock() * 1000
        local tick = self._tick
        self._tick = {}
        for co, t in pairs(tick) do
            if oc >= t then
                coroutine.xpcall(co)
            end
        end
    end
    if next(self._timer) then --函数定时
        local oc = os.clock() * 1000
        local timer = {}
        for k, t in pairs(self._timer) do --防invalid key to 'next'
            if oc >= t.time then
                timer[k] = t
            end
        end
        for k, t in pairs(timer) do
            t.ms = ggexpcall(t.fun, t.ms, table.unpack(t.arg))
            if t.ms == 0 or type(t.ms) ~= 'number' then
                self._timer[k] = nil
            else
                t.time = t.ms + oc
            end
        end
    end
end

local delay = gge.delay
function main()
    ggexpcall(
        function()
            while true do
                for _, v in pairs(_list) do
                    v:_UPDATE()
                end
                delay(10)
            end
        end
    )
end

return GGE服务
