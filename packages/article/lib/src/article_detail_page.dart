import 'package:flutter/material.dart';
import 'package:text_to_speech/text_to_speech.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({
    super.key,
    required this.articleId,
  });

  final String articleId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ArticleDetailPageParts.title(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ArticleDetailPageParts.contents(articleId),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleDetailPageParts {
  static Widget title() {
    const widget = Text(ArticleDetailPageState.title);
    return widget;
  }

  static Widget contents(String articleId) {
    final widget = Column(
      children: [
        Text("ArticleDetailPageState.contents : $articleId"),
        const TextToSpeechWidget(),
      ],
    );

    return widget;
  }
}

class ArticleDetailPageState {
  static const title = "article detail page";
}
