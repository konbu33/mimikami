import 'package:article/src/article_page.dart';
import 'package:article/src/article_repository.dart';
import 'package:article/src/get_all_article_usecase.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'article_state.dart';
import 'article_state_list.dart';

// --------------------------------------------------
//
// ArticleListWidget
//
// --------------------------------------------------
class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        //

        // trigger：他アプリからURLがShareされてきたら、local_dbへ永続化する。
        ref.watch(reflectAddArticleStateToLocalDbProvider);

        final articleStateListNotifier =
            ref.watch(articleStateListNotifierProvider);

        final articleDeleteMode =
            ref.watch(ArticlePageState.articleDeleteModeProvider);

        return ListView.builder(
          itemCount: articleStateListNotifier.value.length,
          itemBuilder: (context, index) {
            final articleState = articleStateListNotifier.value[index];
            return articleDeleteMode
                ? VibrationWidget(
                    child: ArticleWidget(articleState: articleState),
                  )
                : ArticleWidget(articleState: articleState);
          },
          padding: const EdgeInsets.all(10),
        );
      },
    );
  }
}

// --------------------------------------------------
//
// ArticleWidget
//
// --------------------------------------------------
class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.articleState});

  final ArticleState articleState;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final articleStateList = ref.watch(articleStateListNotifierProvider);

        final articleDeleteMode =
            ref.watch(ArticlePageState.articleDeleteModeProvider);

        return Stack(
          children: [
            // 記事
            Container(
              margin: const EdgeInsets.all(3),
              child: ListTile(
                title: Text(articleState.title),
                onTap: articleDeleteMode
                    ? null
                    : () {
                        context.go("/article/${articleState.id}");
                      },
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  side: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
            ),

            // 削除ボタン
            !articleDeleteMode
                ? const SizedBox.shrink()
                : Transform.translate(
                    offset: const Offset(-20, -20),
                    child: IconButton(
                      onPressed: () async {
                        final articleRepository =
                            ref.watch(articleRepositoryProvider);

                        // local_db上の記事削除
                        await articleRepository.deleteArticle(
                            articleState: articleState);

                        // 記事削除後、local_dbの記事一覧を取得する。
                        ref.invalidate(getAllArticleUsecaseProvider);

                        // 最後の1記事を削除する場合、削除モードを解除する。
                        logger.d(
                            "articleStateListLength: ${articleStateList.value.length}");

                        if (articleStateList.value.length <= 1) {
                          ref
                              .read(ArticlePageState
                                  .articleDeleteModeProvider.notifier)
                              .update(false);
                        }
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
