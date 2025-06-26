-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-15 02:04:54


local ggf = require('GGE.函数')
local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM窗口 = class('IM窗口', IM控件)
IM窗口.是否窗口 = true

function IM窗口:初始化(name, x, y, w, h)
    self._tp = 1
    self._name = name .. '##' .. tostring(self)
    self._iswin = true
    self._flag = 64 --自动宽高
    self.是否可见 = false
    if x and y then
        self._x = x
        self._y = y
    end
    if w and h then
        self._w = w
        self._h = h
        self._flag = 0
    end
end

local _flag =
setmetatable(
    {
        禁止标题 = 1 << 0,
        禁止调整 = 1 << 1,
        禁止移动 = 1 << 2,
        禁止滑块 = 1 << 3,
        禁止滚动 = 1 << 4,
        禁止折叠 = 1 << 5,
        自动宽高 = 1 << 6,
        禁止背景 = 1 << 7,
        禁止保存 = 1 << 8,
        禁止鼠标 = 1 << 9,
        拥有菜单 = 1 << 10,

        关闭按钮 = 1 << 23, --非标准
        禁止装饰 = 43, --禁止标题|禁止调整|禁止滑块|禁止折叠 Decoration
    },
    { __index = _G }
)
function IM窗口:__newindex(k, v)
    if k == '初始化' then
        ggf.setfenv(v, _flag)
    end
    rawset(self, k, v)
end

function IM窗口:_更新(dt)
    if self.是否可见 then
        if self._x then
            im.SetNextWindowPos(self._x, self._y)
            self._x = nil
            self._y = nil
        end
        if self._w and self._h then
            im.SetNextWindowSize(self._w, self._h)
            self._w = nil
            self._h = nil
        end
        if self._alpha then
            im.SetNextWindowBgAlpha(self._alpha)
        end
        if self._tp == 1 then
            if im.Begin(self._name, self, self._flag) then
                if self.是否可见 ~= self[1] then
                    self:发送消息('可见事件', self[1])
                    self.是否可见 = self[1]
                end

                if type(self.更新) == 'function' then
                    self:更新(dt)
                end
                IM控件._更新(self, dt)
                local w, h = im.GetWindowSize()
                if w ~= self.宽度 or self.高度 ~= h then
                    self.宽度, self.高度 = w, h
                    self:发送消息('大小改变事件', w, h, im.GetWindowContentRegionMax())
                end
                --local x, y = im.GetWindowPos()
                im.End()
            end
        elseif self._tp == 2 then
            if not self._已打开 then
                im.OpenPopup(self._name)
                self._已打开 = true
            end
            local flag = self._flag & 0x1FFFFF

            local r
            if self._flag & 0x800000 == 0x800000 then
                r = im.BeginPopupModal(self._name, flag)
            else
                r = im.BeginPopupModal(self._name, self, flag)
            end
            if r then
                if self.是否可见 ~= self[1] then
                    self:发送消息('可见事件', self[1])
                    self.是否可见 = self[1]
                end
                self.是否可见 = self[1]
                if type(self.更新) == 'function' then
                    self:更新(dt)
                end
                IM控件._更新(self, dt)
                im.EndPopup()
            end
        end

    end
end

function IM窗口:置可见(v, s)
    self[1] = v == true
    IM控件.置可见(self, v, s or not self.是否实例)

    if self._tp == 2 then
        im.CloseCurrentPopup()
        self._已打开 = nil
    end
    return self
end

function IM窗口:折叠(b)
    --SetNextWindowCollapsed
    return self
end

function IM窗口:置样式(b)
    self._flag = b
    return self
end

function IM窗口:取样式()
    return self._flag
end

function IM窗口:置坐标(x, y)
    self._x = x
    self._y = y
    return self
end

function IM窗口:置透明(v)
    self._alpha = v / 255
    return self
end

--==============================================================================
function IM控件:创建窗口(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM窗口(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end

function IM控件:创建临时窗口(name, ...) --关闭将被删除
    local r = IM窗口(name, ...)
    table.insert(self._子控件, r)
    r._temp = true
    return r
end

function IM控件:创建模态窗口(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM窗口(name, ...)
    table.insert(self._子控件, self[name])
    self[name]._tp = 2
    return self[name]
end

return IM窗口
