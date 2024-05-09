import 'package:ecoin/features/story/data/repository/story_repository.dart';
import 'package:ecoin/features/story/data/repository/story_repository_impl.dart';
import 'package:ecoin/injector/injector.dart';

class RepositoryModule {
  RepositoryModule._();

  static void init() {
    Injector.instance
      .registerFactory<StoryRepository>(
        StoryRepositoryImpl.new,
      );
  }
}
