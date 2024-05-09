import 'package:ecoin/data/models/quiz/quiz_item_model.dart';

abstract class QuizRepository {
  Future<List<QuizItemModel>> getQuizItems({int? limit});
}