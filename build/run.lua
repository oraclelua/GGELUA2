-- @Author              : GGELUA
-- @Date                : 2022-01-25 22:14:50
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2022-06-05 14:42:34
require('build/base')

if arg[1] == 'windows' then
    pcall(require, 'ggerun')
    执行('%s/GGELUAc.exe %s %s', 引擎目录, 项目目录, table.concat(arg, ' ', 3))
    return
end

编译目录('ggelua')
编译目录('./lua')
写出脚本('./.ggelua/ggelua')
local lfs = require('lfs')
--载入已经上传过的
list = 判断文件('./.ggelua/assetslist.lua') and require('assetslist') or {}
if type(list) ~= 'table' then
    list = {}
end
--检查版本
--adb shell pm dump com.GGELUA.game | findstr "versionName"
--安装APP
local r = 执行('adb shell pm list packages | findstr "com.GGELUA.game"')
if not r then
    list = {}
    执行('adb install -t %s/build/android/ggelua.apk', 引擎目录)
end
--停止APP
执行('adb shell am force-stop com.GGELUA.game')
执行('adb shell "run-as com.GGELUA.game mkdir -pv /data/data/com.GGELUA.game/files/assets"')

function 推送文件(file)
    --https://blog.csdn.net/niubitianping/article/details/110009007
    执行('adb push %s/%s /sdcard/GGELUA/%s', 项目目录, file, file)
    执行('adb shell run-as com.GGELUA.game mkdir -pv /data/data/com.GGELUA.game/files/' .. file:match('(.+)/'))
    执行('adb shell "run-as com.GGELUA.game cp -fv /sdcard/GGELUA/%s /data/data/com.GGELUA.game/files/%s"', file, file)
end

function 推送目录(path)
    local dir = path:match('.*/(.*)')
    for path, rel in 遍历目录(path) do
        rel = dir .. '/' .. rel
        local t = lfs.attributes(path, 'modification')
        if not list[rel] or list[rel] ~= t then
            推送文件(rel)
            list[rel] = t
        end
    end
end
推送目录('./assets')
pcall(require, 'ggerun')
--写出已经上传的文件
do
    os.remove('./.ggelua/assetslist.lua')
    local f = io.open('./.ggelua/assetslist.lua', 'w')
    if f then
        f:write('return {', '\n')
        for k, v in pairs(list) do
            f:write(string.format('    ["%s"] = %s,\n', k, v))
        end
        f:write('}')
        f:close()
    end
end

--推送脚本
执行('adb push %s/.ggelua/ggelua /sdcard/GGELUA/ggelua', 项目目录)
执行('adb shell "run-as com.GGELUA.game cp -fv /sdcard/GGELUA/ggelua /data/data/com.GGELUA.game/files/ggelua"')
--运行APP
执行('adb shell am start com.GGELUA.game/.GGEActivity')
--打开日志
执行('adb logcat --clear')
执行('adb logcat -s SDL -s SDL/APP')
