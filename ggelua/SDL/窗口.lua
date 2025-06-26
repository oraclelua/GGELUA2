-- @Author              : GGELUA
-- @Date                : 2022-03-21 14:01:02
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-12-27 02:56:35

local SDL = require('SDL')
local gge = require('ggelua')
local type = type
local pairs = pairs
local ipairs = ipairs
local ggexpcall = ggexpcall
local next = next

local SDL渲染 = class('SDL渲染')
local SDL窗口 = class('SDL窗口', SDL渲染)

function SDL窗口:SDL窗口(t)
    for k, v in pairs(t) do
        if self[k] then
            error('名称冲突:' .. k)
        else
            self[k] = v
        end
    end
    self.标题 = t.标题 or 'GGELUA Game Engine'
    self.原始标题 = self.标题
    self.宽度 = t.宽度 or 800
    self.高度 = t.高度 or 600
    self.帧率 = t.帧率 or 60
    self.是否全屏 = t.全屏
    self.宽度2 = self.宽度 // 2
    self.高度2 = self.高度 // 2
    self.x = 0
    self.y = 0

    local flags = 0

    SDL.SetHint('SDL_RENDER_BATCHING', '1') --批渲染
    SDL.SetHint('SDL_MOUSE_FOCUS_CLICKTHROUGH', '1') --非焦点触发鼠标

    if gge.platform == 'Android' or gge.platform == 'iOS' then
        self.是否全屏 = t.全屏 ~= false
        t.渲染器 = 'opengles2'

        if self.宽度 > self.高度 then --横向
            SDL.SetHint('SDL_IOS_ORIENTATIONS', 'LandscapeLeft LandscapeRight')
        else
            SDL.SetHint('SDL_IOS_ORIENTATIONS', 'Portrait')
        end

        --SDL.SetHint('SDL_RENDER_SCALE_QUALITY', 'linear')
        if self.是否全屏 then
            flags = flags | 0x00001000 --SDL_WINDOW_FULLSCREEN_DESKTOP
        end
        if SDL._win then
            return
        end
    else
        if t.渲染器 == nil and t.渲染器 ~= false then
            t.渲染器 = 'opengl'
        end

        SDL.SetHint('SDL_IME_SHOW_UI', '1')
    end

    if type(t.渲染器) == 'string' then
        SDL.SetHint('SDL_RENDER_DRIVER', t.渲染器)
        if t.渲染器 == 'opengl' then
            flags = flags | 0x00000002 --SDL_WINDOW_OPENGL
        end
    end

    if self.是否全屏 then
        flags = flags | 0x00000001 --SDL_WINDOW_FULLSCREEN
    end

    if t.无边框 then --隐藏边框
        flags = flags | 0x00000010 --SDL_WINDOW_BORDERLESS
    end

    if t.隐藏 or t.隐藏 == nil then
        flags = flags | 0x00000008 --SDL_WINDOW_HIDDEN
    end
    self.是否隐藏 = t.隐藏

    if t.可调整 then --可调整
        flags = flags | 0x00000020 --SDL_WINDOW_RESIZABLE
    end

    if t.任务栏 == false then --隐藏任务栏
        flags = flags | 0x00010000 --SDL_WINDOW_SKIP_TASKBAR
    end

    if gge.platform == 'Windows' and t.异形 then
        self._win = assert(SDL.CreateShapedWindow(self.标题, t.x, t.y, self.宽度, self.高度, flags), SDL.GetError())
    else
        self._win = assert(SDL.CreateWindow(self.标题, t.x, t.y, self.宽度, self.高度, flags), SDL.GetError())
    end

    local id = self._win:GetWindowID()
    SDL._wins[id] = self
    if gge.platform == 'Windows' then
        SDL.CreateEvent(0x200, id, 0):PushEvent()
    end

    if gge.platform == 'Windows' and ggetype(t.父窗口) == 'SDL窗口' then
        self._win:SetParent(t.父窗口._win)
    end

    SDL.ShowCursor(t.鼠标 ~= false)
    self.FPS = math.abs(self.帧率)
    self._ft = self.FPS > 0 and (1 / self.FPS) or 0
    self._dt = 0
    if self._ft < SDL._ft or SDL._ft == 0 then
        SDL._ft = self._ft
    end

    if not SDL._win then --主窗口
        SDL._mth = SDL.ThreadID()
        SDL._win = self
    end

    if t.渲染器 == false then
        self._sf = self._win:GetWindowSurface()
        self._sfrect = SDL.CreateRect(0, 0, self.宽度, self.高度)
    else
        self:SDL渲染() --创建渲染器
    end

    self._reg = setmetatable({}, { __mode = 'k' }) --注册消息
    self._tick = {}
    self._timer = setmetatable({}, { __mode = 'kv' }) --定时器
end

local function _Sendreg(self, k, ...)
    local reg = {}
    for _, v in pairs(self._reg) do
        if type(v[k]) == 'function' then
            table.insert(reg, v)
        end
    end
    for _, v in ipairs(reg) do
        ggexpcall(v[k], v, ...)
    end
end

local function _Sendmsg(self, k, ...)
    if type(self[k]) == 'function' then
        return ggexpcall(self[k], self, ...)
    end
end

local function _Destroy(self)
    _Sendmsg(self, '销毁事件')
    _Sendreg(self, '销毁事件')
    if self._sf then
        self._sf:__gc()
    end
    if SDL._win == self then
        for _, v in pairs(SDL._sfs) do
            v:__gc()
        end
        SDL._sfs = {} --图像
        for _, v in pairs(SDL._mixs) do
            v:__gc()
        end
        SDL._mixs = {} --音效
        for _, v in pairs(SDL._ttfs) do
            v:__gc()
        end
        SDL._ttfs = {} --文字
        for _, v in pairs(SDL._wins) do
            if v ~= self then
                _Destroy(v)
            end
        end
        collectgarbage()
    end

    self[SDL渲染]:__gc() --纹理

    if self._win then
        print('DestroyWindow', self.标题)
        SDL._wins[self._win:GetWindowID()] = nil
        self._win:DestroyWindow()
        collectgarbage()
    end
    if SDL._win == self then
        print('QuitAll')
        if SDL.IMG then
            SDL.IMG.Quit()
        end
        if SDL.MIX then
            SDL.MIX.Quit()
        end
        if SDL.TTF then
            SDL.TTF.Quit()
        end
        gge.exit()
        SDL.Quit()
    end
    self._win = nil
end

function SDL窗口:_Event(tp, t, ...)
    if tp == nil then
        if next(self._tick) then --协程定时
            local oc = SDL.GetTicks()
            for co, t in pairs(self._tick) do
                if oc >= t then
                    coroutine.xpcall(co)
                end
            end
        end
        if next(self._timer) then --函数定时
            local oc = SDL.GetTicks()
            local timer = {}
            for k, t in pairs(self._timer) do
                if oc >= t.time then
                    timer[k] = t
                end
            end
            for k, t in pairs(timer) do
                t.ms = ggexpcall(t.fun, t.ms, table.unpack(t.arg))
                if t.ms == 0 or type(t.ms) ~= 'number' then
                    self._timer[k] = nil
                else
                    t.time = t.ms + oc
                end
            end
        end

        if self._quit then
            _Destroy(self)
            return SDL._win == self
        elseif self._inited then
            local dt, x, y = t, ...
            self._dt = self._dt + dt -- 多个不同帧率的窗口
            if self._dt + 0.001 > self._ft then
                self.dt = self._dt
                self.x = x
                self.y = y
                self._dt = 0
                _Sendreg(self, '更新事件', self.dt, x, y) --注册事件
                _Sendmsg(self, '更新事件', self.dt, x, y)
                _Sendmsg(self, '渲染事件', self.dt, x, y)
                -- _Sendreg(self, '渲染事件', self.dt, x, y)
                if self._fps then
                    self._fps = self._fps + 1
                    if SDL.GetTicks() - self._ftk > 1000 then
                        self._ftk = SDL.GetTicks()
                        self.FPS = self._fps
                        self._fps = 0
                    end
                end
            end
        end
    elseif tp == 0x100 then --SDL_QUIT
        --self:_Event(0x200, { event = SDL.WINDOWEVENT_CLOSE })
    elseif tp == 0x200 then --SDL_WINDOWEVENT
        if t.event == 0 then
            if not self._inited then
                if self._rdr then --设置黑色
                    self:渲染开始(0, 0, 0)
                    self:渲染结束()
                    self._rdr:RenderFlush()
                end

                if self.初始化 then
                    ggexpcall(self.初始化, self)
                end
                if self.是否隐藏 == nil then
                    self._win:ShowWindow()
                end
                self._inited = true
            end
        elseif t.event == SDL.WINDOWEVENT_SIZE_CHANGED then --更改大小
            --SDL.Log('WINDOWEVENT_SIZE_CHANGED %d %d', t.data1, t.data2)
            if gge.platform == 'Android' or gge.platform == 'iOS' then
                if self._inited then
                    return
                end
                local w, h, scale = t.data1, t.data2, nil
                if self.宽度 > self.高度 and w < h then
                    w, h = h, w
                end
                SDL.Log('渲染宽高 %d %d %d %d', self.宽度, self.高度, w, h)
                if self.宽度 > self.高度 then --横屏
                    scale = self.高度 / h
                else
                    scale = self.宽度 / w
                end
                w, h = math.floor(w * scale), math.floor(h * scale) --刘海？
                SDL.Log('逻辑宽高 %d %d', w, h)
                self:置逻辑宽高(w, h)

                local id = self._win:GetWindowID()
                SDL.CreateEvent(0x200, id, 0):PushEvent()

                return --不发出
            else
                self.宽度, self.高度 = t.data1, t.data2
                self.宽度2, self.高度2 = t.data1 // 2, t.data2 // 2

                if self._sf then --更改大小后sf会失效，只能在SDL_WINDOWEVENT_SIZE_CHANGED重新获取
                    self._sf:__gc() --需要先把旧的删除
                    self._sf = self._win:GetWindowSurface()
                elseif self._prt then --手机渲染区
                    self._prt = self._rdr:CreateTexture(self.宽度, self.高度, SDL.TEXTUREACCESS_TARGET)
                    --self._prt:SetTextureScaleMode(1)
                end
            end
        elseif t.event == SDL.WINDOWEVENT_ENTER then --鼠标进入
            SDL.ShowCursor(self.鼠标 ~= false)
        end
        _Sendreg(self, '窗口事件', t.event, t.data1, t.data2, t)
        _Sendmsg(self, '窗口事件', t.event, t.data1, t.data2)
    elseif tp == 0x201 then --SDL_SYSWMEVENT
        if t.msg then
            if t.msg.hwnd ~= self:取句柄() then
                return
            end
            _Sendmsg(self, '窗口消息', t.msg.msg, t.msg.wParam, t.msg.lParam)
        end

    elseif tp == 0x300 or tp == 0x301 then --SDL_KEYDOWN|SDL_KEYUP
        _Sendreg(self, '键盘事件', t.keysym.sym, t.keysym.mod, t.state, t['repeat'], t)
        _Sendmsg(self, '键盘事件', t.keysym.sym, t.keysym.mod, t.state, t['repeat'])
    elseif tp == 0x302 then --SDL_TEXTEDITING
        _Sendreg(self, '输入法事件', t.text, t)
        _Sendmsg(self, '输入法事件', t.text)
    elseif tp == 0x303 then --SDL_TEXTINPUT
        _Sendreg(self, '输入事件', t.text, t)
        _Sendmsg(self, '输入事件', t.text)
    elseif tp == 0x400 then --SDL_MOUSEMOTION
        _Sendreg(self, '鼠标事件', t.type, t.x, t.y, t.state, t)
        _Sendmsg(self, '鼠标事件', t.type, t.x, t.y, t.state)
    elseif tp == 0x401 or tp == 0x402 then --SDL_MOUSEBUTTONDOWN|SDL_MOUSEBUTTONUP
        _Sendreg(self, '鼠标事件', t.type, t.x, t.y, t.button, t.clicks, t)
        _Sendmsg(self, '鼠标事件', t.type, t.x, t.y, t.button, t.clicks)
    elseif tp == 0x403 then --SDL_MOUSEWHEEL
        _Sendreg(self, '鼠标事件', t.type, t.y, t.direction, t)
        _Sendmsg(self, '鼠标事件', t.type, t.y, t.direction)
    elseif tp == 0x700 or tp == 0x701 or tp == 0x702 then --SDL_FINGERMOTION|SDL_FINGERDOWN|SDL_FINGERUP
        local x, y = math.floor(t.x * self.宽度), math.floor(t.y * self.高度)
        local dx, dy = t.dx, t.dy --速度
        _Sendreg(self, '触摸事件', t.type, x, y, dx, dy, t.fingerId, t.touchId)
        _Sendmsg(self, '触摸事件', t.type, x, y, dx, dy, t.fingerId, t.touchId)
    elseif tp == 0x802 then --SDL_MULTIGESTURE
    elseif tp == 0x1000 then --SDL_DROPFILE|SDL_DROPTEXT
        _Sendreg(self, '窗口事件', t.type, t.file, t)
        _Sendmsg(self, '窗口事件', t.type, t.file)
    elseif tp == 0x1100 or tp == 0x1101 then --SDL_AUDIODEVICEADDED
        _Sendreg(self, '设备事件', t)
        _Sendmsg(self, '设备事件', t)
    elseif tp == 0x2000 then --SDL_RENDER_TARGETS_RESET
        print('渲染区丢失')
        if self._prt then
            -- body
        end
    elseif tp == 0x2001 then --SDL_RENDER_DEVICE_RESET
        print('设备重启')
    else
        SDL.Log('event %x', t.type)
    end
end

function SDL窗口:注册事件(k, t)
    if t == nil then
        t = k
        k = {}
    end
    if type(t) == 'table' then
        self._reg[k] = t
        return k, t
    end
end

function SDL窗口:取消注册事件(k)
    self._reg[k] = nil
end

--SDL.AddTimer是线程回调
function SDL窗口:定时(ms, fun, ...)
    if type(fun) == 'function' then
        local t = { ms = ms, time = SDL.GetTicks() + ms, fun = fun, arg = { ... } }
        self._timer[t] = t
        t.删除 = function()
            self._timer[t] = nil
        end
        return t
    end
    local co, main = coroutine.running()
    if not main then
        self._tick[co] = SDL.GetTicks() + ms
        coroutine.yield()
        self._tick[co] = nil
        return true
    end
end

function SDL窗口:关闭()
    self._quit = true
end

function SDL窗口:取对象()
    return self._win
end

function SDL窗口:置子窗口(hwnd, x, y)
    return self._win:SetChild(hwnd, x, y)
end

function SDL窗口:显示图像(sf, x, y, rect)
    if self._sf then
        if ggetype(sf) == 'SDL图像' then
            sf = sf:取对象()
        end
        self._sfrect:SetRectXY(x, y)
        return sf:BlitSurface(rect, self._sf, self._sfrect)
    end
end

function SDL窗口:取FPS()
    if not self._fps then
        self._fps = 0
        self._ftk = SDL.GetTicks()
    end
    return self.FPS
end

function SDL窗口:取ID()
    return self._win:GetWindowID()
end

SDL.MESSAGEBOX_ERROR = 0x00000010 --错误图标
SDL.MESSAGEBOX_WARNING = 0x00000020 --警告图标
SDL.MESSAGEBOX_INFORMATION = 0x00000040 --信息图标
function SDL窗口:消息框(title, message, flags)
    return self._win:ShowSimpleMessageBox(flags, tostring(title), tostring(message))
end

function SDL窗口:置隐藏(v)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self.是否隐藏 = v
    if v then
        self._win:HideWindow()
    else
        self._win:ShowWindow()
    end
end

function SDL窗口:置最前(b)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:SetWindowAlwaysOnTop(b)
end

function SDL窗口:最大化()
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:MaximizeWindow()
end

function SDL窗口:最小化()
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:MinimizeWindow()
end

function SDL窗口:置边框(b)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:SetWindowBordered(b)
end

function SDL窗口:置动态宽高(b)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:SetWindowResizable(b)
end

function SDL窗口:置最小宽高(w, h) --SDL_WINDOW_RESIZABLE
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:SetWindowMinimumSize(w, h)
end

function SDL窗口:取最小宽高() --SDL_WINDOW_RESIZABLE
    return self._win:GetWindowMinimumSize()
end

function SDL窗口:置最大宽高(w, h) --SDL_WINDOW_RESIZABLE
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:SetWindowMaximumSize(w, h)
end

function SDL窗口:取最大宽高() --SDL_WINDOW_RESIZABLE
    return self._win:GetWindowMaximumSize()
end

function SDL窗口:置标题(v, ...)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    if select('#', ...) > 0 then
        v = v:format(...)
    end
    self._win:SetWindowTitle(v)
end

function SDL窗口:取标题()
    return self._win:GetWindowTitle()
end

function SDL窗口:置图像(v)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    if ggetype(v) == 'SDL图像' and self._win:IsShapedWindow() then
        local sf = v:取对象()
        self._win:SetWindowSize(sf.w, sf.h)
        return self._win:SetWindowShape(sf)
    end
    return false
end

function SDL窗口:置图标(v)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    if ggetype(v) == 'SDL图像' then
        self._win:SetWindowIcon(v:取对象())
    end
end

function SDL窗口:置坐标(x, y)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    if not y and ggetype(x) == 'GGE坐标' then
        x, y = x:unpack()
    end
    self._win:SetWindowPosition(x, y)
end

function SDL窗口:取坐标()
    return self._win:GetWindowPosition()
end

function SDL窗口:置宽高(w, h)
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self._win:SetWindowSize(w, h)
end

function SDL窗口:取宽高()
    return self._win:GetWindowSize()
end

function SDL窗口:置全屏(b, t) --SDL_WINDOW_FULLSCREEN_DESKTOP
    assert(SDL._mth == SDL.ThreadID(), '无法在线程中调用')
    self.是否全屏 = b
    if t then
        self._win:SetWindowDisplayMode(t)
    end
    if type(b) ~= 'number' then
        b = b and 1 or 0
    end
    return self._win:SetWindowFullscreen(b)
end

function SDL窗口:取句柄()
    return self._win:GetWindowWMInfo().info.window
end

function SDL窗口:取边框大小() --上左下右
    return self._win:GetWindowBordersSize()
end

--SetWindowGrab 锁定鼠标
--SetWindowBrightness 伽玛
--SetWindowOpacity 透明
--========================================================================================================
function SDL窗口:取屏幕键盘状态()
    if self._win then
        return self._win:IsScreenKeyboardShown()
    end
end

function SDL窗口:取键盘焦点()
    if self._win then
        return self._win:GetKeyboardFocus()
    end
end

function SDL窗口:取按键状态(key)
    if self._win then
        return self._win:GetKeyboardState(SDL.GetScancodeFromKey(key))
    end
end

function SDL窗口:取功能键状态(key)
    if self._win then
        return self._win:GetModState(key)
    end
end

function SDL窗口:取鼠标焦点()
    if self._win then
        return self._win:GetMouseFocus()
    end
end

--返回按下的键组合和坐标
function SDL窗口:取鼠标状态()
    if self._win then
        return SDL.GetMouseState()
    end
end

function SDL窗口:取鼠标坐标()
    if self._win then
        local _, x, y = SDL.GetMouseState()
        return x, y
    end
end

function SDL窗口:创建图像(...)
    local owin = SDL._win
    SDL._win = self
    local r = require('SDL.图像')(...)
    SDL._win = owin
    return r
end

--@param type 渲染器类型{'auto','opengl'}
function SDL窗口:创建渲染器(t)
    if self._sf then
        self._sf:__gc()
        self._sf = nil
        self._sfrect = nil
    end
end

function SDL窗口:创建窗口(t)
    t.父窗口 = self
    if not t.宽度 then
        t.宽度 = self.宽度
    end
    if not t.高度 then
        t.高度 = self.高度
    end
    return SDL窗口(t)
end

--===========================================================================================================
--===========================================================================================================
--===========================================================================================================
function SDL渲染:SDL渲染()
    self._rdr = assert(self._win:CreateRenderer(-1, 10), SDL.GetError()) --10=SDL_RENDERER_ACCELERATED|SDL_RENDERER_TARGETTEXTURE
    self._rdr:SetRenderDrawBlendMode(SDL.BLENDMODE_BLEND)

    assert(self._rdr:RenderTargetSupported(), '不支持')
    self._texs = setmetatable({}, { __mode = 'kv' }) --纹理列表
    local name = self._rdr:GetRendererInfo().name

    SDL.Log('渲染器 %s %d %d', name, self.宽度, self.高度)

    self._cr = {} --clip
    self._vr = SDL.CreateRect() --view
    -- for i=0,SDL.GetNumRenderDrivers()-1 do--CreateRenderer第1参数来启用相应的渲染器，(-1)第1个
    --     SDL.Log("渲染器 %d %s",i,SDL.GetRenderDriverInfo(i).name)
    -- end

    -- for k,v in pairs(self._rdr:GetRendererInfo()) do
    --     print(k,v)
    -- end

    -- for i,v in ipairs(self._rdr:GetRendererInfo().texture_formats) do--支持格式
    --     print(i,v,SDL.GetPixelFormatName(v))
    -- end

    -- for k,v in pairs(self._win:GetWindowDisplayMode()) do
    --     if k == 'format' then
    --         print(SDL.GetPixelFormatName(v))
    --     end
    --     print(string.format( "%s,%s",k,v ))
    -- end

    -- SDL.Log("OutputSize %d,%d",self._rdr:GetRendererOutputSize())
    -- SDL.Log("LogicalSize %d,%d",self._rdr:RenderGetLogicalSize())
    --print(self._rdr:RenderGetIntegerScale())

    --print(SDL.GetPixelFormatName(self._win:GetWindowPixelFormat()))
end

function SDL渲染:__gc()
    if self._rdr then
        print('DestroyTexture')
        for k, v in pairs(self._texs) do
            v:__gc()
        end
        self._texs = {} --纹理
        print('DestroyRenderer')
        self._rdr:DestroyRenderer()
        self._rdr = nil
        collectgarbage()
    end
end

function SDL渲染:显示纹理(tex, srcrect, dstrect, angle, flip, centerx, centery)
    if self._rdr then
        if angle or flip then
            return self._rdr:RenderCopyEx(tex, srcrect, dstrect, angle, flip, centerx, centery)
        end
        return self._rdr:RenderCopy(tex, srcrect, dstrect)
    end
end

function SDL渲染:取渲染器()
    return self._rdr
end

-- function SDL渲染:是否支持渲染区()
--     return self._rdr and self._rdr:RenderTargetSupported()
-- end

function SDL渲染:创建渲染区(w, h)
    if self._rdr then
        return self._rdr:CreateTexture(w, h) --SDL_PIXELFORMAT_ARGB8888,SDL_TEXTUREACCESS_TARGET
    end
end

function SDL渲染:置渲染区(tex)
    if self._rdr and tex then
        if self._rtg then
            return false
        else
            self._rtg = tex
            if ggetype(tex) == 'SDL纹理' then
                self._rdr:SetRenderTarget(tex:取对象())
            else
                self._rdr:SetRenderTarget(tex)
            end
            return true
        end
    end
    self._rtg = nil
    self._rdr:SetRenderTarget()
end

function SDL渲染:取渲染区(tex)
    return self._rtg
end

function SDL渲染:渲染开始(r, g, b, a)
    if self._rdr then
        if self._prt then --手机渲染区
            self:置渲染区(self._prt)
        end
        self._rdr:SetRenderDrawColor(r, g, b, a)
        return self._rdr:RenderClear()
    elseif self._sf then
        self._sf:FillRect(r, g, b)
    end
    return true
end

SDL渲染.渲染清除 = SDL渲染.渲染开始
function SDL渲染:渲染结束()
    if self._rdr then
        --_Sendreg(self, '渲染事件', self.dt, self.x, self.y)
        if self._prt then --手机渲染区
            self:置渲染区()
            self._rdr:RenderCopy(self._prt)
        end
        self._rdr:RenderPresent()
    else
        self._win:UpdateWindowSurface()
    end
end

function SDL渲染:置颜色(r, g, b, a)
    if self._rdr then
        self._rdr:SetRenderDrawColor(r, g, b, a)
    else
        self._sf:SetSurfaceColorMod(r, g, b, a)
    end
    return self
end

function SDL渲染:画点(x, y)
    if self._rdr then
        self._rdr:RenderDrawPoint(x, y)
    end
    return self
end

function SDL渲染:画线(x, y, x1, y1)
    if self._rdr then
        self._rdr:RenderDrawLine(x, y, x1, y1)
    end
    return self
end

function SDL渲染:画矩形(a, ...)
    if self._rdr then
        local tp = ggetype(a)
        local rect, fill
        if tp == 'SDL矩形' then
            rect = a:取对象()
            fill = ...
        elseif tp == 'SDL_Rect' then
            rect = a
            fill = ...
        elseif tp == 'number' then
            local x, y, w, h
            x, y, w, h, fill = a, ...
            rect = SDL.CreateRect(x, y, w, h)
        end

        if rect then
            if fill then
                return self._rdr:RenderFillRect(rect)
            end
            return self._rdr:RenderDrawRect(rect)
        end
    else
        --self._sf:FillRect(r, g, b, rect)
    end
    return self
end

function SDL渲染:置逻辑宽高(w, h)
    if self._rdr:RenderSetLogicalSize(w, h) then
        if w == 0 or h == 0 then
            self.宽度, self.高度 = self._rdr:GetRendererOutputSize()
        else
            self.宽度, self.高度 = w, h
        end

        self.宽度2 = self.宽度 // 2
        self.高度2 = self.高度 // 2
        if w == 0 or h == 0 then
            self._prt = nil
        else
            self._prt = self._rdr:CreateTexture(self.宽度, self.高度, SDL.TEXTUREACCESS_TARGET)
            self._prt:SetTextureScaleMode(1) --SDL_ScaleModeLinear
        end
        return true
    else
        SDL.Log(SDL.GetError())
    end
end

function SDL渲染:取逻辑宽高()
    return self._rdr:RenderGetLogicalSize()
end

function SDL渲染:取渲染宽高()
    return self._rdr:GetRendererOutputSize()
end

function SDL渲染:置区域(x, y, w, h)
    if x then
        local rect = SDL.CreateRect(x, y, w, h)
        if self._cr[1] then
            rect = self._cr[1]:IntersectRect(rect)
        end
        if rect.w <= 0 or rect.h <= 0 then
            return
        end
        table.insert(self._cr, 1, rect)
    else
        table.remove(self._cr, 1)
    end

    local rect = self._cr[1]
    if self._rdr then
        if rect then
            self._rdr:RenderSetClipRect() --批渲染需要清空
        end
        self._rdr:RenderSetClipRect(rect)
    else
        self._sf:SetClipRect(rect)
    end
    return rect
end

function SDL渲染:取区域()
    if self._rdr then
        if self._cr[1] then
            return self._cr[1]:GetRect()
        end
        return 0, 0, 引擎.宽度, 引擎.高度
    end
end

function SDL渲染:置视图(x, y, w, h)
    assert(gge.platform == 'Windows', '手机平台无效')
    if self._rdr then
        if x then
            self._vr:SetRect(x, y, w, h)
            self._rdr:RenderSetViewport(self._vr)
        else
            self._rdr:RenderSetViewport()
        end
    end
    return self
end

function SDL渲染:取视图()
    return self._rdr and self._vr:GetRect()
end

function SDL渲染:置缩放(x, y)
    assert(gge.platform == 'Windows', '手机平台无效')
    if self._rdr then
        self._rdr:RenderSetScale(x, y)
    end
    return self
end

function SDL渲染:取缩放()
    return self._rdr and self._rdr:RenderGetScale()
end

function SDL渲染:取实际坐标(x, y)
    if self._rdr then
        return self._rdr:RenderLogicalToWindow(x, y)
    end
end

function SDL渲染:取逻辑坐标(x, y)
    if self._rdr then
        return self._rdr:RenderWindowToLogical(x, y)
    end
end

--如果是渲染区，则需要在渲染结束前调用
function SDL渲染:截图到图像(dst, x, y, w, h)
    if self._rdr then
        if not w or not h then
            w, h = self:取渲染宽高()
        end
        if dst then
            if dst.宽度 < w or dst.高度 < h then
                dst = self:创建图像(w, h)
            end
        else
            dst = self:创建图像(w, h) --372645892=SDL_PIXELFORMAT_ARGB8888
        end
        local pixels, pitch = dst:锁定()
        if pixels then
            local rect
            if x and y and w and h then
                rect = SDL.CreateRect(x, y, w, h)
            end
            local r = self._rdr:RenderReadPixels(rect, 372645892, pixels, pitch)
            dst:解锁()
            return r and dst
        end
    end
end

function SDL渲染:截图到文件(...)
    self:截图到图像():保存文件(...)
    return self
end

function SDL渲染:截图到纹理(dst, x, y, w, h)
    if self._rdr then
        if not w or not h then
            w, h = self:取渲染宽高()
        end
        if dst then
            if dst.宽度 < w or dst.高度 < h then
                dst = self:创建纹理(w, h, SDL.TEXTUREACCESS_STREAMING)
            end
        else
            dst = self:创建纹理(w, h, SDL.TEXTUREACCESS_STREAMING) --372645892=SDL_PIXELFORMAT_ARGB8888
        end

        local pixels, pitch = dst:锁定()
        if pixels then
            local rect
            if x and y and w and h then
                rect = SDL.CreateRect(x, y, w, h)
            end
            local r = self._rdr:RenderReadPixels(rect, 372645892, pixels, pitch)
            dst:解锁()
            return r and dst
        end
    end
end

function SDL渲染:创建精灵(...)
    if self._rdr then
        local owin = SDL._win
        SDL._win = self
        local r = require('SDL.精灵')(...)
        SDL._win = owin
        return r
    end
end

function SDL渲染:创建纹理(...)
    if self._rdr then
        local owin = SDL._win
        SDL._win = self
        local r = require('SDL.纹理')(...)
        SDL._win = owin
        return r
    end
end

function SDL渲染:创建文字(...)
    if self._rdr then
        local owin = SDL._win
        SDL._win = self
        local r = require('SDL.文字')(...)
        SDL._win = owin
        return r
    end
end

return SDL窗口
