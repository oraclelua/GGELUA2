-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-15 02:49:45


print('ggerun',arg[1])
if arg[1]=='android' then
    编译目录('ggelua')
    编译目录('./lua')
    -- for path,rel in 遍历目录('./data') do
    --     local hash = gge.hash(path:sub(#rel+6))
    --     if 复制文件(path, string.format('./assets/%08X', hash), false) then
    --         print(string.format('assets/%08X', hash), path)
    --     end
    -- end
    写出脚本('./assets/ggelua')
else

end