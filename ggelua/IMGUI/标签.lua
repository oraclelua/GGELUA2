-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-15 15:55:02


local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM标签选项 = class('IM标签选项', IM控件)
function IM标签选项:初始化(name)
    self._name = name .. '##' .. tostring(self)
end

function IM标签选项:_更新(dt)
    if im.BeginTabItem(self._name) then
        IM控件._更新(self)
        im.EndTabItem()
    end
end

--=====================================================
local IM标签 = class('IM标签', IM控件)

function IM标签:初始化(name)
    self._name = name .. '##' .. tostring(self)
end

function IM标签:_更新(dt)
    if im.BeginTabBar(self.名称) then
        IM控件._更新(self)
        im.EndTabBar()
    end
    --ImGuiTabBarFlags_NoTooltip
end

function IM标签:添加(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM标签选项(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end
--==============================================================================
function IM控件:创建标签(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM标签(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end

return IM标签
