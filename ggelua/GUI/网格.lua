-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-27 06:04:13

local SDL = require 'SDL'
local GUI控件 = require('GUI.控件')

local GUI网格 = class('GUI网格', GUI控件)

function GUI网格:初始化()
    self._id = 0
end

local _格子 = class('GUI格子', GUI控件) --继承一下，防止控件接收掉消息
function GUI网格:添加格子(x, y, w, h)
    self._id = self._id + 1
    local id = self._id
    self._sy=0
    local 格子 = _格子(id, x, y, w, h, self)
    self[id] = 格子
    格子._id = id
    if type(self.子初始化) == 'function' then
        格子.初始化 = function()
            self:子初始化(id)
        end
    end
    if type(self.子更新) == 'function' then
        格子.更新 = function(_, dt)
            self:子更新(dt, id)
        end
    end
    if type(self.子显示) == 'function' then
        格子.显示 = function(_, x, y)
            self:子显示(x, y, id)
        end
    end
    if type(self.子前显示) == 'function' then
        格子.前显示 = function(_, x, y)
            self:子前显示(x, y, id)
        end
    end
    格子:置可见(true)

    table.insert(self.子控件, 格子)
    return 格子
end

function GUI网格:删除格子(id)
    for _, v in self:遍历控件() do
        if v._id and (not id or v._id == id) then
            self:删除控件(v._id)
        end
    end
    if not id then
        self._id = 0
    end
end

function GUI网格:创建格子(宽度, 高度, 行间距, 列间距, 行数量, 列数量)
    self:删除格子()
    for h = 1, 行数量 do
        for l = 1, 列数量 do
            local r = self:添加格子((l - 1) * (宽度 + 列间距), (h - 1) * (高度 + 行间距), 宽度, 高度)
        end
    end
    return self
end

function GUI网格:置格子检查区域(x, y, w, h)
    for i, v in ipairs(self.子控件) do
        v:置检查区域(x, y, w, h)
    end
    return self
end

function GUI网格:绑定滑块(obj)
    self.滑块 = obj
    if obj then
        local 置位置 = obj.置位置
        obj.置位置 = function(this, v)
            if self.高度 > self:取父控件().高度 then
                local max = self.高度 - self:取父控件().高度
                self:置中心(0, math.floor(max * (this.位置 / this.最大值)))
                置位置(this, v)
            else
                置位置(this, 0)
            end
        end
    end
    return obj
end

function GUI网格:检查格子(x, y)
    if self:检查点(x, y) then
        for i, v in ipairs(self.子控件) do
            if v.是否可见 and v:检查点(x, y) then
                return i, v
            end
        end
    end
end

GUI网格.检查碰撞 = GUI网格.检查格子

function GUI网格:_消息事件(msg)
    if not self.是否可见 then
        return
    end

    GUI控件._消息事件(self, msg)

    self:_基本事件(msg)
end

function GUI网格:发送消息(name, ...)
    if name == '左键按下' or name == '右键按下' or
        name == '左键弹起' or name == '右键弹起' or
        name == '获得鼠标' or name == '失去鼠标'
    then
        local _, _, x, y = ...
        local i, v = self:检查格子(x, y)

        if v then
            if name == '左键按下' or name == '右键按下' then
                self._CURID = i
            end
            if name == '左键按下' then
                if gge.platform == 'Android' or gge.platform == 'iOS' then
                    self._RMS = true
                    SDL.GetRelativeMouseState()
                end
            end

            x, y = v:取坐标()
            GUI控件.发送消息(self, name, x, y, i, v)
        elseif name == '失去鼠标' then
            GUI控件.发送消息(self, name, ...) --失去鼠标
        end
        return
    elseif name == '左键按住' then
        if self._RMS and (gge.platform == 'Android' or gge.platform == 'iOS') then
            local b, wx, wy = SDL.GetRelativeMouseState() --距上次鼠标相对坐标

            self:_子控件滚动(nil, self._sy + wy, true)
            self._CURID = nil
        end
    elseif name == '左键单击' or name == '右键单击' or
        name == '左键双击' or name == '右键双击'
    then
        local _, _, x, y = ...
        local i, v = self:检查格子(x, y)
        if i == self._CURID then
            x, y = v:取坐标()
            GUI控件.发送消息(self, name, x, y, i, v)
        end
        return
    end
    return GUI控件.发送消息(self, name, ...)
end

function GUI控件:创建网格(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此网格已存在，不能重复创建.')
    local r = GUI网格(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

return GUI网格
