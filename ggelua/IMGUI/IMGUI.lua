-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-10-28 18:32:47

local SDL = require('SDL')
local GIM = require 'gimgui'

require('IMGUI.按钮')
require('IMGUI.标签')
require('IMGUI.表格')
require('IMGUI.菜单')
require('IMGUI.窗口')
require('IMGUI.弹出')
require('IMGUI.进度')
require('IMGUI.列表')
require('IMGUI.区域')
require('IMGUI.输入')
require('IMGUI.树')
require('IMGUI.提示')
require('IMGUI.文本')
require('IMGUI.纹理')
require('IMGUI.组合')
local IM控件 = require 'IMGUI.控件'

local IMGUI = class('IMGUI', IM控件)

function IMGUI:初始化(win, font, fsize)
    assert(ggetype(win) == 'SDL窗口', '窗口错误')

    if gge.platform == 'Windows' then
        if type(font) == 'string' then
            local rw = SDL.RWFromFile(font)
            if not rw then
                font = os.getenv('SystemRoot') .. '/Fonts/' .. font
            end
        else
            font = os.getenv('SystemRoot') .. '/Fonts/simsun.ttc'
        end
    end

    self._ctx = GIM.CreateContext()
    GIM.AddFontFromFileTTF(font, fsize or 14)
    GIM.InitForSDLRenderer(win:取对象())

    self._demo = { false }
    self._hook =
    SDL.AddEventHook(
        function(ev)
            GIM.SetCurrentContext(self._ctx)
            return GIM.Event(ev)
        end
    )
end

function IMGUI:__gc()
    GIM.DestroyContext(self._ctx)
end

function IMGUI:更新(dt)
    GIM.SetCurrentContext(self._ctx)
    GIM.NewFrame()
    if self._demo[1] then
        GIM.ShowDemoWindow(self._demo)
    end
    IM控件._更新(self, dt)
    GIM.EndFrame()
end

function IMGUI:显示()
    GIM.SetCurrentContext(self._ctx)
    GIM.Render()
end

function IMGUI:打开DEMO()
    self._demo = { true }
    return self
end

function IMGUI:添加文字(font, fsize)
    GIM.AddFontFromFileTTF(font, fsize or 14)
end

return IMGUI
