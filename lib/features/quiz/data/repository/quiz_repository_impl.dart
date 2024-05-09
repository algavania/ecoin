import 'package:ecoin/data/models/quiz/quiz_item_model.dart';
import 'package:ecoin/database/db_helper.dart';
import 'package:ecoin/features/quiz/data/repository/quiz_repository.dart';

class QuizRepositoryImpl extends QuizRepository {
  final _db = DbHelper.db;

  @override
  Future<List<QuizItemModel>> getQuizItems({int? limit}) async {
    var list = <QuizItemModel>[];
    var query = _db.collection(DbHelper.quiz).orderBy('createdAt');
    final res = await query.get();
    for (final data in res.docs) {
      var model = QuizItemModel.fromJson(data.data());
      model = model.copyWith(id: data.id);
      list.add(model);
    }
    list.shuffle();
    if (limit != null && limit < list.length) {
      list = list.sublist(0, limit);
    }
    return list;
  }

}