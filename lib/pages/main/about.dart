// SPDX-License-Identifier: GPL-3.0-only
// Copyright (C) 2026 txomeh9-arch

import 'package:PiliPlus/build_config.dart';
import 'package:PiliPlus/utils/page_utils.dart';
import 'package:material_ui/material_ui.dart';

class FocusAboutPage extends StatelessWidget {
  const FocusAboutPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('关于与开源许可')),
    body: ListView(
      children: [
        const ListTile(
          title: Text('哔哩专注'),
          subtitle: Text(
            '基于 PiliPlus 2.2.0.2 的 Android 专注客户端。'
            '本项目由 txomeh9-arch 修改维护，与哔哩哔哩及上游项目无官方关联。'
            '原作者及贡献者的版权声明与开源许可予以保留。',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text('本项目源码'),
          subtitle: const Text('txomeh9-arch/bilibili-focus-android'),
          onTap: () => PageUtils.launchURL(
            'https://github.com/txomeh9-arch/bilibili-focus-android',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.source_outlined),
          title: const Text('直接上游：PiliPlus'),
          subtitle: const Text('bggRGjQaUbCoE/PiliPlus · 2.2.0.2'),
          onTap: () => PageUtils.launchURL(
            'https://github.com/bggRGjQaUbCoE/PiliPlus/tree/2.2.0.2',
          ),
        ),
        ListTile(
          title: const Text('早期上游：PiliPalaX'),
          subtitle: const Text('orz12/PiliPalaX'),
          onTap: () => PageUtils.launchURL(
            'https://github.com/orz12/PiliPalaX',
          ),
        ),
        ListTile(
          title: const Text('原始项目：PiliPala'),
          subtitle: const Text('guozhigq/pilipala'),
          onTap: () => PageUtils.launchURL(
            'https://github.com/guozhigq/pilipala',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined),
          title: const Text('GNU General Public License v3.0'),
          subtitle: const Text('查看本项目完整协议及第三方依赖许可'),
          onTap: () => showLicensePage(
            context: context,
            applicationName: '哔哩专注',
            applicationVersion: BuildConfig.versionName,
            applicationLegalese:
                '基于 PiliPlus，依 GNU GPL v3.0 分发。\n'
                '修改部分 Copyright (C) 2026 txomeh9-arch。',
          ),
        ),
      ],
    ),
  );
}
