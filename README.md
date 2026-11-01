# dimensional-drawing 一键安装指南

> 第三方部署指南 · 非 dimensional-drawing 官方仓库。官方项目：[enesozturk/dimensional-drawing](https://github.com/enesozturk/dimensional-drawing)
> 内容来自官方文档（2026-10-31）。项目迭代快，请以[官方文档](https://github.com/enesozturk/dimensional-drawing#install)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 只画架构不画文案：内边距、间距、圆角与层级被量成数字，换掉文字后这张图依然成立。

⚠️ 需要支持技能（Skills）的客户端，比如 Claude Code、Codex、Cursor、Gemini CLI。它本身不是独立程序，装的是技能文件；只想在 claude.ai 里用，可以把 zip 上传到设置的 Skills 里。动画部分另有依赖：用 Playwright 加 ffmpeg 的无头模式时不依赖 Claude。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/dimensional-drawing-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会克隆仓库，把 skills 目录复制到当前客户端的技能目录，再让你指定一个组件试画一张，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## dimensional-drawing 是什么？

dimensional-drawing 是开源的给 Agent 一个组件，它还你一张苹果式尺寸图：内边距、间距、圆角、层级与视口位置全标出来（协议：MIT，<img src="https://img.shields.io/github/stars/enesozturk/dimensional-drawing?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

教 Agent 按苹果尺寸图规范画界面组件的技术图：单页多视图、细部放大圈、尺寸标注，只描述布局架构不写文案，另有配套技能把尺寸图变成约十秒的动效短片。

- 两种产出：静态尺寸图与十秒动效片
- 规范统一：单色、线宽与剖面线区分层级
- 只画架构：文案变了图也不用重画
- 可交付：单文件 HTML，直接发给别人
- 多客户端：Claude Code、Codex、Cursor 都能装
- MIT 协议，可自行改造

（来源：[官方仓库](https://github.com/enesozturk/dimensional-drawing)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 1.6k stars 10 月新项目 | 名称搜索仅 11 条结果 |
| 产出是单文件 HTML | 交付方便 |
| 规范贴近苹果尺寸图 | 可当评审材料 |
| 只画架构 | 文案改动不影响图 |
| 多客户端可装 | Claude Code 最省事 |
| MIT 协议 | 可自改 |

| 需要注意 | 说明 |
|---|---|
| 依赖支持 Skills 的客户端 | — |
| 不是独立软件 | 无法双击运行 |
| 只表达布局 | 不表达视觉风格 |
| 动效模式需额外装工具链 | — |
| 复杂组件需要人工挑选要保留的细节 | — |

> 以上基于官方文档与社区反馈整理（2026-10-31），以官方最新文档为准。

## 快速部署（官方方式）

```bash
git clone https://github.com/enesozturk/dimensional-drawing.git
mkdir -p ~/.claude/skills
cp -r dimensional-drawing/skills/* ~/.claude/skills/
echo "安装完成：新开一个会话，让它把某个组件画成尺寸图"
```

部署步骤来源：[https://github.com/enesozturk/dimensional-drawing#install](https://github.com/enesozturk/dimensional-drawing#install)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认两种技能、三种安装方式与依赖 | 已核对 2026-10-31 |
| README 确认动效模式需 Playwright 与 ffmpeg | 已核对 2026-10-31 |
| 未实测安装与出图 | 说明 2026-10-31 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-31 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-31 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装步骤、目录约定与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-31）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\dimensional-drawing-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 仓库里有两个技能

| 技能 | 作用 |
|---|---|
| `dimensional-drawing` | 把组件画成一张标注尺寸的技术图 |
| `dimensional-drawing-motion` | 把这张图变成约十秒的动效短片 |

## 三种安装方式

**Claude Code**：

```bash
git clone https://github.com/enesozturk/dimensional-drawing
cp -r dimensional-drawing/skills/* ~/.claude/skills/
```

**claude.ai / Claude 桌面端**：把 `skills/dimensional-drawing` 压成 zip，在 设置 → 能力 → 技能 里上传。

**其它客户端**（Codex、Cursor、Gemini CLI 等）：

```bash
npx skills add enesozturk/dimensional-drawing
```

也可以直接把 `SKILL.md` 指给你的 Agent 读。

## 怎么用

新开会话，说明要给哪个组件画图，并给出源码位置、Storybook 页面、URL 或截图，然后说「画成尺寸图」。产出是一张单文件 HTML。

## 动效片

- 在 Claude 里用 Motion 产物最省事
- 不在 Claude 里时，用仓库自带的 headless 适配器，需要 Playwright 与 ffmpeg

## 注意

- 它不是独立应用，装的是技能文件，必须由支持 Skills 的客户端加载
- 只描述布局与尺寸，不还原文案与配色细节
- 组件特别复杂时会拆成多张图或省略次要细节
- 动效模式要额外装 Playwright 与 ffmpeg

## 常见坑

- 装了没反应：确认客户端支持 Skills，且文件在正确的技能目录
- Claude Code 找不到：路径是 ~/.claude/skills，不是项目目录
- Windows 复制失败：用 PowerShell 的 Copy-Item，注意目标目录要存在
- 画出来缺尺寸：给更明确的源码位置，或让它先读组件文件
- 动效渲染失败：确认 Playwright 与 ffmpeg 已装好
- 产出太长：指定只画关键视图，或分两张图

## 免责声明

本仓库为第三方指南，与 dimensional-drawing 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-31），项目迭代快，请以[官方文档](https://github.com/enesozturk/dimensional-drawing#install)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
