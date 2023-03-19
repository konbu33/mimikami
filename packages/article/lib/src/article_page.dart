import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:receive_share/receive_share.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'article_list_widget.dart';
import 'article_state_list.dart';

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

        final articleStateList = ref.watch(articleStateListNotifierProvider);

        logger.d("articleDeleteMode: $articleDeleteMode");
        logger.d("articleStateListLength: ${articleStateList.value.length}");

        return GestureDetector(
          onTap: () {
            if (!articleDeleteMode) return;

            ref
                .read(ArticlePageState.articleDeleteModeProvider.notifier)
                .update(false);
          },
          onLongPress: () {
            if (articleStateList.value.isEmpty) return;
            if (articleDeleteMode) return;

            ref
                .read(ArticlePageState.articleDeleteModeProvider.notifier)
                .update(true);
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
