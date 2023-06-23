import 'package:isar/isar.dart';
import 'package:local_auth/local_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whisp_diary/domain/entry.dart';
import 'package:whisp_diary/infurastructure/diary_repository.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isarInstance(IsarInstanceRef ref) async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [EntrySchema],
    directory: dir.path,
  );
  return isar;
}

@riverpod
Future<DiaryManager> diaryManager(DiaryManagerRef ref) async {
  final isar = await ref.watch(isarInstanceProvider.future);
  return DiaryManager(isar);
}

@riverpod
Future<List<Entry>> entries(EntriesRef ref, {int? limit}) async {
  final diaryManager = await ref.read(diaryManagerProvider.future);
  return diaryManager.getEntries(limit);
}

@riverpod
Future<bool> isAuth(IsAuthRef ref) async {
  final auth = LocalAuthentication();
  final didAuthenticate = await auth.authenticate(
    localizedReason: 'Please authenticate to access your diary.',
  );
  return didAuthenticate;
}
