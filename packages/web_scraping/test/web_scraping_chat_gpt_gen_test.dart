import 'package:flutter_test/flutter_test.dart';
import 'package:web_scraping/web_scraping.dart';

void main() {
  group('WebScraping', () {
    late WebScraping webScraping;

    setUp(() {
      webScraping = WebScraping();
    });

    test('createUri sets the uri property', () {
      const uriString = 'https://google.com';
      webScraping.createUri(uriString);
      expect(webScraping.uri.toString(), equals(uriString));
    });

    test('createUri does not set the uri property if uriString is empty', () {
      webScraping.createUri('');
      expect(webScraping.uri.toString(), equals(''));
    });

    test('getTitieText returns the title text of the webpage', () async {
      const uriString = 'https://google.com';
      webScraping.createUri(uriString);
      await webScraping.openHttp();
      final titleText = webScraping.getTitieText();
      expect(titleText, equals('Google'));
    });

    test('getBodyText returns the body text of the webpage', () async {
      const uriString = 'https://google.com';
      webScraping.createUri(uriString);
      await webScraping.openHttp();
      final bodyText = webScraping.getBodyText();
      expect(
          bodyText, contains('検索 画像 マップ Play YouTube ニュース Gmail ドライブ もっと見る'));
    });
  });
}
