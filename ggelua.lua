-- @Author              : GGELUA
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified by    : baidwwy
-- @Last Modified time  : 2023-01-19 11:55:24

require('ggelua') --preload dll
io.stdout:setvbuf('no', 0)
gge.version = '23.01.20'
local entry, isth = ...
local lpath, cpath
do
    local function split(path)
        local list, n = {}, 1
        for match in path:gmatch('([^;]+)') do
            list[n] = match
            n = n + 1
        end
        return list
    end

    package.path = nil
    package.cpath = nil
    setmetatable(
        package,
        {
            __newindex = function(t, k, v)
                if v and k == 'path' then
                    lpath = split(v:lower():gsub('\\', '/'))
                elseif k == 'cpath' then
                    cpath = v
                else
                    rawset(t, k, v)
                end
            end,
            __index = function(t, k)
                if k == 'path' then
                    return table.concat(lpath, ';')
                elseif k == 'cpath' then
                    return cpath
                end
            end
        }
    )
end

if gge.platform == 'Windows' then
    local path = '?.lua;?/?.lua;lua/?.lua;lua/?/?.lua'
    if gge.isdebug then --引擎目录
        path = path .. (';!/ggelua/?.lua;!/ggelua/?/?.lua'):gsub('!', gge.getrunpath())
    end
    package.path = path

    local cpath = ('!/?.dll;!/lib/?.dll'):gsub('!', gge.getcurpath()) --项目目录

    cpath = cpath .. (';!/?.dll;!/lib/?.dll'):gsub('!', gge.getrunpath()) --运行目录

    package.cpath = cpath
elseif gge.platform == 'Android' then
    package.path = '?.lua;?/?.lua;lua/?.lua;lua/?/?.lua'
    package.cpath = gge.arg[1] .. '/lib?.so'
end

-- if gge.platform=='Android' then
--     error("找不到脚本")
--     return
-- end

local function 处理路径(path)
    --相对路径
    -- local t = {}
    -- for match in path:gmatch("([^/]+)") do
    --     if match=='..' then
    --         table.remove(t)
    --     elseif match~='.' then
    --         table.insert(t, match)
    --     end
    -- end
    -- path = table.concat(t, "/")

    path = path:lower()
    path = path:gsub('%.', '/')
    path = path:gsub('\\', '/')
    return path
end

local 读取文件, 是否存在
if gge.isdebug then
    function 是否存在(path)
        local file = io.open(path, 'rb')
        if file then
            file:close()
            return true
        end
    end

    function 读取文件(path)
        local file = io.open(path, 'rb')
        if file then
            local data = file:read('a')
            file:close()
            return data
        end
    end

    function gge.dirscript(path, ...)
        if select('#', ...) > 0 then
            path = path:format(...)
        end
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
                        return f
                    end
                elseif pt[1] then
                    path = table.remove(pt, 1)
                    dir, u = lfs.dir(path)
                    file = '.'
                end
            until file ~= '.'
        end
    end
else
    local script = gge.script
    gge.script = nil
    local list = {}
    for _, v in ipairs(script.getlist()) do
        list[v] = true
    end
    function 是否存在(file)
        return list[file]
    end

    function 读取文件(file)
        return script.getdata(file)
    end

    function gge.dirscript(path, ...)
        if select('#', ...) > 0 then
            path = path:format(...)
        end
        local k
        return function()
            repeat
                k = next(list, k)
                if k and k:find(path) then
                    return k
                end
            until not k
        end
    end
end

local function 搜索路径(path)
    for _, v in ipairs(lpath) do
        local file = v:gsub('?', path)
        if 是否存在(file) then
            return file
        end
    end
end

do
    local loaded = package.loaded
    table.insert(
        package.searchers,
        2, --1是preload
        function(path)
            local npath = 处理路径(path)
            if loaded[npath] ~= nil then
                return function()
                    return loaded[npath]
                end
            end
            local fpath = 搜索路径(npath)
            if fpath then
                return function()
                    local data = 读取文件(fpath)
                    local r, err = load(data, fpath)
                    if err then
                        return error(err, 2)
                    end
                    local r = r()
                    loaded[npath] = r == nil and true or r
                    return loaded[npath]
                end
            end
        end
    )

    package.loaded =
    setmetatable(
        {},
        {
            __index = function(t, k)
                if loaded[k] then
                    return loaded[k]
                end
                k = 处理路径(k)
                return loaded[k]
            end,
            __newindex = function(t, k, v)
                loaded[k] = v
                k = 处理路径(k)
                loaded[k] = v
            end,
            __pairs = function()
                return next, loaded
            end
        }
    )
end

function gge.require(path, env, ...)
    path = 处理路径(path)
    path = 搜索路径(path)

    if type(path) == 'string' then
        local data = 读取文件(path)
        if data then
            return assert(load(data, path, 'bt', env or _G))(...)
        end
    end
end

if not gge.isdebug then
    local olf = loadfile
    function loadfile(file, mode, env)
        local r = olf(file, mode, env)
        if r then
            return r
        end
        return gge.loadfile(file, env)
    end

    local odf = dofile
    function dofile(file)
        local r = odf(file)
        if r then
            return r
        end
        return gge.dofile(file)
    end
end

function gge.loadfile(file, env)
    if type(file) == 'string' then
        local data = 读取文件(file:lower():gsub('\\', '/'))
        if data then
            return assert(load(data, file, 'bt', env or _G))
        end
    end
end

function gge.dofile(file, env, ...)
    if type(file) == 'string' then
        return gge.loadfile(file, env or _G)(...)
    end
end

require('GGE')
if isth then --线程
    local reg = debug.getregistry()
    reg.serialize = require('serialize').pack2
    reg.deserialize = require('serialize').deserialize
end
gge.xpcall(require, entry)
