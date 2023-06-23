import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:whisp_diary/domain/entry.dart';

class DiaryManager {
  DiaryManager(this.isar);

  final Isar isar;

  Future<void> addEntry({
    required String title,
    required String content,
    required DateTime created,
    required XFile? image,
  }) async {
    final newEntry = Entry()
      ..title = title
      ..content = content
      ..created = created;

    if (image != null) {
      final imageBytes = await image.readAsBytes();
      newEntry.picture = base64Encode(imageBytes);
    }

    await isar.writeTxn(() async {
      await isar.entrys.put(newEntry);
    });
  }

  Future<void> updateEntry(Entry entry) async {
    await isar.writeTxn(() async {
      await isar.entrys.put(entry);
    });
  }

  Future<void> deleteEntry(
    Id id,
  ) async {
    await isar.writeTxn(() async {
      await isar.entrys.delete(id);
    });
  }

  Future<List<Entry>> getEntries(int? limit) {
    return limit != null
        ? isar.entrys.where().sortByCreatedDesc().limit(limit).findAll()
        : isar.entrys.where().sortByCreatedDesc().findAll();
  }
}
