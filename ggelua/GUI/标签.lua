-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-26 05:35:36

local SDL = require 'SDL'
local GUI控件 = require('GUI.控件')

local GUI标签 = class('GUI标签', GUI控件)

function GUI标签:初始化()
    self._rect = {}
end

function GUI标签:置可见(...)
    if not self.是否可见 then
        GUI控件.置可见(self, ...)
        for _, b in ipairs(self.子控件) do
            if ggetype(b) == 'GUI单选按钮' and b.是否选中 then
                for k, v in pairs(self._rect) do
                    v:置可见(k == b)
                end
                break
            end
        end
    end
end

local _标签区域 = class('GUI标签区域', GUI控件)
function _标签区域:_消息事件(msg)
    if not self.是否可见 then
        return
    end
    GUI控件._消息事件(self, msg)

    self:_基本事件(msg)
end

function GUI标签:创建区域(btn, x, y, w, h)
    if type(btn) == 'string' then
        assert(self.控件[btn], '单选按钮不存在:' .. btn)
        btn = self.控件[btn]
    end
    assert(self.控件[btn.名称], '单选按钮不存在:' .. btn.名称)

    local name = btn.名称 .. '区域'
    assert(not self.控件[name], name .. ':此控件已存在，不能重复创建.')
    local r = _标签区域(name, x, y, w, h, self)
    table.insert(self.子控件, 1, r) --插到按钮前

    local _置选中 = btn.置选中
    btn.置选中 = function(this, v) --替换按钮选中事件
        if v then
            _置选中(this, v)
            if this.是否选中 then
                for k, v in pairs(self._rect) do
                    v:置可见(k == btn)
                end
            end
        end
    end
    self._rect[btn] = r
    self.控件[name] = r
    return r
end

function GUI标签:_消息事件(msg)
    if  not self.是否可见 then
        return
    end
    GUI控件._消息事件(self, msg)

    --self:_基本事件(msg)
end

function GUI控件:创建标签(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此标签已存在，不能重复创建.')
    local r = GUI标签(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

return GUI标签
