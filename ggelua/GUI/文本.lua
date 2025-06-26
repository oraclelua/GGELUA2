-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-27 06:31:11

local SDL = require 'SDL'
local GUI控件 = require('GUI.控件')
local GGE文本 = require('GGE.文本')

local GUI文本 = class('GUI文本', GGE文本, GUI控件)

function GUI文本:初始化()
    GGE文本.GGE文本(self, self.宽度, self.高度)

    self:置文字(self:取根控件()._文字:复制())
end

function GUI文本:_更新(...)
    GUI控件._更新(self, ...)
    GGE文本.更新(self, ...)
end

function GUI文本:_显示(...)
    local _x, _y = self:取坐标()
    if self._win:置区域(_x, _y, self.宽度, self.高度) then
        GGE文本.显示(self, _x, _y)
        self._win:置区域()
    end

    GUI控件._显示(self, ...)
end

function GUI文本:置宽度(...)
    local w, h = GGE文本.置宽度(self, ...)
    GUI控件.置宽度(self, ...)
    return w, h
end

function GUI文本:_消息事件(msg)
    if not self.是否可见 then
        return
    end

    GUI控件._消息事件(self, msg)

    self:_基本事件(msg)
end

function GUI文本:检查回调(x, y)
    if self:检查点(x, y) then
        return GGE文本.检查回调(self, x, y)
    end
end
GUI文本.检查碰撞 = GUI文本.检查回调













function GUI文本:发送消息(name, ...)
    if name == '左键按下' or name == '右键按下' or
        name == '左键弹起' or name == '右键弹起'
    then
        local _, _, x, y = ...
        local v = self:检查回调(x, y)

        if v then
            if name == '左键按下' or name == '右键按下' then
                self.鼠标回调 = v
            end
            GUI控件.发送消息(self, '回调' .. name, v.cb)
        else
            self.鼠标回调 = nil
        end
    elseif name == '获得鼠标' then
        local _, _, x, y = ...
        local v = self:检查回调(x, y)
        if v then
            self.焦点回调 = v
            x, y = v:取坐标()
            GUI控件.发送消息(self, '回调获得鼠标', x, y, v.cb, v)
        elseif self.焦点回调 then
            self.焦点回调 = nil
            GUI控件.发送消息(self, '回调失去鼠标', ...)
        end
    elseif name == '失去鼠标' then
        self.鼠标回调 = nil
        if self.焦点回调 then
            self.焦点回调 = nil
            GUI控件.发送消息(self, '回调失去鼠标', ...)
        end
    elseif name == '左键单击' or name == '右键单击' or
        name == '左键双击' or name == '右键双击'
    then
        local _, _, x, y = ...
        local v = self:检查回调(x, y)
        
        if v and v == self.鼠标回调 then
            GUI控件.发送消息(self, '回调' .. name, v.cb, v)
        end
    elseif name == '鼠标滚轮' then
        -- local _, _, x, y = ...
        -- print("本文", x, y)
        -- self:向下滚动(self, y)
     --   _刷新焦点(self, x, y)
    end
    return GUI控件.发送消息(self, name, ...)
end

function GUI控件:创建文本(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此文本已存在，不能重复创建.')
    local r = GUI文本(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

return GUI文本
