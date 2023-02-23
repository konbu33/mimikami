import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ArticleDetailPageParts.contents(articleId),
          ],
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
    final widget = Text("ArticleDetailPageState.contents : $articleId");
    return widget;
  }
}

class ArticleDetailPageState {
  static const title = "article detail page";
}
