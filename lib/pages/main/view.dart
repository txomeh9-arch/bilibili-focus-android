import 'package:PiliPlus/models/common/dynamic/dynamics_type.dart';
import 'package:PiliPlus/pages/dynamics_tab/view.dart';
import 'package:PiliPlus/pages/fav/view.dart';
import 'package:PiliPlus/pages/main/controller.dart';
import 'package:PiliPlus/pages/search/view.dart';
import 'package:PiliPlus/pages/subscription/view.dart';
import 'package:PiliPlus/plugin/pl_player/models/play_repeat.dart';
import 'package:PiliPlus/services/account_service.dart';
import 'package:PiliPlus/utils/accounts.dart';
import 'package:PiliPlus/utils/app_scheme.dart';
import 'package:PiliPlus/utils/login_utils.dart';
import 'package:PiliPlus/utils/storage.dart';
import 'package:PiliPlus/utils/storage_key.dart';
import 'package:PiliPlus/utils/storage_pref.dart';
import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';

/// The root only exposes content the user has chosen or explicitly searched.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final accountService = Get.find<AccountService>();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.put(MainController());
    PiliScheme.init();
  }

  @override
  void dispose() {
    PiliScheme.listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Obx(() {
    if (!accountService.isLogin.value) {
      return Scaffold(
        appBar: AppBar(title: const Text('哔哩专注')),
        body: Center(
          child: FilledButton.icon(
            onPressed: () => Get.toNamed('/loginPage'),
            icon: const Icon(Icons.login),
            label: const Text('登录哔哩哔哩'),
          ),
        ),
      );
    }

    final Widget page = switch (selectedIndex) {
      1 => const SubPage(),
      2 => const FavPage(),
      3 => const SearchPage(),
      _ => Scaffold(
        appBar: AppBar(
          title: const Text('关注'),
          actions: [
            IconButton(
              tooltip: '设置',
              onPressed: () => Get.to(() => const FocusSettingsPage()),
              icon: const Icon(Icons.settings_outlined),
            ),
          ],
        ),
        body: const DynamicsTabPage(dynamicsType: DynamicsTabType.video),
      ),
    };

    return Scaffold(
      body: page,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.people_outline), label: '关注'),
          NavigationDestination(
            icon: Icon(Icons.video_library_outlined),
            label: '订阅',
          ),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: '收藏'),
          NavigationDestination(icon: Icon(Icons.search), label: '搜索'),
        ],
      ),
    );
  });
}

class FocusSettingsPage extends StatefulWidget {
  const FocusSettingsPage({super.key});

  @override
  State<FocusSettingsPage> createState() => _FocusSettingsPageState();
}

class _FocusSettingsPageState extends State<FocusSettingsPage> {
  late bool continuous = Pref.playRepeat == PlayRepeat.listOrder;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('设置')),
    body: ListView(
      children: [
        SwitchListTile(
          title: const Text('连续播放'),
          subtitle: const Text('仅播放当前分 P、合集或收藏夹中的下一条'),
          value: continuous,
          onChanged: (value) {
            setState(() => continuous = value);
            GStorage.video.put(
              VideoBoxKey.playRepeat,
              (value ? PlayRepeat.listOrder : PlayRepeat.pause).index,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('退出登录'),
          onTap: () async {
            await Accounts.clear();
            await LoginUtils.onLogoutMain();
            Get.back();
          },
        ),
      ],
    ),
  );
}
