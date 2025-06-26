-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-25 10:23:22

io.stdout:setvbuf('no', 0)
gge = package.loadlib('ggelua', 'luaopen_ggelua')()
local lfs = require('lfs')

引擎目录 = gge.getrunpath()
项目目录 = arg[2]
--gge.getcur1path()--项目目录

-- local function _处理路径(path) --处理sep和大小写
--     path = path:lower() --小写
--     path = path:gsub('\\', '/')
--     return path
-- end

引擎目录 = 引擎目录:gsub('\\', '/')
if 项目目录 then
    项目目录 = 项目目录:gsub('\\', '/')
end
print(引擎目录, 项目目录)

package.path = package.path .. ';.\\.vscode\\?.lua;.\\.ggelua\\?.lua'

--转换到绝对路径
local function 绝对路径(path, ...)
    assert(type(path) == 'string', '路径错误:' .. tostring(path))
    if select('#', ...) > 0 then
        path = path:format(...)
    end
    path = path:gsub('\\', '/')

    if path:sub(2, 2) == ':' then
        if 项目目录 and path:find(项目目录) then
            return path, 项目目录 .. '/'
        elseif path:find(引擎目录) then
            return path, 引擎目录 .. '/'
        end
        warn('未知路径->' .. path)
        return path, ''
    end

    if path:sub(1, 2) == './' then --项目目录
        path = path:gsub('.', 项目目录, 1) --%.
        return path, 项目目录 .. '/'
    else
        path = 引擎目录 .. '/' .. path
    end
    return path, 引擎目录 .. '/'
end

local function 分割文本(str, mark)
    if type(str) == 'string' then
        local r = {}
        if mark == '%' then
            mark = '([^' .. mark .. '%]+)'
        else
            mark = '([^' .. mark .. ']+)'
        end

        for match in tostring(str):gmatch(mark) do
            if match ~= '' then
                table.insert(r, match)
            end
        end
        return r
    end
    return {}
end

function 创建目录(path)
    if type(path) == 'string' then
        path = path:gsub('\\', '/'):match('(.+)/')
        path = 分割文本(path, '/')
        for i, v in ipairs(path) do
            lfs.mkdir(table.concat(path, '\\', 1, i))
        end
    end
end

function 删除目录(path, all)
    if type(path) == 'string' then
        path = 绝对路径(path):gsub('/', '\\')
        if all then
            os.execute('RMDIR /S /Q ' .. path)
        else
            os.execute('RMDIR /Q ' .. path)
        end
    end
end

function 判断文件(path)
    if type(path) == 'string' then
        local file = io.open(绝对路径(path), 'rb')
        if file then
            file:close()
            return true
        end
    end
    return false
end

function 删除文件名(file)
    file = file:gsub('\\', '/')
    return string.match(file, "(.+)/[^/]*%.%w+$")
end

function 删除扩展名(str)
    local idx = str:match('.+()%.%w+$')
    if (idx) then
        return str:sub(1, idx - 1)
    else
        return str
    end
end

function 取文件名(str, ex)
    str = str:gsub('\\', '/')

    if str:find('/') then
        str = str:match('.+/([^/]*%..+)$')
    end
    return ex and 删除扩展名(str) or str
end

function 判断目录(path)
    local lfs = require('lfs')
    return lfs.attributes(path, 'mode') == 'directory'
end

function 读取文件(path)
    if type(path) == 'string' then
        local file = io.open(绝对路径(path), 'rb')
        if file then
            local data = file:read('a')
            file:close()
            return data
        end
    end
end

function 写出文件(path, data)
    if type(path) == 'string' then
        local file = io.open(绝对路径(path), 'wb')
        if file then
            file:write(data)
            file:close()
            return true
        else
            print('写出失败', path)
        end
    end
    return false
end

function 复制文件(old, new, Y)
    if 判断文件(new) and Y == false then
        return
    end

    old, new = 绝对路径(old), 绝对路径(new)
    创建目录(new)

    local rf = io.open(old, 'rb')
    if rf then
        local wf = io.open(new, 'wb')
        if wf then
            wf:write(rf:read('a'))
            rf:close()
            wf:close()
            return true
        end
        rf:close()
    end
    return false
end

function 遍历目录(path)
    path = 绝对路径(path)
    local pn = #path + 2
    local sep = package.config:sub(1, 1)
    local lfs = require('lfs')
    local dir, u = lfs.dir(path)
    local pt = {}
    return function()
        repeat
            local file = dir(u)

            if file then
                local f = path .. '/' .. file
                local attr = lfs.attributes(f)

                if attr and attr.mode == 'directory' then
                    if file ~= '.' and file ~= '..' then
                        table.insert(pt, f)
                    end
                    file = '.'
                else
                    return f, f:sub(pn)
                end
            elseif pt[1] then
                path = table.remove(pt, 1)
                dir, u = lfs.dir(path)
                file = '.'
            end
        until file ~= '.'
    end
end

--lfs.link(a,b,true)需要管理权限
function 联接目录(src, dst)
    src, dst = 绝对路径(src), 绝对路径(dst)
    创建目录(dst:match('(.+)/'))
    src = src:gsub('/', '\\')
    dst = dst:gsub('/', '\\')
    os.execute(string.format('mklink /j "%s" "%s"', dst, src))
end

function 联接文件(src, dst)
    src = 绝对路径(src):gsub('/', '\\')
    dst = 绝对路径(dst):gsub('/', '\\')
    创建目录(dst)
    os.execute(string.format('mklink /h "%s" "%s"', dst, src))
end

--把资源打包到sqlite
-- function 打包目录(path, file, psd)
--     path, file = 绝对路径(path), 绝对路径(file)
--     local env = setmetatable({arg = {arg[1], path, file, psd}}, {__index = _G})

--     loadfile(引擎目录 .. '/tools/torespack.lua', 'bt', env)()
-- end

--启动脚本
local script, core = {}
do
    local r = assert(读取文件(引擎目录 .. '/ggelua.lua'), '读取失败:ggelua.lua')
    local fun = assert(load(r, 'ggelua.lua'))
    core = string.dump(fun)
end

function 编译重置()
    script, core = {}
end

function 编译目录(path, strip)
    for path, rel in 遍历目录(path) do
        if path:sub(-3) == 'lua' then
            local r = assert(读取文件(path), '读取失败:' .. path)
            rel = rel:lower() --删除绝对路径
            local fun = assert(load(r, rel))
            script[rel] = string.dump(fun, strip)
            print(string.format('dump -> %s (%s)', path, rel))
        end
    end
end

function 编译文件(path, strip)
    local path, rel = 绝对路径(path)
    if path:sub(-3) == 'lua' then
        local r = assert(读取文件(path), '读取失败:' .. path)
        rel = rel:lower() --删除绝对路径
        local fun = assert(load(r, rel))
        script[rel] = string.dump(fun, strip)
        print(string.format('dump -> %s (%s)', path, rel))
    end
end

local function getscript()
    local data, path = {}, {}
    for k, v in pairs(script) do
        table.insert(path, k)
        table.insert(data, v)
    end
    local head = 'GGEP' .. string.pack('<I4I4', #path, 0)
    local list, offset = {}, 12 + #path * string.packsize('<c256I4I4I4')
    for i, v in ipairs(path) do
        table.insert(list, string.pack('<c256I4I4I4', v, gge.hash(v), offset, #data[i]))
        offset = offset + #data[i]
    end
    data = head .. table.concat(list) .. table.concat(data)
    return data
end

function 写出脚本(path)
    创建目录(path)
    local file = path
    if type(path) == 'string' then
        file = io.open(绝对路径(path), 'wb')
    end
    if file then
        local data = getscript()
        file:write(core)
        file:write(data)
        file:write(string.pack('<I4I4I4', 0x20454747, #core, #data))
        file:close()
        return true
    end
end

function 写出Windows(file, ico, ver, ht)
    local out = require('Windows')(file, ht)
    if out then
        if ico then
            out:写图标(ico)
        end
        if ver then
            out:写版本(ver)
        else
            out:写版本('1.0')
        end
        out:写出()
    else
        error('写出失败', 2)
    end
end

写出EXE = 写出Windows

function 写出Console(file, ico, ver, ht)
    local out = require('Windows')(file, ht)
    if out then
        if ico then
            out:写图标(ico)
        end
        if ver then
            out:写版本(ver)
        else
            out:写版本('1.0')
        end
        out:写出()
    else
        error('写出失败', 2)
    end
end

写出EXEC = 写出Console


function 写出Android(pack, name, ico, key)
    local out = require('Android')(pack, name)
    if out then
        out:写资源('./assets')
        if ico then
            out:写图标(ico)
        end
        if key then
            out:签名(key)
        end
        out:写出()
    else
        error('写出失败', 2)
    end
end

写出APK = 写出Android

function 执行(file, ...)
    if select('#', ...) > 0 then
        file = file:format(...)
    end
    print(file)
    local p = io.popen(file, 'r')
    local ret = {}
    repeat
        local r = p:read('*l')
        if r then
            print(r)
            table.insert(ret, r)
        end
    until not r

    p:close()
    ret = table.concat(ret, '\n')
    return ret ~= '' and ret
end

do
    local class = require('GGE.class')

    do
        local base = 绝对路径('build/android')
        local java = base .. '/OpenJDK/bin/java.exe'
        local apktool = base .. '/apktool.jar'
        local align = base .. '/zipalign.exe'
        local apksigner = base .. '/apksigner.jar'

        local output = './.ggelua/android'
        local inapk = base .. '/GGELUA.apk'
        local Android = class('Android')

        function Android:初始化(packname, appname)
            self.packname = packname
            self.appname = appname
            self.outapp = appname .. '.apk'
            self.keystore = base .. '/debug.keystore'

            if packname:match('[a-zA-Z0-9]+') ~= packname then
                print('\x1b[31m包名必须是英文和数字\x1b[0m', packname)
                return false
            end
            删除目录('./.ggelua', true)
            print('开始解包', inapk)
            执行('%s -jar %s decode %s --force-all -output %s', java, apktool, inapk, output)
            删除目录(output .. '/assets/assets', true)

            print('写出脚本')
            写出脚本(output .. '/assets/ggelua')

            if packname and packname ~= 'game' then
                print('修改包名', packname)
                写出文件(output .. '/AndroidManifest.xml',
                读取文件(output .. '/AndroidManifest.xml'):gsub('com.GGELUA.game', 'com.GGELUA.' .. packname))

                创建目录(绝对路径('%s/smali/com/GGELUA/%s/', output, packname))
                for path in 遍历目录(output .. '/smali/com/GGELUA/game') do
                    local data = 读取文件(path)
                    data = data:gsub('com%.GGELUA%.game', 'com.GGELUA.' .. packname)
                    data = data:gsub('com/GGELUA/game', 'com/GGELUA/' .. packname)
                    path = path:gsub('com/GGELUA/game', 'com/GGELUA/' .. packname)
                    写出文件(path, data)
                    print(path)
                end

                删除目录(output .. '/smali/com/GGELUA/game', true)
            end

            if appname and appname ~= "GGELUA" then
                print('修改APP名称', appname)
                写出文件(output .. '/res/values/strings.xml',
                    读取文件(output .. '/res/values/strings.xml'):gsub('GGELUA', appname))
            end
        end

        function Android:不压缩(name)
            写出文件(output .. '/apktool.yml',
                读取文件(output .. '/apktool.yml'):gsub('doNotCompress:', 'doNotCompress:\n- ' .. name))
        end

        function Android:写资源(path)
            path = path:gsub('\\', '/')
            if 判断目录(path) then
                for path, rel in 遍历目录(path) do
                    if rel:find('[\xC2-\xFD][\x80-\xBF]') then
                        print(rel)
                        error('路径中包含了中文')
                    end
                end
                联接目录(path, output .. '/assets/' .. path:match('.+/(.+)'))
            end
        end

        function Android:写图标(file)
            file = 绝对路径(file)
            local SDL = require('gsdl2')
            local IMG = require('gsdl2.image')
            IMG.Init()
            print('修改APP图标', file)
            if 判断文件(file) then
                local src = IMG.LoadARGB8888(file)
                if src then
                    local name = {
                        --32 ldpi
                        [48] = 'mipmap-mdpi',
                        [72] = 'mipmap-hdpi',
                        [96] = 'mipmap-xhdpi',
                        [144] = 'mipmap-xxhdpi',
                        [192] = 'mipmap-xxxhdpi'
                    }
                    local function stretch(w, h)
                        local dst = SDL.CreateRGBSurfaceWithFormat(w, h)
                        src:SoftStretchLinear(nil, dst, nil)
                        dst:SavePNG(string.format('.ggelua/android/res/%s/ic_launcher.png', name[w]))
                        print(string.format('./.ggelua/android/res/%s/ic_launcher.png', name[w]))
                    end

                    stretch(192, 192)
                    stretch(144, 144)
                    stretch(96, 96)
                    stretch(72, 72)
                    stretch(48, 48)
                else
                    print('载入失败', file)
                end
            else
                print('文件不存在', file)
            end
        end

        function Android:删除SO(name, platform)
            print('删除SO')
            if platform then
                os.remove(string.format('./.ggelua/android/lib/%s/lib%s.so', platform, name))
            else
                for _, platform in ipairs { 'x86', 'x86_64', 'arm64-v8a', 'armeabi-v7a' } do
                    os.remove(string.format('./.ggelua/android/lib/%s/lib%s.so', platform, name))
                end
            end
        end

        function Android:复制SO(path)
            print('复制SO')
            for path, rel in 遍历目录(path) do
                print('./.ggelua/android/lib/' .. rel)
                复制文件(path, './.ggelua/android/lib/' .. rel)
            end
        end

        function Android:签名(keystore)
            self.keystore = keystore
        end

        function Android:写出(file)
            --打包
            print('开始打包')
            执行('%s -jar %s build %s --force-all -output %s', java, apktool, output, 'outapk')
            --对齐
            print('签名', self.keystore)
--             Usage: zipalign [-f] [-v] <align> infile.zip outfile.zip
--        zipalign -c [-v] <align> infile.zip

--   <align>: alignment in bytes, e.g. '4' provides 32-bit alignment
--   -c: check alignment only (does not modify file)
--   -f: overwrite existing outfile.zip
--   -v: verbose output

            执行('%s -f -v 4 %s %s', align, 'outapk', 'align')
            os.remove('outapk')
            --签名
            执行(
            '%s -jar %s sign -verbose --ks %s --ks-pass pass:android --ks-key-alias androiddebugkey --key-pass pass:android --out %s align'
            , java, apksigner, self.keystore, self.outapp)
            os.remove('align')
            --校验
            执行('%s -jar %s verify -verbose %s', java, apksigner, self.outapp)
        end
    end

    do
        local base = 绝对路径('build/windows')
        local rh = base .. '/resource_hacker/ResourceHacker.exe'
        local Windows = class('Windows')

        function Windows:初始化(file, c)
            self.文件 = 绝对路径(file)
            self.目录 = 删除文件名(self.文件)
            self.名称 = 取文件名(self.文件, true)
            local exe = c and 'GGELUAc.exe' or 'GGELUA.exe'
            复制文件(exe, file)
            复制文件('lua54.dll', self.目录 .. '/lua54.dll')
            复制文件('ggelua.dll', self.目录 .. '/ggelua.dll')
            复制文件('SDL2.dll', self.目录 .. '/SDL2.dll')
            if not c then
                复制文件('SDL_image.dll', self.目录 .. '/SDL_image.dll')
                复制文件('SDL_mixer.dll', self.目录 .. '/SDL_mixer.dll')
                复制文件('SDL_ttf.dll', self.目录 .. '/SDL_ttf.dll')
                复制文件('lib/gsdl2.dll', self.目录 .. '/lib/gsdl2.dll')
            end

            联接目录('./data', self.目录 .. '/data')
            print(self.名称, self.文件, self.目录)
            -- for i, v in ipairs {
            --     { '_openssl', '_openssl.dll' },
            --     { 'cjson', 'cjson.dll' },
            --     { 'gasktao', 'gasktao.dll' },
            --     { 'astar', 'gastar.dll' },
            --     { 'gaty', 'gaty.dll' },
            --     { 'hpsocket', 'ghpsocket.dll' },
            --     { 'RPCAgent', 'ghpsocket.dll' },
            --     { 'RPCClient', 'ghpsocket.dll' },
            --     { 'RPCServer', 'ghpsocket.dll' },
            --     { 'HPSocket', 'ghpsocket.dll' },
            --     { 'IMGUI', 'gimgui.dll' },
            --     { 'gimgui', 'gimgui.dll' },
            --     { 'gip', 'gip.dll' },
            --     { 'gmir2', 'gmir2.dll' },
            --     { 'gmx', 'gmx.dll' },
            --     { 'gwoool', 'gwoool.dll' },
            --     { 'gxy2', 'gxy2.dll' },
            --     { 'gxy3', 'gxy3.dll' },
            --     { 'gxyq', 'gxyq.dll' },
            --     { 'hiredis', 'hiredis.dll' },
            --     { 'LIB.SQLITE3', 'lsqlite3.dll' },
            --     { 'lsqlite3', 'lsqlite3.dll' },
            --     { 'luasql', 'luasql.dll' },
            --     { 'lxp', 'lxp.dll' },
            --     { 'lzmq', 'lzmq.dll' },
            --     { 'mongo', 'mongo.dll' },
            --     { 'LIB.MongoDB', 'mongo.dll' },
            --     { 'socket.core', 'socket.dll' },
            -- } do
            --     print(i, v)
            -- end
        end

        function Windows:写图标(file)
            file = 绝对路径(file)
            print('修改APP图标', file)
            if 判断文件(file) then
                执行(rh ..
                    ' -open "%s" -save "%s" -log CON -action addoverwrite -resource "%s" -mask ICONGROUP,MAINICON,2052',
                    self.文件, self.文件, file)
            else
                print('文件不存在', file)
            end
        end

        function Windows:写版本(ver)
            print('修改APP版本', ver)
            self.版本 = ver
        end

        function Windows:写出()
            local rcp = self.目录 .. '/version.rc'
            执行(rh .. " -open %s -save %s -log CON -action extract -mask VERSIONINFO,,", self.文件, rcp)
            local rc = 读取文件(rcp)
            if rc then
                rc = gge.utf16letoutf8(rc)
                if self.版本 then
                    rc = rc:gsub('2%.0%.0%.0', self.版本)
                end
                rc = rc:gsub('好游戏引擎', self.名称)
                写出文件(rcp, rc)
                执行(rh .. " -open %s -save %s -action compile", rcp, self.目录 .. '/version.res')
                执行(rh .. ' -open %s -save %s -log CON -action addoverwrite -resource %s -mask VERSIONINFO,1,2052',
                    self.文件, self.文件, self.目录 .. '/version.res')
                执行(rh .. " -open %s -save %s -log CON -action changelanguage(2052)", self.文件, self.文件)
                os.remove(rcp)
                os.remove(self.目录 .. '/version.res')
            end

            print(self.文件)
            local file = io.open(self.文件, 'r+b')

            if file then
                if file:seek('end', -12) then
                    local glue = file:read(12)
                    if glue and #glue == 12 then
                        local sig, s1, s2 = string.unpack('<I4I4I4', glue)
                        if sig == 0x20454747 then
                            file:seek('end', -(12 + s1 + s2))
                        end
                        file:seek('cur') --没有这句，会有奇怪的数据
                        写出脚本(file)
                        os.execute('start ' .. self.目录) --打开目录
                        return true
                    end
                end
            else
                error('写出失败', 2)
            end
        end

        function Windows:写出控制台(...)
            -- body
        end
    end
end
