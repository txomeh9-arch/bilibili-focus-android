# 哔哩专注

个人自用的 Android 专注客户端，基于 [PiliPlus](https://github.com/bggRGjQaUbCoE/PiliPlus) 2.2.0.2。

登录后可查看关注 UP 主投稿、已订阅合集和收藏夹，主动搜索或浏览 UP 主主页。播放页保留弹幕、评论、点赞、投币和收藏；默认播完暂停，可在设置中开启当前列表连续播放。

应用不展示推荐视频、热搜或消息红点。订阅内容通过进入页面或手动刷新获取。播放控制所需的系统媒体控件不属于内容推送。

## Android 构建

在私有仓库的 Actions 中运行 **Build Android**，下载名为 `bilibili-focus-android-<运行号>` 的产物。一般 Android 手机使用 `arm64-v8a` APK，安装前可核对产物中的 SHA256SUMS。

构建使用固定签名，Actions 需要以下仓库 Secrets：`SIGN_KEYSTORE_BASE64`、`KEYSTORE_PASSWORD`、`KEY_ALIAS`、`KEY_PASSWORD` 和 `SIGNING_CERT_SHA256`。缺少签名配置时 release 构建会失败。请安全备份签名密钥；更换密钥后，Android 无法直接覆盖安装旧版。

原项目及其许可见 [README.upstream.md](README.upstream.md) 和 [LICENSE](LICENSE)。第三方接口可能变化，画质及内容权限由哔哩哔哩账号与平台规则决定。
