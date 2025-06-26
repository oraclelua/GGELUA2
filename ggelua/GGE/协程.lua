-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-06-12 04:39:34
-- @Last Modified time  : 2022-06-12 04:45:53

local GGE协程 = class('GGE协程')

function GGE协程:初始化(v)
    if type(v) == 'function' then
    elseif type(v) == 'thread' then
    else
        local co, main = coroutine.running()
        if main then
            return false
        else
            self._co = co
        end
    end
end

function GGE协程:暂停(...)
    return coroutine.yield(...)
end

function GGE协程:恢复(...)
    coroutine.resume(self._co, ...)
end

function GGE协程:定时(t)
    引擎:定时(t, self._co)
end
return GGE协程
