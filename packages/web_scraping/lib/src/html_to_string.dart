import 'package:common/common.dart';
import 'package:html/parser.dart';
import 'package:universal_html/controller.dart';

// --------------------------------------------------
//
// WebScraping
//
// --------------------------------------------------
class WebScraping {
  WebScraping();

  final controller = WindowController();
  // late final Uri uri;
  Uri uri = Uri.parse("");

  // --------------------------------------------------
  // createUri
  // --------------------------------------------------
  void createUri(String uriString) {
    if (uriString.isEmpty) {
      const message = "uri is empty";
      logger.d(message);

      // const uriStringMock =
      //     "https://zenn.dev/maguroburger/articles/flutter_scraping";

      // uri = Uri.parse(uriStringMock);
      return;
    }

    uri = Uri.parse(uriString);
  }

  // --------------------------------------------------
  // openHttp
  // --------------------------------------------------
  Future<void> openHttp() async {
    if (uri.toString().isEmpty) {
      const message = "uri is empty";
      logger.d(message);
      return;
    }

    await controller.openHttp(uri: uri);
  }

  // --------------------------------------------------
  // getTitieText
  // --------------------------------------------------
  String getTitieText() {
    const titileSelector = "title";

    final titleHtmlText =
        controller.window!.document.querySelector(titileSelector)?.innerHtml;

    logger.d("titleHtmlText: $titleHtmlText");

    return titleHtmlText ?? "No title text";
  }

  // --------------------------------------------------
  // getBodyText
  // --------------------------------------------------
  String getBodyText() {
    const innerHtmlSelector = "html";

    final innerHtml =
        controller.window!.document.querySelector(innerHtmlSelector)!.innerHtml;

    logger.d("innerHtml: $innerHtml");

    final document = parse(innerHtml);

    final String bodyHtmlText =
        parse(document.body!.text).documentElement!.text;

    logger.d("bodyHtmlText: $bodyHtmlText");

    return bodyHtmlText;
  }
}
