import 'package:ecoin/features/creature/data/repository/creature_repository.dart';
import 'package:ecoin/features/creature/data/repository/creature_repository_impl.dart';
import 'package:ecoin/features/quiz/data/repository/quiz_repository.dart';
import 'package:ecoin/features/quiz/data/repository/quiz_repository_impl.dart';
import 'package:ecoin/features/story/data/repository/story_repository.dart';
import 'package:ecoin/features/story/data/repository/story_repository_impl.dart';
import 'package:ecoin/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    Injector.instance
      ..registerFactory<StoryRepository>(
        StoryRepositoryImpl.new,
      )
      ..registerFactory<CreatureRepository>(
        CreatureRepositoryImpl.new,
      )
      ..registerFactory<QuizRepository>(
        QuizRepositoryImpl.new,
      );
  }
}
