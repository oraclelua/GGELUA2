-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-24 03:54:07

local SDL = require 'SDL'
local GUI控件 = require('GUI.控件')

local sid = 0
local function _comp(a, b)
    return (a._SID or a.GID) < (b._SID or b.GID)
end

local function _sort(self)
    local 子控件 = self.父控件.子控件
    if 子控件 then
        sid = sid + 1
        if sid > 65535 then
            sid = 0
            for _, v in ipairs(子控件) do
                if ggetype(v) == 'GUI窗口' then
                    v._SID = (sid << 16) | v.GID
                    sid = sid + 1
                end
            end
        end

        self._SID = (sid << 16) | self.GID
        table.sort(子控件, _comp)
    end
end

local GUI窗口 = class('GUI窗口', GUI控件)

do
    function GUI窗口:初始化()
        self._SID = 0
        self:置中心(-self.x, -self.y)
        self:置坐标(0, 0)
    end

    function GUI窗口:置可见(v, s)
        if s == nil then --默认初始化子控件
            GUI控件.置可见(self, v, not self.是否实例)
        else
            GUI控件.置可见(self, v, s)
        end

        if v and self.父控件 then
            _sort(self)
        end

        return self
    end

    function GUI窗口:置坐标(x, y)
        self:置中心(-x, -y)
        return self
    end

    function GUI窗口:取窗口()
        return self
    end

    function GUI窗口:创建标题区域(x, y, w, h)
        self._mrect = require('SDL.矩形')(x, y, w, h)
    end

    function GUI窗口:_消息事件(msg)
        if self.是否禁止 and msg.鼠标 then
            for _, v in ipairs(msg.鼠标) do
                if self:检查碰撞(v.x, v.y) then
                    v.x = -9999
                    v.y = -9999
                end
            end
            return
        end

        if self:发送消息('消息开始', msg) then
            return
        end

        if self.父控件 and msg.鼠标 then --如果按下，置顶，子控件会吃消息，所以放前面
            for _, v in ipairs(msg.鼠标) do
                if v.type == SDL.MOUSE_DOWN then
                    if self:检查碰撞(v.x, v.y) then
                        _sort(self)
                    end
                    break
                end
            end
        end
        msg.win = self

        GUI控件._消息事件(self, msg)
        self:_基本事件(msg)

        if self:发送消息('消息结束', msg) then --非模态
            self:清空消息(msg)
        end
    end
end

function GUI窗口:发送消息(name, cx, cy, vx, vy, ...)
    if name == '左键按下' then
        local x, y = self:取中心()
        self._lx, self._ly = vx + x, vy + y
        if self._mrect and not self._mrect:检查点(vx, vy) then
            self._lx = nil
            self._ly = nil
        end
    elseif name == '左键弹起' then
        self._lx = nil
        self._ly = nil
    elseif name == '左键按住' then
        if self._lx then
            self:置中心(-(vx - self._lx), -(vy - self._ly))
        end




    elseif name == '右键单击' then
        if GUI控件.发送消息(self, name, cx, cy, vx, vy, ...) ~= false then
            self:置可见(false)
        end
        return
    end
    return GUI控件.发送消息(self, name, cx, cy, vx, vy, ...)
end

function GUI控件:创建窗口(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此窗口已存在，不能重复创建.')
    local r = GUI窗口(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

--===========================================================================
local GUI模态窗口 = class('GUI模态窗口', GUI窗口)

function GUI模态窗口:置可见(b)
    if not self.是否可见 then
        table.insert(self:取根控件()._modal, self)
    end
    GUI窗口.置可见(self, b)
    return self
end

function GUI控件:创建模态窗口(name, x, y, w, h)
    return GUI模态窗口(name, x, y, w, h, self)
end

--===========================================================================
local GUI弹出窗口 = class('GUI弹出窗口', GUI窗口)

function GUI弹出窗口:置可见(b)
    if not self.是否可见 then
        table.insert(self:取根控件()._popup, self)
    end
    GUI窗口.置可见(self, b, true)
    return self
end

function GUI控件:创建弹出窗口(name, x, y, w, h)
    return GUI弹出窗口(name, x, y, w, h, self)
end

return GUI窗口
