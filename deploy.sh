#!/usr/bin/env bash
set -euo pipefail
# dimensional-drawing 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/enesozturk/dimensional-drawing#install
# 更新日期：2026-10-31
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v node >/dev/null 2>&1 || { echo "需要先安装 Node.js"; exit 1; }

mkdir -p .download
cd .download

git clone https://github.com/enesozturk/dimensional-drawing.git
mkdir -p ~/.claude/skills
cp -r dimensional-drawing/skills/* ~/.claude/skills/
echo "安装完成：新开一个会话，让它把某个组件画成尺寸图"

echo ""

echo "部署完成"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/enesozturk/dimensional-drawing#install"
