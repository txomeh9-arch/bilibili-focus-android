import 'package:flutter_test/flutter_test.dart';
import 'package:PiliPlus/plugin/pl_player/models/play_repeat.dart';
import 'package:PiliPlus/utils/focus_policy.dart';

void main() {
  test(
    'follow feed excludes reposts, non-video cards and unfollowed creators',
    () {
      bool allowed({
        String? type = 'DYNAMIC_TYPE_AV',
        bool repost = false,
        bool archive = true,
        bool? following = true,
      }) => isFocusFeedPost(
        type: type,
        isRepost: repost,
        hasArchive: archive,
        following: following,
      );
      expect(allowed(), isTrue);
      expect(allowed(following: null), isFalse);
      expect(allowed(repost: true), isFalse);
      expect(allowed(type: 'DYNAMIC_TYPE_WORD'), isFalse);
      expect(allowed(archive: false), isFalse);
      expect(allowed(following: false), isFalse);
    },
  );

  test('only explicitly enabled sequential playback survives old settings', () {
    expect(focusPlayMode(PlayRepeat.listOrder), PlayRepeat.listOrder);
    for (final mode in [
      PlayRepeat.pause,
      PlayRepeat.singleCycle,
      PlayRepeat.listCycle,
      PlayRepeat.autoPlayRelated,
    ]) {
      expect(focusPlayMode(mode), PlayRepeat.pause);
    }
  });

  test('direct video links become search terms, other hosts do not', () {
    expect(
      focusVideoSearchTerm(
        Uri.parse('https://www.bilibili.com/video/BV1xx411c7mD?p=2'),
      ),
      'BV1xx411c7mD',
    );
    expect(
      focusVideoSearchTerm(Uri.parse('bilibili://video/12345')),
      'av12345',
    );
    expect(
      focusVideoSearchTerm(Uri.parse('https://m.bilibili.com/video/av12345')),
      'av12345',
    );
    expect(
      focusVideoSearchTerm(Uri.parse('https://example.com/video/BV1xx411c7mD')),
      isNull,
    );
    expect(
      focusVideoSearchTerm(Uri.parse('https://space.bilibili.com/123')),
      isNull,
    );
  });
}
