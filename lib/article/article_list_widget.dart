import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mimikami/article/article_state.dart';

final articleList =
    List.generate(10, (index) => ArticleState.create(id: "${index + 1}"));

final articleStateList = ArticleStateList.create(value: articleList);

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articleList.length,
      itemBuilder: (context, index) {
        return ArticleWidget(index: index);
      },
      padding: const EdgeInsets.all(10),
    );
  }
}

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      child: ListTile(
        title: Text(articleStateList.value[index].title),
        onTap: () {
          context.go("/article/${articleStateList.value[index].id}");
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
    );
  }
}
