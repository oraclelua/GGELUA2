-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-15 02:44:58


local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM输入 = class('IM输入', IM控件)

function IM输入:初始化(name)
    --self._flag = 0
    self._tp = 1
    self._len = 128
    self._buf = { '', self._len }
    self._name = name .. '##' .. tostring(self)
end

function IM输入:_更新()
    local r
    if self._tp == 1 then
        r = im.InputText(self._name, self._buf)
    elseif self._tp == 2 then
        r = im.InputTextMultiline(self._name, self._buf, self.宽度, self.高度, self._flag)
    elseif self._tp == 3 then
        r = im.InputFloat(self._name, self._buf)
    elseif self._tp == 4 then
        r = im.InputInt(self._name, self._buf)
    end
    IM控件._检查鼠标(self)
    if r then
        self:发送消息('输入事件', self._buf[1])
    end
end

function IM输入:置文本(v)
    self._buf = {v, self._len}
    return self
end

function IM输入:取文本()
    return self._buf[1]
end

function IM输入:置最大输入(v)
    self._len = v
    return self
end

function IM输入:置文本模式(v)
    self._tp = 1
    self._len = v or 512
    self._buf = {'', self._len}
    return self
end

function IM输入:置多行模式(v)
    self._tp = 2
    self._len = v or 512
    self._buf = {'', self._len}
    return self
end

function IM输入:置数值模式()
    self._tp = 3
    self._buf = {0}
    return self
end

function IM输入:置整数模式()
    self._tp = 4
    self._buf = {0}
    return self
end
--==============================================================================
function IM控件:创建输入(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM输入(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end

function IM控件:创建多行输入(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM输入(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]:置多行模式()
end

function IM控件:创建整数输入(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM输入(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]:置整数模式()
end

function IM控件:创建数值输入(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM输入(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]:置数值模式()
end
return IM输入
