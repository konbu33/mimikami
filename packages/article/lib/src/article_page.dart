import 'package:flutter/material.dart';

import 'article_list_widget.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ArticlePageParts.title(),
      ),
      body: ArticlePageParts.articleList(),
    );
  }
}

class ArticlePageParts {
  static Widget title() {
    const widget = Text(ArticlePageState.title);
    return widget;
  }

  static Widget articleList() {
    const widget = ArticleListWidget();
    return widget;
  }
}

class ArticlePageState {
  static const title = "article page";
}
