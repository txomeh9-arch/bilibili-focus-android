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

  test('discovery endpoints are blocked while search and playback remain', () {
    expect(isFocusBlockedPath('/x/web-interface/archive/related'), isTrue);
    expect(isFocusBlockedPath('/x/v2/search/trending/ranking'), isTrue);
    expect(isFocusBlockedPath('/x/v2/feed/index'), isTrue);
    expect(isFocusBlockedPath('/x/web-interface/wbi/search/type'), isFalse);
    expect(isFocusBlockedPath('/x/player/wbi/playurl'), isFalse);
  });

  test('subscription positions follow the order selected in the list', () {
    expect(
      focusSeasonPosition(
        itemIndex: 0,
        count: 35,
        pageSize: 20,
        descending: true,
      ),
      (page: 2, index: 0),
    );
    expect(
      focusSeasonPosition(
        itemIndex: 15,
        count: 35,
        pageSize: 20,
        descending: true,
      ),
      (page: 1, index: 0),
    );
    expect(
      focusSeasonPosition(
        itemIndex: 20,
        count: 35,
        pageSize: 20,
        descending: false,
      ),
      (page: 2, index: 0),
    );
    expect(
      focusSeasonPosition(
        itemIndex: 35,
        count: 35,
        pageSize: 20,
        descending: false,
      ),
      isNull,
    );
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
