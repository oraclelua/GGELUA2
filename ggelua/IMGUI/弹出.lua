-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-09-13 22:18:50


local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM弹出 = class('IM弹出', IM控件)

function IM弹出:初始化(name)
    self._name = name .. '##' .. tostring(self)
end

function IM弹出:_更新(dt)
    local r

    if self._tp == 1 then
        r = im.BeginPopup(self._name, 0)
    elseif self._tp == 2 then
        r = im.BeginPopupContextItem(self._name)
    elseif self._tp == 3 then
        r = im.BeginPopupContextWindow(self._name)
    end

    if r then
        IM控件._更新(self, dt)
        im.EndPopup()
        return true
    end
end

function IM弹出:置可见(b)
    if b then
        if self._tp == 1 then
            im.OpenPopup(self._name)
        end
    else
        im.CloseCurrentPopup()
    end
end

--创建菜单项 已经在控件类中
--==============================================================================
function IM控件:创建弹出(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    obj = IM弹出(name, ...)
    table.insert(self._子控件, obj)
    obj._tp = 1
    self[name] = obj
    return obj
end

function IM控件:创建关联弹出(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    obj = IM弹出(name, ...)
    table.insert(self._子控件, obj)

    if ggetype(self) == 'IM窗口' then
        obj._tp = 3
    else
        obj._tp = 2
    end
    self[name] = obj
    return obj
end

return IM弹出
