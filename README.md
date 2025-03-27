# 我的Jekyll博客

这是一个使用Jekyll构建的个人博客网站。

## 特性

- 响应式设计
- Markdown支持
- 简洁的布局
- 自定义样式

## 部署到GitHub Pages

此博客配置为在GitHub Pages上运行，无需本地环境。按照以下步骤部署：

1. 将此仓库fork或clone到您的GitHub账户
2. 修改`_config.yml`文件中的以下设置：
   - 将`url`更改为`https://你的用户名.github.io`
   - 将`baseurl`更改为仓库名称（如果直接用`用户名.github.io`作为仓库名则改为空字符串`""`）
   - 更改`github_username`为您的GitHub用户名
3. 进入仓库设置，找到"Pages"选项：
   - 将Source设置为`main`分支
   - 保存设置，等待几分钟，您的博客将在`https://你的用户名.github.io/仓库名`上线

## 添加新文章

在`_posts`目录中创建一个新的Markdown文件，文件名格式为`YYYY-MM-DD-title.md`。在文件开头添加以下YAML Front Matter：

```yaml
---
layout: post
title: "文章标题"
date: YYYY-MM-DD HH:MM:SS +0800
categories: 分类
---
```

然后，在Front Matter之后添加文章内容。

## 自定义您的博客

* 修改`_config.yml`更改博客标题、描述等信息
* 编辑`about.md`添加您的个人信息
* 在`_includes/head-custom.html`中自定义CSS样式
* 修改`_includes/navigation.html`添加更多导航链接 