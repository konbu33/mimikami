import 'package:article/src/article_state_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'article_repository.dart';

part 'get_all_article_usecase.g.dart';

@riverpod
Future<ArticleStateList> getAllArticleUsecase(
    GetAllArticleUsecaseRef ref) async {
  final articleRepository = ref.watch(articleRepositoryProvider);
  final articleStateList = await articleRepository.getAllarticles();
  return ArticleStateList.create(value: articleStateList);
}
