import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static const stories = 'stories';
  static const endings = 'endings';
  static const scenarios = 'scenarios';
  static const creatures = 'creatures';
  static const quiz = 'quiz';

  static const negativeEnding = 'Ending Negatif';
  static const neutralEnding = 'Ending Netral';
  static const positiveEnding = 'Ending Positif';

  static const typeAnimal = 'Hewan';
  static const typePlant = 'Tumbuhan';

  static final db = FirebaseFirestore.instance;
}
