-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-10-15 08:08:41


local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM文本 = class('IM文本', IM控件)

function IM文本:初始化(name)
    self._name = name .. '##' .. tostring(self)
    self._txt = name
end

function IM文本:_更新(dt)
    if self._dis then
        im.TextDisabled(self._txt)
    elseif self._cr then
        im.TextColored(self._txt, self._cr, self._cg, self._cb, self._ca)
    else
        im.TextUnformatted(self._txt)
    end
    IM控件._更新(self, dt)
    IM控件._检查鼠标(self)
end

function IM文本:置颜色(r, g, b, a)
    self._cr = r and (r / 255) or 1
    self._cg = g and (g / 255) or 1
    self._cb = b and (b / 255) or 1
    self._ca = a and (a / 255) or 1
    return self
end

function IM文本:置文本(t)
    self._txt = t
    return self
end

function IM文本:置灰色(v)
    self._dis = v
    return self
end

--==============================================================================
function IM控件:创建文本(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM文本(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end

return IM文本
