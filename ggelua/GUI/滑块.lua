-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-26 20:21:47

local SDL = require 'SDL'
local GUI控件 = require('GUI.控件')

local _计算位置 = function(self, _x, _y)
    local x, y = self._rect:取坐标()
    local pos
    if self.宽度 > self.高度 then --横向
        local w = self._rect.宽度 - self._btn2.宽度
        pos = math.floor((_x - x - self._bx) / w * self.最大值)
    else
        local h = self._rect.高度 - self._btn2.高度
        pos = math.floor((_y - y - self._by) / h * self.最大值)
    end

    if pos ~= self._位置 then
        self:置位置(pos)
        return true
    end
end

local GUI滑块 = class('GUI滑块', GUI控件)
do

    function GUI滑块:初始化()
        self._位置 = 0
        self.最小值 = 0
        self.最大值 = 100
    end

    function GUI滑块:__index(k)
        if k == '位置' then
            return rawget(self, '_位置')
        end
    end

    function GUI滑块:__newindex(k, v)
        if k == '位置' then
            if v < self.最小值 or tostring(v) == '-nan(ind)' or tostring(v) == 'nan' or tostring(v) == 'inf' then
                v = self.最小值
            end
            if v > self.最大值 then
                v = self.最大值
            end

            if self.宽度 > self.高度 then --横向
                local w = self._rect.宽度 - self._btn2.宽度
                self._btn2:置坐标(math.floor((v / self.最大值) * w), 0)
            else
                local h = self._rect.高度 - self._btn2.高度
                self._btn2:置坐标(0, math.floor((v / self.最大值) * h))
            end
            rawset(self, '_位置', v)
            return
        end
        rawset(self, k, v)
    end

    function GUI滑块:创建滑块按钮(x, y, w, h)
        self._rect = self:创建控件('_rect', x, y, w or self.宽度, h or self.高度) --按钮的区域
        self._btn2 = self._rect:创建按钮('_btn2')
        self._btn2:注册事件(
            self._btn2,
            {
                左键按住 = function(_, x1, y1, x2, y2)
                    local 位置 = self._位置
                    if _计算位置(self, x2, y2) then
                        if 位置 ~= self._位置 then
                            self:发送消息('滚动事件', x1, y1, self._位置)
                        end
                    end
                end
            }
        )
        return self._btn2
    end

    function GUI滑块:创建减少按钮(...) --上边或左边
        self._btn1 = self:创建按钮('_btn1', ...)
        -- self._btn1:注册事件(
        --     self._btn1,
        --     {
        --         左键单击 = function()
        --             self:置位置(self._位置 - 10) --TODO 这里应该是关联控件一页高
        --         end
        --     }
        -- )
        return self._btn1
    end

    function GUI滑块:创建增加按钮(...) --下边或右边
        self._btn3 = self:创建按钮('_btn3', ...)
        -- self._btn3:注册事件(
        --     self._btn3,
        --     {
        --         左键单击 = function()
        --             self:置位置(self._位置 + 10) --TODO 这里应该是关联控件一页高
        --         end
        --     }
        -- )
        return self._btn3
    end

    function GUI滑块:置位置(v)
        self.位置 = v
        if ggetype(self) == 'GUI滚动' then
            if self.父控件._sh then
                local p = self.位置 / self.最大值
                self.父控件:_子控件滚动(nil, -math.floor(p * self.父控件._sh))
            else
                self.位置 = 0
            end
        end
        return self
    end

    function GUI滑块:_消息事件(msg)
        if msg.鼠标 and self:发送消息('鼠标消息') ~= false then
            for _, v in ipairs(msg.鼠标) do
                if v.type == SDL.MOUSE_DOWN and v.button == SDL.BUTTON_LEFT then
                    if self._btn2:检查点(v.x, v.y) then --在按钮接收事件前，记录鼠标在按钮上的位置
                        local x, y = self._btn2:取坐标()
                        self._bx = v.x - x
                        self._by = v.y - y
                        break
                    end
                end
            end
        end

        GUI控件._消息事件(self, msg) --发给按钮

        if not msg.鼠标 then
            return
        end

        for _, v in ipairs(msg.鼠标) do
            if v.type == SDL.MOUSE_DOWN then
                if self._rect:检查点(v.x, v.y) and v.button == SDL.BUTTON_LEFT then --点击区域
                    v.typed, v.type = v.type, nil
                    v.control = self
                    do --FIXME 这里应该移动按钮，然后发出按下消息给按钮
                        self._btn2:置状态('按下')
                        self._btn2._LEFTDOWN = true --点击滑块区，长按移动
                        self._bx = self._btn2.宽度 // 2 --滑块中间
                        self._by = self._btn2.高度 // 2
                    end

                    if _计算位置(self, v.x, v.y) then
                        local x, y = self._btn2:取坐标()
                        self:发送消息('滚动事件', x, y, self._位置, msg)
                    end
                end
            end
        end
    end
end

function GUI控件:创建滑块(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此滑块已存在，不能重复创建.')
    local r = GUI滑块(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

local GUI滚动 = class('GUI滚动', GUI滑块)
GUI滚动.__index = GUI滑块.__index
GUI滚动.__newindex = GUI滑块.__newindex
GUI滚动.创建滚动按钮 = GUI滑块.创建滑块按钮

function GUI控件:创建滚动条(x, y, w, h)
    local name = '竖滚动条'
    if w > h then
        name = '横滚动条'
    end
    local r = GUI滚动(name, x, y, w, h, self)
    self._子控件[name] = r
    return r
end

return GUI滑块
