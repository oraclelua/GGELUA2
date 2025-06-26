-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2023-01-05 04:43:47

local GUI控件 = require('GUI.控件')
local GUI组合 = class('GUI组合', GUI控件)

function GUI组合:初始化(_, x, y, w, h)
    
end

function GUI组合:检查点(x, y)
    if self.弹出 and self.弹出.是否可见 and
        self.弹出.矩形:检查点(x, y) then --.矩形 防止死循环
        return true
    end
    return GUI控件.检查点(self, x, y)
end

function GUI组合:置文本(s)
    self.选中项 = s
    if self.文本 then
        self.文本:置文本(self.选中项)
    elseif self.输入 then
        self.输入:置文本(self.选中项)
    else
        error('控件不存在')
    end
end

function GUI组合:取文本()
    if self.文本 then
        return self.选中项
    elseif self.输入 then
        return self.输入:取文本()
    end
    return ''
end

function GUI组合:取数值()
    if self.文本 then
        return tonumber(self.选中项)
    elseif self.输入 then
        return self.输入:取数值()
    end
    return ''
end

function GUI组合:添加(t)
    if self.列表 then
        return self.列表:添加(t)
    end
end

function GUI组合:置选中(i)
    if self.列表 then
        return self.列表:置选中(i)
    end
end

function GUI组合:创建组合文本(x, y, w, h)
    self:删除控件('文本')
    self:删除控件('输入')
    local 文本 = GUI控件.创建文本(self, '文本', x, y, w, h)
    文本.检查碰撞 = 文本.检查点
    文本:注册事件(
        文本,
        {
            左键单击 = function()
                if self.弹出 then
                    self.弹出:置可见(true)
                end
            end
        }
    )
    return 文本
end

function GUI组合:创建组合输入(x, y, w, h)
    self:删除控件('文本')
    self:删除控件('输入')
    local 输入 = GUI控件.创建输入(self, '输入', x, y, w, h)
    return 输入
end

function GUI组合:创建组合按钮(x, y)
    local 按钮 = GUI控件.创建按钮(self, '按钮', x, y)
    按钮:注册事件(
        按钮,
        {
            左键单击 = function()
                if self.弹出 then
                    self.弹出:置可见(true)
                end
            end
        }
    )
    return 按钮
end

function GUI组合:创建组合弹出(x, y, w, h)
    self.弹出 = GUI控件.创建弹出控件(self, '弹出', x, y, w, h)
    return self.弹出
end

function GUI组合:创建组合列表(x, y, w, h)
    local 列表
    if self.弹出 then
        列表 = self.弹出:创建列表('列表', x, y, w, h)
    else
        self:创建组合弹出(x, y, w, h)
        列表 = self.弹出:创建列表('列表', 0, 0, w, h)
    end
    列表:注册事件(
        列表,
        {
            左键单击 = function()
                self:置文本(列表:取文本(列表.选中行))
                self.弹出:置可见(false)
                self:发送消息('选中事件', 列表.选中行)
            end
        }
    )

    self.列表 = 列表
    return 列表
end

function GUI控件:创建组合(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此组合已存在，不能重复创建.')
    local r = GUI组合(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

return GUI组合
