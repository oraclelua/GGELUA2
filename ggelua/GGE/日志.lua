-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-06-09 01:15:52

local cprint = require('cprint')
local _isdebug = require('ggelua').isdebug
local GGF = require('GGE.函数')
if _isdebug then
    cprint = print
end
local lcolor = {
    INFO = '\x1b[47;30mINFO\x1b[0m',
    WARN = '\x1b[43;30mWARN\x1b[0m',
    ERROR = '\x1b[41;30mERROR\x1b[0m'
}

local GGE日志 = class('GGE日志')

function GGE日志:GGE日志(file, logger)
    self._logger = logger or 'GGELUA'
    file = string.format("%s_%s.log", file, os.date('%Y-%m-%d', os.time()))
    self._file = assert(io.open(file, 'a+'), '打开失败')
    self._file:setvbuf("no", 0)
end

function GGE日志:GGE管理日志(账号)
    self._logger = logger or 'GGELUA'
    if not GGF.判断文件('管理日志/' .. 账号 .. '/') then
        GGF.写出文件('管理日志/' .. 账号 .. '/')
    end
    local file = string.format("管理日志/%s/%s.log", 账号, os.date('%Y-%m-%d', os.time()))
    self._file = assert(io.open(file, 'a+'), '打开失败')
    self._file:setvbuf("no", 0)
end

function GGE日志:GGE角色日志(账号, id)
    self._logger = logger or 'GGELUA'
    if not GGF.判断文件('角色日志/' .. 账号 .. '/' .. id .. '/') then
        GGF.写出文件('角色日志/' .. 账号 .. '/' .. id .. '/')
    end
    local file = string.format("角色日志/%s/%s/%s.log", 账号, id, os.date('%Y-%m-%d', os.time()))
    self._file = assert(io.open(file, 'a+'), '打开失败')
    self._file:setvbuf("no", 0)
end

function GGE日志:LOG2(msg, ...)
    ggexpcall(
        function(...)
            if select('#', ...) > 0 then
                msg = msg:format(...)
            end
            local time = os.time()
            --  cprint(string.format('[%s] %s', os.date('%X', time), tostring(msg)))
            if self._file then
                self._file:write(string.format('[%s]  %s\n', os.date('%X', time), tostring(msg)))
            end
        end,
        ...
    )
end

function GGE日志:LOG(level, msg, ...)
    ggexpcall(
        function(...)
            if select('#', ...) > 0 then
                msg = msg:format(...)
            end
            local time = os.time()
            cprint(string.format('[%s] [%s] [%s] %s', os.date('%X', time), self._logger, lcolor[level] or level,
                tostring(msg)))
            if self._file then
                --self._file:write("---------------------------------------------------------------\n")
                self._file:write(string.format('[%s] [%s] [%s] %s\n', os.date('%X', time), self._logger, level,
                    tostring(msg)))
            end
        end,
        ...
    )
end

function GGE日志:INFO(msg, ...)
    self:LOG('INFO', msg, ...)
end

function GGE日志:WARN(msg, ...)
    self:LOG('WARN', msg, ...)
end

function GGE日志:ERROR(msg, ...)
    self:LOG('ERROR', msg, ...)
end

function GGE日志:DEBUG(msg, ...)
    if _isdebug then
        self:LOG('DEBUG', msg, ...)
    end
end

function GGE日志:print(...)
    local arg = {}
    for i = 1, select('#', ...) do
        arg[i] = tostring(select(i, ...))
    end
    self:LOG('INFO', table.concat(arg, '\t'))
end

return GGE日志
