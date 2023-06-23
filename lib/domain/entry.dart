import 'package:isar/isar.dart';

part 'entry.g.dart';

@collection
class Entry {
  late String content;
  late DateTime created;
  Id id = Isar.autoIncrement;
  String? picture;
  late String title;
}
