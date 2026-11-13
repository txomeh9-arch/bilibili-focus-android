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
