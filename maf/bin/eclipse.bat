@echo off
echo.
echo [信息] 生成Eclipse工程文件。
echo.
pause
echo.

cd %~dp0
cd..

call mvn -Declipse.workspace=%cd% eclipse:clean eclipse:eclipse

cd bin
pause