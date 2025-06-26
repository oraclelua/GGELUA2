-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-02 01:10:29


local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM菜单 = class('IM菜单', IM控件)

function IM菜单:初始化(name)
    self._tp = 1
    self._name = (name or '') .. '##' .. tostring(self)
end

function IM菜单:_更新(dt)
    if self._tp == 1 then
        if im.BeginMainMenuBar() then
            IM控件._更新(self, dt)
            im.EndMainMenuBar()
        end
    elseif self._tp == 2 then
        if im.BeginMenuBar() then
            IM控件._更新(self, dt)
            im.EndMenuBar()
        end
    elseif self._tp == 3 then
        if im.BeginMenu(self._name, self.是否禁止) then
            IM控件._更新(self, dt)
            im.EndMenu()
        end
    elseif self._tp == 4 then
        if im.MenuItem(self._name, self._shortcut, self, self.是否禁止) then
            self:发送消息('左键单击')
            self:发送消息('选中事件', self[1])
        end
    elseif self._tp == 5 then
        if im.MenuItem(self._name, self._shortcut, false, self.是否禁止) then
            self.是否选中 = self[1]
            self:发送消息('左键单击')
        end
    end
end

function IM菜单:置选中(v)
    self[1] = v == true
    return self
end

function IM菜单:置快捷键(v)
    self._shortcut = true
    return self
end
--==============================================================================
function IM控件:创建主菜单栏(name, ...) --BeginMainMenuBar
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM菜单(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end

function IM控件:创建菜单栏(name, ...) --窗口BeginMenuBar
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM菜单(name, ...)
    table.insert(self._子控件, self[name])
    self[name]._tp = 2
    if ggetype(self) == 'IM窗口' then
        self:置样式(self:取样式() | 1024)
    end
    return self[name]
end

function IM控件:创建菜单(name, ...) --BeginMenu
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM菜单(name, ...)
    table.insert(self._子控件, self[name])
    self[name]._tp = 3
    return self[name]
end

function IM控件:创建多选菜单项(name, ...) --MenuItem
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM菜单(name, ...)
    table.insert(self._子控件, self[name])
    self[name]._tp = 4
    return self[name]
end

function IM控件:创建菜单项(name, ...) --MenuItem
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM菜单(name, ...)
    table.insert(self._子控件, self[name])
    self[name]._tp = 5
    return self[name]
end

return IM菜单
