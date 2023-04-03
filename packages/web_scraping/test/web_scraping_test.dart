import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web_scraping/web_scraping.dart';

void main() {
  late WebScraping webScraping;

  setUp(() {
    changeLoggerLevel("info");
    webScraping = WebScraping();
  });

  group('createUri', () {
    test('uriStringがisEmptyの場合、uriがisEmptyであること', () {
      // given
      expect(webScraping.uri.toString(), isEmpty);

      // when
      const uriString = "";
      webScraping.createUri(uriString);

      // then
      expect(webScraping.uri.toString(), isEmpty);
    });

    test('uriStringがisNtoEmptyの場合、uriにuriStringが設定されること', () {
      // given
      expect(webScraping.uri.toString(), isEmpty);

      // when
      const uriString = "https://www.google.com";
      webScraping.createUri(uriString);

      // then
      expect(webScraping.uri.toString(), uriString);
    });
  });

  group('openHttp', () {
    test('uriがisEmptyの場合、エラー発生しないこと', () {
      // when
      webScraping.openHttp();
    });

    test('uriがisNotEmptyの場合、エラー発生しないこと', () {
      // given
      const uriString = "https://www.google.com";
      webScraping.createUri(uriString);

      // when
      webScraping.openHttp();
    });
  });

  group('getTitleText', () {
    test('html内にtitleタグが無い場合、titleの文字列が無い旨のメッセージが返ること', () async {
      // given
      const uriString = "";
      webScraping.createUri(uriString);
      await webScraping.openHttp();

      // when
      final titleText = webScraping.getTitieText();
      expect(titleText, "No title text");
    });

    test('html内にtitleタグがある場合、titleタグ内の文字列が取得できること', () async {
      // given
      const uriString = "https://www.google.com";
      webScraping.createUri(uriString);
      await webScraping.openHttp();

      // when
      final titleText = webScraping.getTitieText();
      expect(titleText, "Google");
    });
  });

  group('getBodyText', () {
    test('innerHtmlの文字列が取得できること', () async {
      // given
      const uriString = "https://www.google.com";
      webScraping.createUri(uriString);
      await webScraping.openHttp();

      // when
      final bodyText = webScraping.getBodyText();
      // print("bodyText: ${bodyText.substring(0, 100)}");
      expect(bodyText, isNotEmpty);
    });
  });
}
