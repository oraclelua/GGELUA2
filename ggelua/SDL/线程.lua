-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-12-05 10:33:07

local SDL = require('SDL')
local pack = require('serialize').pack2
local SDL线程 = class 'SDL线程'
local reg = debug.getregistry()
reg.serialize = require('serialize').pack2
reg.deserialize = require('serialize').deserialize

function SDL线程:SDL线程(main)
    self._co = {}
    self._th = SDL.CreateThread(main, self)
    self._mdata = {}

    引擎:注册事件(
        self,
        {
            更新事件 = function()
                if next(self._mdata) then
                    for _, v in ipairs(self._mdata) do
                        local co = table.remove(v, 1)
                        coroutine.xpcall(co, table.unpack(v))
                    end
                    self._mdata = {}
                end
            end
        }
    )
end

function SDL线程:__index(k)
    local co, main = coroutine.running()
    if co and not main and coroutine.isyieldable() then
        return function(self, ...)
            self._co[co] = co
            self._th:Send(co, (pack(k, ...)))
            return coroutine.yield()
        end
    else
        error('必须协程内调用')
    end
end

function SDL线程:_CallBack(co, ...)
    if self._co[co] then
        self._co[co] = nil
        table.insert(self._mdata, { co, ... })
    end
end

return SDL线程
