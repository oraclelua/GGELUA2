-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-09-13 03:13:52

local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM组合 = class('IM组合', IM控件)

function IM组合:初始化(name)
    self._list = {}
    self._name = name .. '##' .. tostring(self)
    self[1] = -1
end

function IM组合:_更新(dt)
    if im.Combo(self._name, self, self._list) then
        self.当前选中 = self[1]
        self:发送消息('选中事件', self[1])
    end
end

function IM组合:添加(v)
    table.insert(self._list, tostring(v))
end

function IM组合:删除(i)
    table.remove(self._list, i)
end

function IM组合:置列表(v)
    if type(v) == 'table' then
        self._list = v
    end
end

function IM组合:取文本(i)
    return self._list[i]
end
--==============================================================================
function IM控件:创建组合(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM组合(name, ...)
    table.insert(self._子控件, self[name])
    --self[name]._tp = 2
    return self[name]
end
return IM组合
