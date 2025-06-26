-- @Author              : GGELUA
-- @Date                : 2022-04-03 14:00:28
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2023-01-16 14:06:12

local SDL = require 'SDL'
local GID = 0
local GUI控件 = class('GUI控件')

function GUI控件:初始化(name, x, y, w, h, f)
    GID = GID + 1
    -- assert(GID < 65535, '控件过多')
    self.GID = GID
    self.名称 = name
    self.x = math.floor(tonumber(x) or 0)
    self.y = math.floor(tonumber(y) or 0)
    self.宽度 = math.floor(tonumber(w) or (f and f.宽度 or 0))
    self.高度 = math.floor(tonumber(h) or (f and f.高度 or 0))
    if w == nil or h == nil then --由精灵设置宽高
        self._spr = false
    end
    self.父控件 = assert(f, '父控件')

    self._win = self:取根控件()._win
    self.子控件 = {}
    self._子控件 = {} --滚动条
    self.控件 = {}

    self.是否可见 = false
    -- self.是否禁止 = false
    -- self.是否实例   = false --是否已经加载

    self.矩形 = require('SDL.矩形')(self.x, self.y, self.宽度, self.高度)
    self.矩形:置颜色(255, 0, 0)
    self.矩形:置坐标(self:取坐标())
end

function GUI控件:__index(k)
    return rawget(self, '控件')[k]
end

function GUI控件:_更新(...)
    if rawget(self, '更新') then
        self:更新(...)
    end
    if self._spr and self._spr.更新 then
        self._spr:更新(...)
    end
    for _, v in ipairs(self.子控件) do
        if v.是否可见 then
            v:_更新(...)
        end
    end
    for _, v in pairs(self._子控件) do
        if v.是否可见 then
            v:_更新(...)
        end
    end

end

do --_显示
    local function _显示(self, x, y)
        local _x, _y = self:取坐标() --坐标是相对的，每次获取,TODO：移动才修改
        self.矩形:置坐标(_x, _y)
        if self._mrect then --窗口标题区
            self._mrect:置坐标(_x, _y)
        end
        if rawget(self, '后显示') then
            self:后显示(_x, _y)
        end

        if self._win:置区域(_x, _y, self.宽度, self.高度) then
            if self._spr then
                self._spr:显示(_x, _y)
            end
            if rawget(self, '显示') then
                self:显示(_x, _y, x, y)
            end
            for _, v in ipairs(self.子控件) do
                if v.是否可见 then
                    v:_显示(x, y)
                end
            end

            self._win:置区域()
        end
        for _, v in pairs(self._子控件) do
            if v.是否可见 then
                v:_显示(x, y)
            end
        end
        if rawget(self, '前显示') then
            self:前显示(_x, _y)
        end
        if self._refscroll then
            self._refscroll = false
            self:_刷新滚动()
        end
    end

    if gge.isdebug then
        GUI控件._显示 = function(self, ...)
            _显示(self, ...)
            if self._win:取按键状态(SDL.KEY_F1) then
                self.矩形:显示()
                if self._mrect then
                    self._mrect:显示()
                end
            end
        end
    else
        GUI控件._显示 = _显示
    end
end

function GUI控件:_后显示(x, y, mx, my)
    self.矩形:置坐标(x, y)
    if gge.isdebug and self._win:取按键状态(SDL.KEY_F1) then
        self.矩形:显示()
    end
    if rawget(self, '后显示') then
        self:后显示(x, y, mx, my)
    end
    if self._spr then
        self._spr:显示(x, y)
    end
end

function GUI控件:_前显示(x, y, mx, my)
    if rawget(self, '显示') then
        self:显示(x, y, mx, my)
    end
    for _, v in ipairs(self.子控件) do
        if v.是否可见 then
            v:_显示(mx, my)
        end
    end
    if rawget(self, '前显示') then
        self:前显示(x, y, mx, my)
    end
end

function GUI控件:_刷新滚动() --_refscroll
    local rect = self.矩形

    for _, v in ipairs(self.子控件) do
        if ggetype(v) ~= 'GUI窗口' and v.是否实例 then

            rect = rect:取并集(v.矩形)
            if rect.h > self.高度 then
                self._sh = rect.h - self.高度 --可滚高度
                if not self._sy then
                    self._sy = 0 --当前滚动值
                end
            else
                self._sh = nil
            end
            if rect.w > self.宽度 then
                self._sw = rect.w - self.宽度
                if not self._sx then
                    self._sx = 0 --当前滚动值
                end
            else
                self._sw = nil
            end
        end
    end
    if self._sh and self._auto then --自动滚动
        self:滚动到底()
    end
end

function GUI控件:_子控件滚动(x, y, v)
    if self._sh and y then
        if y > 0 then
            y = 0
        end
        if math.abs(y) > self._sh then
            y = -self._sh
        end
        self._sy = y

        if v then
            v = self._子控件.竖滚动条
            if v then
                v.位置 = math.floor((math.abs(self._sy) / self._sh) * v.最大值)
            end
        end
    end
end

function GUI控件:向上滚动()
    if self._sh then
        self:_子控件滚动(nil, self._sy + self.高度, true)
    end
end

function GUI控件:向下滚动()
    if self._sh then
        self:_子控件滚动(nil, self._sy - self.高度, true)
        return self:是否到底()
    end
end

function GUI控件:滚动到底()
    if self._sh then
        self:_子控件滚动(nil, -self._sh, true)
    end
end

function GUI控件:是否到底()
    return math.abs(self._sy) == self._sh
end

function GUI控件:自动滚动(v)
    self._auto = v
    return self
end

function GUI控件:_子控件消息(msg)
    local list = {}
    for _, v in pairs(self._子控件) do
        if v.是否可见 then
            table.insert(list, v)
        end
    end

    for i = #self.子控件, 1, -1 do
        local v = self.子控件[i]
        if v.是否可见 then
            table.insert(list, v)
        end
    end

    for _, v in ipairs(list) do
        v:_消息事件(msg)
    end
end

function GUI控件:_消息事件(msg)
    if self.是否禁止 or not self.是否可见 then
        return
    end

    if msg.界面 then
        for k, v in pairs(msg.界面) do
            if type(v) == 'table' then
                self:发送消息(k, table.unpack(v))
            else
                self:发送消息(k, v)
            end
        end
    end

    self:_子控件消息(msg)

    if msg.键盘 and self:发送消息('键盘消息') ~= false then
        for _, v in ipairs(msg.键盘) do
            if v.type == 0x300 then --SDL_KEYDOWN
                if v['repeat'] then
                    self:发送消息('键盘按住', v.keysym.sym, v.keysym.mod)
                else
                    self:发送消息('键盘按下', v.keysym.sym, v.keysym.mod)
                end
            elseif v.type == 0x301 then --SDL_KEYUP
                self:发送消息('键盘弹起', v.keysym.sym, v.keysym.mod)
            end
            if self:发送消息('键盘事件', table.unpack(v)) then
                v[2] = nil
            end
        end
    end

    local tp = ggetype(self)
    if tp == 'GUI控件' or tp == 'GUI弹出控件' then
        --self:_基本事件(msg)
        if msg.鼠标 and self:发送消息('鼠标消息') ~= false then --控件自身获取鼠标获得不到 补充
            for _, v in ipairs(msg.鼠标) do
                if v.type == SDL.MOUSE_DOWN then
                    if self:检查点(v.x, v.y) then
                        if v.button == SDL.BUTTON_LEFT then
                            self._ldown = v.x .. v.y
   
                            self:发送消息('左键按下', v.x, v.y, msg)
                        elseif v.button == SDL.BUTTON_RIGHT then
                            self._rdown = v.x .. v.y
                            self:发送消息('右键按下', v.x, v.y, msg)

                        end

                        if self:检查透明(v.x, v.y) and self:检查消息() ~= false then --窗口下的控件 穿透
                            v.typed, v.type = v.type, nil
                            v.control = self
                        end
                    end
                elseif v.type == SDL.MOUSE_UP then
                    if self:检查点(v.x, v.y) then
                        if v.button == SDL.BUTTON_LEFT then
                            if self._ldown == v.x .. v.y then
                                self:发送消息('左键弹起', v.x, v.y, msg)
                            end
                        elseif v.button == SDL.BUTTON_RIGHT then
                            if self._rdown then
                                self:发送消息('右键弹起', v.x, v.y, msg)
                            end
                        end
                        if self:检查透明(v.x, v.y) and self:检查消息() ~= false then --窗口下的控件 穿透
                            v.typed, v.type = v.type, nil
                            v.control = self
                        end
                    end
                    self._ldown = nil
                    self._rdown = nil

                elseif v.type == SDL.MOUSE_MOTION then
                    if v.state == 0 and self:检查点(v.x, v.y) then
                        if self:发送消息('获得鼠标', v.x, v.y, msg) ~= false and self:检查透明(v.x, v.y) then
                            v.x = -9998
                            v.y = -9999
                        end
                    end
                end
            end
        end


        self:发送消息('消息事件', msg)
        if self:发送消息('消息结束', msg) then
            self:清空消息(msg)
        end
    end
end

function GUI控件:_基本事件(msg)
    if msg.键盘 then
        if self:发送消息('键盘消息', msg.键盘) ~= false then
        end
    end
    if msg.鼠标 then
        if self:发送消息('鼠标消息', msg.鼠标) ~= false then
            for _, v in ipairs(msg.鼠标) do
                if v.type == SDL.MOUSE_DOWN then
                    if v.button == SDL.BUTTON_LEFT or v.button == SDL.BUTTON_RIGHT then
                        if self:检查碰撞(v.x, v.y) then
                            if self:检查消息(v.type) ~= false then
                                v.typed, v.type = v.type, nil
                                v.control = self
                            end
                            if not self.是否禁止 then
                                local x, y = self:取坐标()
                                if v.button == SDL.BUTTON_LEFT then
                                    self:发送消息('左键按下', x, y, v.x, v.y, msg)
                                    self._LEFTDOWN = true
                                elseif v.button == SDL.BUTTON_RIGHT then
                                    self:发送消息('右键按下', x, y, v.x, v.y, msg)
                                    self._RIGHTDOWN = true
                                end
                            end
                        end
                    end
                elseif v.type == SDL.MOUSE_UP then
                    if v.button == SDL.BUTTON_LEFT then
                        if self._LEFTDOWN then
                            self._LEFTDOWN = false
                            if not self.是否禁止 then
                                local x, y = self:取坐标()
                                self:发送消息('左键弹起', x, y, v.x, v.y, msg)
                                if self:检查碰撞(v.x, v.y) then
                                    if self:检查消息(v.type) ~= false then
                                        v.typed, v.type = v.type, nil
                                        v.control = self
                                    end

                                    self:发送消息('左键单击', x, y, v.x, v.y, msg)
                                    if v.clicks == 2 then
                                        self:发送消息('左键双击', x, y, v.x, v.y, msg)
                                    end
                                end
                            end
                        end
                    elseif v.button == SDL.BUTTON_RIGHT then
                        if self._RIGHTDOWN then
                            self._RIGHTDOWN = false
                            if not self.是否禁止 then
                                local x, y = self:取坐标()
                                self:发送消息('右键弹起', x, y, v.x, v.y, msg)
                                if self:检查碰撞(v.x, v.y) then
                                    if self:检查消息(v.type) ~= false then
                                        v.typed, v.type = v.type, nil
                                        v.control = self
                                    end

                                    self:发送消息('右键单击', x, y, v.x, v.y, msg)
                                    if v.clicks == 2 then
                                        self:发送消息('右键双击', x, y, v.x, v.y, msg)
                                    end
                                end
                            end
                        end
                    end
                elseif v.type == SDL.MOUSE_MOTION then
                    if v.state == 0 then --非按下
                        if self:检查碰撞(v.x, v.y) then
                            self.鼠标焦点 = true
                            local x, y = self:取坐标()
                            self:发送消息('获得鼠标', x, y, v.x, v.y, msg) --
                            v.x = -9999
                            v.y = -9999
                        elseif self.鼠标焦点 then
                            self.鼠标焦点 = false
                            self:发送消息('失去鼠标', v.x, v.y, v.x, v.y, msg)
                        end
                    elseif self._LEFTDOWN then
                        if self:检查消息(v.type) ~= false then
                            v.typed, v.type = v.type, nil
                            v.control = self
                        end
                        if v.state & SDL.BUTTON_LMASK == SDL.BUTTON_LMASK then
                            local x, y = self:取坐标()
                            self:发送消息('左键按住', x, y, v.x, v.y, msg)
                        end
                    elseif self._RIGHTDOWN then
                        if self:检查消息(v.type) ~= false then
                            v.typed, v.type = v.type, nil
                            v.control = self
                        end
                        if v.state & SDL.BUTTON_LMASK == SDL.BUTTON_RMASK then
                            local x, y = self:取坐标()
                            self:发送消息('右键按住', x, y, v.x, v.y, msg)
                        end
                    end
                elseif v.type == SDL.MOUSE_WHEEL then
                    if self:检查点(v.x, v.y) then
                        if not self.是否禁止 and not self.禁止滚动 then
                            if self._sh then --竖滚
                                if self:检查消息(v.type) ~= false then
                                    v.typed, v.type = v.type, nil
                                    v.control = self
                                end
                                local y = v.wy * 10 + self._sy
                                self:_子控件滚动(nil, y, true)
                            end
                            local x, y = self:取坐标()
                            self:发送消息('鼠标滚轮', x, y, v.x, v.y, v.wx, v.wy, msg)
                        end
                    end
                end
            end
        end
    end
end

function GUI控件:置精灵(v, wh)
    if type(v) == 'table' and type(v.显示) == 'function' then
        if wh or self._spr == false then
            self.宽度 = v.宽度
            self.高度 = v.高度
            if type(v.取矩形) == 'function' then
                self.矩形 = v:取矩形():复制()
            else
                self.矩形 = require('SDL.矩形')(0, 0, self.宽度, self.高度)
            end
        end
        self._spr = v
    else
        self._spr = nil
    end
    return self
end

function GUI控件:取精灵()
    return self._spr
end

function GUI控件:取控件(name)
    return self.控件[name]
end

function GUI控件:取父控件()
    return self.父控件
end

function GUI控件:取根控件()
    if not self.父控件.取根控件 then
        return self.父控件
    end
    return self.父控件:取根控件()
end

function GUI控件:取窗口()
    if not self.父控件.取窗口 then
        return
    end
    return self.父控件:取窗口()
end

function GUI控件:绝对可见()
    if self.是否可见 then
        return true
    end
    if self.父控件.绝对可见 then
        return self.父控件:绝对可见()
    end
end

function GUI控件:置坐标(x, y) --坐标是相对于父的
    if not y and ggetype(x) == 'GGE坐标' then
        x, y = x:unpack()
    end
    self.x = x or 0
    self.y = y or 0
    self.矩形:置坐标(self:取坐标())
    self:_子控件消息 { 界面 = { 父坐标改变 = { self } } }
    return self
end

function GUI控件:取坐标(hot)
    local x, y = self.x, self.y
    if x < 0 and not self.绝对坐标 then --如果坐标为负数，则值相对于 宽高 - 坐标
        if self.父控件 and self.父控件.宽度 then
            x = x + self.父控件.宽度
        end
    end
    if y < 0 and not self.绝对坐标 then
        if self.父控件 and self.父控件.高度 then
            y = y + self.父控件.高度
        end
    end
    if self._hx and self._hy and hot ~= false then --中心
        x = x - self._hx
        y = y - self._hy
    end
    if self.父控件._sx and ggetype(self) ~= 'GUI滚动' then --滚动
        x = x + self.父控件._sx
    end
    if self.父控件._sy and ggetype(self) ~= 'GUI滚动' then --滚动
        y = y + self.父控件._sy
    end
    if self.父控件.取坐标 then
        local fx, fy = self.父控件:取坐标()
        return x + fx, y + fy
    end
    return x, y
end

function GUI控件:置中心(x, y)
    if not y and ggetype(x) == 'GGE坐标' then
        x, y = x:unpack()
    end
    self._hx = math.floor(x)
    self._hy = math.floor(y)
    self.矩形:置坐标(self:取坐标())
    return self
end

function GUI控件:取中心()
    return self._hx, self._hy
end

function GUI控件:置宽高(w, h)
    self.宽度 = w
    self.高度 = h
    self.矩形:置宽高(w, h)
    self:_子控件消息 { 界面 = { 父宽高改变 = { self } } }
    -- if self.父控件 and self.父控件._刷新滚动 then
    --     self.父控件:_刷新滚动()
    -- end
    return self
end

function GUI控件:取宽高()
    return self.宽度, self.高度
end

function GUI控件:取坐标宽高()
    local x, y = self:取坐标()
    return x, y, self.宽度, self.高度
end

function GUI控件:置宽度(w)
    self.宽度 = w
    self.矩形:置宽高(w, self.高度)
    self:_子控件消息 { 界面 = { 父宽度改变 = { self } } }
    return self
end

function GUI控件:置高度(h)
    self.高度 = h
    self.矩形:置宽高(self.宽度, h)
    self:_子控件消息 { 界面 = { 父高度改变 = { self } } }
    return self
end

function GUI控件:取文字()
    return self._文字
end

function GUI控件:遍历控件()
    local 子控件 = {}
    for i, v in ipairs(self.子控件) do
        子控件[i] = v
    end
    return next, 子控件
end

function GUI控件:置检查区域(x, y, w, h)
    self.矩形:置中心(-x, -y)
    self.矩形:置宽高(w, h)
    return self
end

function GUI控件:检查点(x, y)
    if self.父控件.检查点 then
        return self.父控件:检查点(x, y) and self.矩形:检查点(x, y)
    end
    return self.矩形:检查点(x, y)
end

function GUI控件:检查透明(x, y)
    if self:检查点(x, y) then
        if self._spr and type(self._spr.取透明) == 'function' then
            return self._spr:取透明(x, y) > 0
        end
    end
    return false
end

function GUI控件:检查碰撞(x, y)
    return self:检查透明(x, y)
end

function GUI控件:检查消息(v)
    return true
end

function GUI控件:置可见(val, sub)
    if self._lock then
        self.是否可见 = val == true
        return self
    end
    self._lock = true
    if self:发送消息('可见事件', val) == false then
        return self
    end
    self.是否可见 = val == true

    if not self.是否实例 and val then
        self:发送消息('初始化')
        self.是否实例 = true
        self.父控件._refscroll = true
    end

    self:_子控件消息 { 父控件可见 = self.是否可见 }
    if sub then
        for _, v in ipairs(self.子控件) do
            v:置可见(val, sub)
        end
        for _, v in pairs(self._子控件) do
            v:置可见(val, sub)
        end
    end
    self._lock = nil

    return self
end

function GUI控件:重新初始化(...)
    if self.是否实例 then
        self:发送消息('初始化')
    end
    for _, v in ipairs(self.子控件) do
        v:重新初始化(...)
    end
    for _, v in pairs(self._子控件) do
        v:重新初始化(...)
    end
end

function GUI控件:置禁止(v)
    self.是否禁止 = v == true
    return self
end

function GUI控件:注册事件(k, v)
    if not self._reg then
        self._reg = setmetatable({}, { __mode = 'k' }) --注册消息
    end
    self._reg[k] = v
end

function GUI控件:注销事件(k)
    if k == nil then
        self._reg = nil
    end
    if self._reg then
        self._reg[k] = nil
    end
end

function GUI控件:发送消息(name, ...)
    if self._reg then
        local funs = {}
        for k, v in pairs(self._reg) do
            if v[name] then
                funs[k] = v[name]
            end
        end
        for _, fun in pairs(funs) do
            coroutine.xpcall(fun, self, ...)
        end
    end

    local fun = rawget(self, name)
    if type(fun) == 'function' then
        return coroutine.xpcall(fun, self, ...)
    end
end

function GUI控件:释放()
    for i, v in ipairs(self.子控件) do
        v:释放()
        self[v.名称] = nil
        --释放引用(v)
    end
    self.子控件 = {}
end

function GUI控件:清空消息(msg)
    if msg.鼠标 then
        for _, v in ipairs(msg.鼠标) do
            v.x = -9999
            v.y = -9999
        end
    end
end

function GUI控件:删除控件(name)
    if name then
        local 控件 = self.控件[name]
        if 控件 then
            for i, v in ipairs(self.子控件) do
                if v == 控件 then
                    table.remove(self.子控件, i)
                    break
                end
            end
            self.控件[name] = nil
        end
    else
        for i, v in ipairs(self.子控件) do --?
            self[v.名称] = nil
            self.控件[v.名称] = nil
        end
        self.子控件 = {}
    end
end

function GUI控件:取子控件数量()
    return #self.子控件
end

function GUI控件:创建控件(name, x, y, w, h)
    assert(not self.控件[name], name .. ':此控件已存在，不能重复创建.')
    local r = GUI控件(name, x, y, w, h, self)
    table.insert(self.子控件, r)
    self.控件[name] = r
    return r
end

--===========================================================================
local GUI弹出控件 = class('GUI弹出控件', GUI控件)

function GUI弹出控件:置可见(b, s)
    if not self.是否可见 then
        table.insert(self:取根控件()._popup, self)
    end
    GUI控件.置可见(self, b, s or not self.是否实例)
    return self
end

function GUI控件:创建弹出控件(name, x, y, w, h)
    return GUI弹出控件(name, x, y, w, h, self)
end

--===========================================================================
local GUI提示控件 = class('GUI提示控件', GUI控件)

function GUI提示控件:置可见(b, s)
    local _tip = self:取根控件()._tip
    if b then
        if not _tip[self] then
            table.insert(_tip, self)
            _tip[self] = self
        end
    else
        _tip[self] = nil
    end
    GUI控件.置可见(self, b, s or not self.是否实例)
    return self
end

function GUI控件:创建提示控件(name, x, y, w, h)
    return GUI提示控件(name, x, y, w, h, self)
end

return GUI控件
