# dimensional-drawing 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/enesozturk/dimensional-drawing#install
# 更新日期：2026-10-31
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone https://github.com/enesozturk/dimensional-drawing.git
New-Item -ItemType Directory -Force "$env:USERPROFILE\.claude\skills" | Out-Null
Copy-Item -Recurse -Force .\dimensional-drawing\skills\* "$env:USERPROFILE\.claude\skills\
Write-Host "安装完成：新开一个会话，让它把某个组件画成尺寸图"

Write-Host ''

Write-Host '部署完成'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/enesozturk/dimensional-drawing#install'
