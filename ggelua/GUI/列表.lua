-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2023-01-09 06:51:07

local SDL = require 'SDL'

local function _刷新焦点(self, x, y)
    local i, item = self:检查项目(x, y)
    if item then
        self.焦点行 = i
        return i, item
    else
        self.焦点行 = 0
    end
end

local function _刷新列表(self)
    local hy = 0
    for i, v in ipairs(self.子控件) do
        v._i = i
        v.行号 = i
        v:置坐标(v.px, hy + v.py)
        v.是否可见 = true
        v.是否实例 = true
        if v.高度 then
            hy = hy + v.高度 + self.行间距
        else
            warn(self.名称, v.名称, '->没有高度')
        end
    end
    self:置选中(self.选中行)
    _刷新焦点(self, self._win:取鼠标坐标())
end

local GUI控件 = require('GUI.控件')
local GUI列表 = class('GUI列表', GUI控件)

do
    function GUI列表:初始化()
        self._sy = 0 --当前滚动值
        self.行间距 = 0
        self.选中行 = 0
        self.焦点行 = 0

        self._文字 = self:取根控件()._文字:复制():置颜色(255, 255, 255, 255)

        self.行高度 = self._文字:取高度() + 1

        self.选中精灵 = require('SDL.精灵')(0, 0, 0, self.宽度, 0):置颜色(0, 0, 240, 128)
        self.焦点精灵 = require('SDL.精灵')(0, 0, 0, self.宽度, 0):置颜色(255, 255, 0, 128)
    end

    function GUI列表:置选中精灵宽度(v)
        if self.选中精灵 and self.焦点精灵 then
            self.选中精灵宽 = v
            self.焦点精灵宽 = v
        end
    end

    function GUI列表:_更新(dt, ...)
        GUI控件._更新(self, dt, ...)
        if self.选中精灵 and self.选中精灵.更新 then
            self.选中精灵:更新(dt)
        end
        if self.焦点精灵 and self.焦点精灵.更新 then
            self.焦点精灵:更新(dt)
        end
        self:刷新()
    end

    function GUI列表:_显示(...)
        local _x, _y = self:取坐标()
        if self._win:置区域(_x, _y, self.宽度, self.高度) then
            if self.选中精灵 and self.选中行 > 0 and self.子控件[self.选中行] then
                local item = self.子控件[self.选中行]
                self.选中精灵:置中心(-item.x, -(item.y + self._sy))
                self.选中精灵:置区域(0, 0, self.选中精灵宽 or item.宽度, item.高度)
                self.选中精灵:显示(_x, _y)
            end
            if self.焦点精灵 and self.焦点行 > 0 and self.子控件[self.焦点行] then
                local item = self.子控件[self.焦点行]
                self.焦点精灵:置中心(-item.x, -(item.y + self._sy))
                self.焦点精灵:置区域(0, 0, self.焦点精灵宽 or item.宽度, item.高度)
                self.焦点精灵:显示(_x, _y)
            end
            self._win:置区域()
        end

        GUI控件._显示(self, ...)
    end

    function GUI列表:刷新()
        if self._ref then
            self._ref = nil
            _刷新列表(self)
            self._refscroll = true --_刷新滚动
        end
    end

    function GUI列表:清空()
        self.选中行 = 0
        self.焦点行 = 0
        self.子控件 = {}
        self._sy = 0 
    end

    function GUI列表:添加(...)
        return self:插入(#self.子控件 + 1, ...)
    end

    local _列项 = class('GUI列项', GUI控件) --继承一下，防止控件接收掉消息
    function GUI列表:插入(i, 文本, x, y, w, h)
        local 列项 = _列项(tostring(文本), 0, 0, w or self.宽度, (h or self.行高度), self)
        列项.px = x or 0
        列项.py = y or 0
        if 文本 then
            列项:置精灵(self._文字:取精灵(文本))
        end

        if type(self.子显示) == 'function' then
            列项.显示 = function(this, x, y)
                self:子显示(x, y, this._i)
            end
        end

        local 置高度 = 列项.置高度
        列项.置高度 = function(this, v)
            置高度(this, v)
            self._ref = true
            return this
        end

        local 置精灵 = 列项.置精灵
        列项.置精灵 = function(this, v, vh)
            置精灵(this, v)
            if v and v.高度 and vh then
                列项:置高度(v.高度)
            end
            return this
        end

        table.insert(self.子控件, i, 列项)
        self._ref = true
        return 列项
    end

    function GUI列表:删除(i)
        if self.子控件[i] then
            table.remove(self.子控件, i)
            self._ref = true
        end
    end

    function GUI列表:删除选中()
        local i = self.选中行
        if self.子控件[i] then
            table.remove(self.子控件, i)
            self._ref = true
        end
    end

    function GUI列表:自动删除(v)
        self._del = v
        return self
    end

    function GUI列表:置高度(h)
        GUI控件.置高度(self, h)
        self._ref = true
        return self
    end

    function GUI列表:置宽度(w)
        GUI控件.置宽度(self, w)
        for i, v in ipairs(self.子控件) do
            v:置宽度(w)
        end
        --self._ref = true
        return self
    end

    function GUI列表:置宽高(w, h)
        GUI控件.置宽高(self, w, h)
        for i, v in ipairs(self.子控件) do
            v:置宽度(w)
        end
        self._ref = true
        return self
    end

    function GUI列表:取项目(i)
        if i < 0 then
            i = #self.子控件 + i + 1
        end
        return self.子控件[i]
    end

    function GUI列表:遍历项目()
        local 子控件 = {}
        for i, v in ipairs(self.子控件) do
            子控件[i] = v
        end
        return next, 子控件
    end

    function GUI列表:遍历项目文本()
        local 文本 = {}
        for i, v in ipairs(self.子控件) do
            文本[i] = v.名称
        end
        return next, 文本
    end

    function GUI列表:置文字(v)
        self._文字 = v:复制()
        if self._文字:取高度('A') > self.行高度 then
            self.行高度 = self._文字:取高度('A')
        end
        return self
    end

    function GUI列表:置颜色(...)
        self._文字:置颜色(...)
        return self
    end

    function GUI列表:置项目颜色(i, ...)
        if self.子控件[i] and self.子控件[i]:取精灵() then
            self.子控件[i]:取精灵():置颜色(...)
        end
        return self
    end

    function GUI列表:置文本(i, v)
        if self.子控件[i] then
            self.子控件[i].名称 = v
            self.子控件[i]:置精灵(v and self._文字:取精灵(v))
        end
        return self
    end

    function GUI列表:取文本(i)
        return self.子控件[i] and self.子控件[i].名称
    end

    function GUI列表:取行数()
        return #self.子控件
    end

    function GUI列表:置选中(i)
        if self.子控件[i] then
            self.选中行 = i
            self:发送消息('选中事件', i, self.子控件[i])
        else
            self.选中行 = 0
        end
    end

    function GUI列表:取选中()
        if self.选中行 then
            return self.子控件[self.选中行]
        end
    end

    function GUI列表:检查项目(x, y)
        for i, item in ipairs(self.子控件) do
            if item.是否可见 and item:检查点(x, y) then
                return i, item
            end
        end
    end

    function GUI列表:定位(i)
    end

    function GUI列表:_消息事件(msg)
        if not self.是否可见 then
            return
        end
        GUI控件._消息事件(self, msg)
        self:_基本事件(msg)
    end
end

GUI列表.检查碰撞 = GUI控件.检查点
function GUI列表:发送消息(name, ...)
    if name == '左键按下' or name == '右键按下' or
        name == '左键弹起' or name == '右键弹起' or
        name == '获得鼠标' or name == '失去鼠标'
    then
        local _, _, x, y = ...
        local i, v = self:检查项目(x, y)

        if v then
            if name == '左键按下' then
                self.选中行 = i
                if gge.platform == 'Android' or gge.platform == 'iOS' then
                    self._RMS = true
                    SDL.GetRelativeMouseState()
                end
            elseif name == '获得鼠标' then
                self.焦点行 = i
            end

            x, y = v:取坐标()
            GUI控件.发送消息(self, name, x, y, i, v)
            GUI控件.发送消息(self, '选中事件', i, v)
        elseif name == '失去鼠标' then
            self.焦点行 = 0
            self._RMS = false
            GUI控件.发送消息(self, name, ...) --失去鼠标
        end
        return
    elseif name == '左键按住' then
        if self._RMS and (gge.platform == 'Android' or gge.platform == 'iOS') then
            local b, wx, wy = SDL.GetRelativeMouseState() --距上次鼠标相对坐标

            self:_子控件滚动(nil, self._sy + wy, true)
        end
    elseif name == '左键单击' or name == '右键单击' or
        name == '左键双击' or name == '右键双击'
    then
        local _, _, x, y = ...
        local i, v = self:检查项目(x, y)
        if i == self.选中行 then
            x, y = v:取坐标()
            GUI控件.发送消息(self, name, x, y, i, v)
        end
        return
    elseif name == '鼠标滚轮' then
        local _, _, x, y = ...
        _刷新焦点(self, x, y)
    end
    return GUI控件.发送消息(self, name, ...)
end

function GUI控件:创建列表(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此列表已存在，不能重复创建.')
    local r = GUI列表(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

--====================================================================
local function _刷新树(子控件, node)
    for _, v in ipairs(node) do
        table.insert(子控件, v)
        if v.是否展开 then --递归子项
            if v._node then
                _刷新树(子控件, v._node)
            end
        end
    end
end

local _节点 = class('树节点', GUI控件)
do
    function _节点:初始化(t, x, y, w, h, f)
        self.是否展开 = false
        self._lay = 1

        self.px = x or 0
        self.py = y or 0
        self:置精灵(f._文字:取精灵(t))
    end

    function _节点:添加(name, x, y, w, h)
        local r = _节点(name, self._lay * self.父控件.缩进宽度 + (x or 0), y, w or self.宽度,
            (h or self.父控件.行高度), self.父控件)
        r.父节点 = self
        r._lay = self._lay + 1

        if not self._node then
            self._node = {}
        end
        self.是否节点 = true
        table.insert(self._node, r)
        self.父控件._ref = true
        return r
    end

    function _节点:删除(name)
        if not self._node then
            return
        end
        for i, v in ipairs(self._node) do
            if v.名称 == name then
                table.remove(self._node, i)
                self.父控件._ref = true
                return
            end
        end
    end

    function _节点:清空()
        if not self._node then
            return
        end
        self._node = {}
        self.父控件._ref = true
    end

    function _节点:取项目(name)
        if not self._node then
            return
        end
        for i, v in ipairs(self._node) do
            if v.名称 == name then
                self.父控件._ref = true
                return v
            end
        end
    end

    function _节点:遍历项目()
        if not self._node then
            return next, {}
        end
        return next, self._node
    end

    function _节点:取项目数量()
        return #self._node
    end

    function _节点:置展开(b)
        if self.是否节点 then
            self.是否展开 = b
            self.父控件._ref = true
            if self.收展 then
                self.收展.是否选中 = b
            end
        end
    end

    function _节点:创建收展按钮(x, y, w, h)
        local 收展 = self:创建多选按钮('收展', x, y, w, h)
        收展.检查透明 = 收展.检查点

        收展:注册事件(
            收展,
            {
                选中事件 = function(this, b)
                    self:置展开(b)
                end,
            }
        )
        if self:取精灵() then
            self:取精灵():置中心(-收展.宽度, 0)
        end
        return 收展:置可见(true)
    end
end

--====================================================================
local GUI树形列表 = class('GUI树形列表', GUI列表)
do
    function GUI树形列表:初始化()
        self._node = {}
        self.缩进宽度 = 15
    end

    function GUI树形列表:添加(t, x, y, w, h)
        local r = _节点(t, x, y, (w or self.宽度), (h or self.行高度), self)

        table.insert(self._node, r)
        self._ref = true
        return r
    end

    function GUI树形列表:_更新(...)
        GUI列表._更新(self, ...)
        self:刷新()
    end

    function GUI树形列表:刷新()
        if self._ref then
            self.子控件 = {} --不使用清空
            _刷新树(self.子控件, self._node) --把节点添加到列表
            GUI列表.刷新(self)
        end
    end

    function GUI树形列表:清空()
        self._node = {}
        GUI列表.清空(self)
        self._ref = true
    end

    function GUI树形列表:取项目(name)
        for i, v in ipairs(self._node) do
            if v.名称 == name then
                self._ref = true
                return v
            end
        end
    end

    function GUI树形列表:遍历项目()
        self:刷新()
        return GUI列表.遍历项目(self)
    end

    function GUI树形列表:发送消息(name, ...)
        if name == '左键单击' then
            local _, _, x, y = ...
            local i, v = self:检查项目(x, y)
            if i == self.选中行 then
                v:置展开(not v.是否展开)
            end
        end
        return GUI列表.发送消息(self, name, ...)
    end
end

function GUI控件:创建树形列表(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此树形列表已存在，不能重复创建.')
    local r = GUI树形列表(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

--====================================================================
local GUI多列列表 = class('GUI多列列表', GUI列表)

do
    function GUI多列列表:初始化()
        self._info = {}
        self._color = ''
    end

    function GUI多列列表:添加列(x, y, w, h)
        local t = { x = x, y = y, w = w, h = h }
        table.insert(self._info, t)
        return t
    end

    function GUI多列列表:置颜色(r, g, b, a)
        self._color = string.format('#c%02X%02X%02X', r, g, b)
    end

    function GUI多列列表:添加(...)
        local data = { ... }
        local 行 = GUI列表.添加(self)
        self[#self + 1] = 行
        for i, v in ipairs(self._info) do
            local 列 = 行:创建控件(i, v.x, v.y, v.w or 50, v.h or 行.高度)
            if data[i] then
                列.文本 = tostring(data[i])
               -- 列:创建文本(tostring({}), 0, 0, 列.宽度, 列.高度):置文本(self._color .. tostring(data[i]))
                列:创建文本("nrwn", 0, 0, 列.宽度, 列.高度):置文本(self._color .. tostring(data[i]))
            end
        end
        return 行:置可见(true, true)
    end

    function GUI多列列表:取文本(h, l)
        if not l then
            l = h
            h = self.选中行
        end
        local 列 = self.子控件[h] and self.子控件[h].子控件[l]
        return 列 and 列.文本 or ''
    end

    function GUI多列列表:置文本2(h, l, v)
        if self.子控件[h] and self.子控件[h].子控件[l] then
            self.子控件[h].子控件[l].nrwn:置文本(self._color .. tostring(v))
        end
        return self
    end

    function GUI多列列表:置项目颜色(h,r, g, b, a)
        if self.子控件[h] then
            local _color=string.format('#c%02X%02X%02X', r, g, b)
            for i, v in ipairs(self.子控件[h].子控件) do
                self.子控件[h].子控件[i].nrwn:置文本(_color .. tostring(self.子控件[h].子控件[i].文本))
            end   
        end
        return self
    end

    -- function GUIGUI多列列表列表:取文本(i)
    --     return self.子控件[i] and self.子控件[i].名称
    -- end





end

function GUI控件:创建多列列表(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此多列列表已存在，不能重复创建.')
    local r = GUI多列列表(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

return GUI列表
