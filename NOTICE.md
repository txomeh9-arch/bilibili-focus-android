# 项目来源与修改声明

哔哩专注（Bilibili Focus Android）是 PiliPlus 的修改版本，由 txomeh9-arch 维护。

## 来源

- 直接上游：PiliPlus，https://github.com/bggRGjQaUbCoE/PiliPlus
- 基础版本：2.2.0.2
- 基础提交：d9e9626f1a3f89cd9ca85e18f61aaba02634e12a
- 早期上游：PiliPalaX，https://github.com/orz12/PiliPalaX
- 原始项目：PiliPala，https://github.com/guozhigq/pilipala

上游代码的版权属于原作者和贡献者，版权声明、Git 提交历史及依赖许可证予以保留。上游项目说明保存在 README.upstream.md。播放器、观看历史、收藏、搜索、评论等基础功能来源于上游，并非本项目从零实现。

## 本项目修改

本项目自上游基础提交开始修改，具体作者、日期和差异可通过 Git 历史查看。主要修改包括：

- 专注导航与登录入口，仅主动访问关注投稿、订阅、收藏、历史和搜索内容。
- 过滤关注流中的非视频及转发内容，关闭推荐、热搜、搜索建议和消息轮询。
- 播放结束默认暂停，可显式开启当前列表的顺序播放。
- 使用加密账号存储，关闭 Android 备份与内容通知权限，减少敏感日志。
- 提供观看历史入口，保留上游的历史搜索、续播和记录管理能力。
- 提供应用内来源及许可页面，打包完整 GPL v3.0 协议。
- 使用独立 Android 应用标识和固定发布签名，支持 GitHub Actions 构建和 APK 验证。

本项目新增及修改部分 Copyright (C) 2026 txomeh9-arch，按 GNU General Public License version 3 发布；完整条款见 LICENSE。原有代码继续保留其原始版权归属。第三方依赖与资源按各自许可证使用和分发，本声明不变更其许可。

本项目与哔哩哔哩及上述上游项目无官方关联。相关名称及商标归各自权利人所有。
