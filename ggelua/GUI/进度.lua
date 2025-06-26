-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-25 06:00:44

local SDL = require 'SDL'
local GUI控件 = require('GUI.控件')

local GUI进度 = class('GUI进度', GUI控件)

function GUI进度:初始化()
    self.位置 = 0
    self.最大值 = 100
    self.最小值 = 0
end

function GUI进度:置位置(v)
    self.位置 = assert(type(v) == 'number' and v, '非数值')
    local 精灵 = self:取精灵()
    if not 精灵 then
        return
    end
    self.位置 = (v > self.最大值) and self.最大值 or math.floor(v)
    self.位置 = not (v > self.最小值) and self.最小值 or self.位置

    精灵:置区域(0, 0, math.floor(self.位置 / self.最大值 * self.宽度), self.高度)
    return self
end

function GUI进度:置精灵(v)
    GUI控件.置精灵(self, v)
    self:置位置(self.位置)
    return self
end

GUI进度.检查碰撞 = GUI控件.检查点

function GUI进度:_消息事件(msg)
    if not self.是否可见 then
        return
    end
    GUI控件._消息事件(self, msg)
    self:_基本事件(msg)
end

function GUI控件:创建进度(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此进度已存在，不能重复创建.')
    local r = GUI进度(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

return GUI进度
