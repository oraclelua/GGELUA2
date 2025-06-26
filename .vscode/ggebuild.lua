-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-11-15 02:47:57
-- @Last Modified time  : 2022-11-15 02:49:35

-- [./] 表示项目目录
local tt = os.clock()

print('编译文件')
编译目录('ggelua')
编译目录('./lua')
if arg[1] == 'windows' then
    print('复制文件')
    --复制文件('lib/gastar.dll', './build/lib/gastar.dll')
    --联接目录('./assets', './build/assets')
    写出EXE('./build/GGELUA.exe')
elseif arg[1] == 'android' then
    --由于assets不支持中文，资源名转换
    -- print('处理文件')
    -- for path,rel in 遍历目录('./data') do
    --     local hash = gge.hash(path:sub(#rel+6))
    --     print(string.format('assets/%08X', hash), path)
    --     复制文件(path, string.format('./assets/%08X', hash), false)
    -- end
    写出APK('mygame', '我的游戏', '.vscode/ico.png')
end
print('编译完成\n用时:' .. os.clock() - tt .. '秒')
