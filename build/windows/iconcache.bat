rem 关闭Windows外壳程序explorer
taskkill /f /im explorer.exe

rem 清理系统图标缓存数据库

attrib -h -s -r "%userprofile%\AppData\Local\IconCache.db"
del /f "%userprofile%\AppData\Local\IconCache.db"

attrib /s /d -h -s -r "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\iconcache_*.db"
del /f "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db"

rem 重启Windows外壳程序explorer
start explorer