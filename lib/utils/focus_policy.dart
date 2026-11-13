import 'package:PiliPlus/plugin/pl_player/models/play_repeat.dart';

/// Only original video submissions belong in the followed-creators feed.
bool isFocusFeedPost({
  required String? type,
  required bool isRepost,
  required bool hasArchive,
  bool? following,
}) => type == 'DYNAMIC_TYPE_AV' && !isRepost && hasArchive && following == true;

/// Old settings must never re-enable loops or recommended videos.
PlayRepeat focusPlayMode(PlayRepeat mode) =>
    mode == PlayRepeat.listOrder ? PlayRepeat.listOrder : PlayRepeat.pause;

/// Disallow dedicated discovery endpoints, including after settings imports.
bool isFocusBlockedPath(String path) => const {
  '/x/v2/feed/index',
  '/x/web-interface/wbi/index/top/feed/rcmd',
  '/x/web-interface/archive/related',
  '/x/web-interface/popular',
  '/main/hotword',
  '/x/web-interface/wbi/search/default',
  '/x/web-interface/suggest',
  '/x/v2/search/trending/ranking',
  '/x/v2/search/recommend',
}.contains(path);

/// Translate an item in the displayed subscription order to its API page.
({int page, int index})? focusSeasonPosition({
  required int itemIndex,
  required int count,
  required int pageSize,
  required bool descending,
}) {
  if (itemIndex < 0 || itemIndex >= count || pageSize <= 0) return null;
  if (!descending) {
    return (page: itemIndex ~/ pageSize + 1, index: itemIndex % pageSize);
  }
  final pages = (count + pageSize - 1) ~/ pageSize;
  final firstPageLength = count - (pages - 1) * pageSize;
  if (itemIndex < firstPageLength) {
    return (page: pages, index: itemIndex);
  }
  final remaining = itemIndex - firstPageLength;
  return (page: pages - 1 - remaining ~/ pageSize, index: remaining % pageSize);
}

/// Return a search term for a direct Bilibili video link, if it is one.
String? focusVideoSearchTerm(Uri uri) {
  final host = uri.host.toLowerCase();
  final bool appLink = uri.scheme == 'bilibili' && host == 'video';
  final bool webLink =
      (uri.scheme == 'https' || uri.scheme == 'http') &&
      (host == 'bilibili.com' || host.endsWith('.bilibili.com')) &&
      uri.path.startsWith('/video/');
  if (!appLink && !webLink) return null;
  final path = uri.path;
  final bv = RegExp(
    r'bv1[0-9a-zA-Z]{9}',
    caseSensitive: false,
  ).firstMatch(path);
  if (bv != null) return bv.group(0);
  final av = RegExp(r'av(\d+)', caseSensitive: false).firstMatch(path);
  if (av != null) return 'av${av.group(1)}';
  if (appLink) {
    final id = RegExp(r'^/(\d+)(?:/|$)').firstMatch(path)?.group(1);
    if (id != null) return 'av$id';
  }
  return null;
}
