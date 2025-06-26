-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-10-28 18:24:44
-- @Last Modified time  : 2022-10-28 18:31:09
local im = require 'gimgui'
local IM控件 = require 'IMGUI.控件'

local IM进度 = class('IM进度', IM控件)

function IM进度:初始化(name)
    self._name = name .. '##' .. tostring(self)
    self.位置 = 0
    self.最大值 = 100
    self.最小值 = 0
end

function IM进度:_更新(dt)

    im.ProgressBar(self.位置 / self.最大值)

    IM控件._更新(self, dt)
    IM控件._检查鼠标(self)
end

--==============================================================================
function IM控件:创建进度(name, ...)
    assert(self[name] == nil, name .. '->已经存在')
    self[name] = IM进度(name, ...)
    table.insert(self._子控件, self[name])
    return self[name]
end

return IM进度
