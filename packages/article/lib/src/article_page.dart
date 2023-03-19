import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_share/receive_share.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'article_list_widget.dart';

part 'article_page.g.dart';

// --------------------------------------------------
//
// ArticlePageState
//
// --------------------------------------------------
class ArticlePageState {
  static const title = "article page";
  static final articleDeleteModeProvider = _articleDeleteModeProvider;
}

@riverpod
class _ArticleDeleteMode extends _$ArticleDeleteMode {
  @override
  bool build() {
    return false;
  }

  void update(bool newMode) {
    state = newMode;
  }
}

// --------------------------------------------------
//
// ArticlePage
//
// --------------------------------------------------
class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ArticlePageParts.title(),
      ),
      body: Consumer(builder: (context, ref, child) {
        final articleDeleteMode =
            ref.watch(ArticlePageState.articleDeleteModeProvider);

        logger.d("articleDeleteMode: $articleDeleteMode");

        return GestureDetector(
          onTap: () {
            if (articleDeleteMode) {
              ref
                  .read(ArticlePageState.articleDeleteModeProvider.notifier)
                  .update(false);
            }
          },
          onLongPress: () {
            if (!articleDeleteMode) {
              ref
                  .read(ArticlePageState.articleDeleteModeProvider.notifier)
                  .update(true);
            }
          },
          child: Column(
            children: [
              Expanded(child: ArticlePageParts.articleList()),

              // このWidgetで、他アプリからShareしてもらったURLを受け取る。
              ArticlePageParts.receiveShareWidget(),
            ],
          ),
        );
      }),
    );
  }
}

// --------------------------------------------------
//
// ArticlePageParts
//
// --------------------------------------------------
class ArticlePageParts {
  //

  // --------------------------------------------------
  // title
  // --------------------------------------------------
  static Widget title() {
    const widget = Text(ArticlePageState.title);
    return widget;
  }

  // --------------------------------------------------
  // articleList
  // --------------------------------------------------
  static Widget articleList() {
    const widget = ArticleListWidget();
    return widget;
  }

  // --------------------------------------------------
  // receiveShareWidget
  // --------------------------------------------------
  // このWidgetで、他アプリからShareしてもらったURLを受け取る。
  static Widget receiveShareWidget() {
    const widget = ReceiveShareWidget();
    return widget;
  }
}
