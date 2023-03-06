import '../../../shared/riverpod_and_hooks.dart';
import '../model/journal_model.dart';
import '../model/post_journal_model.dart';
import '../repository/journal_repository.dart';

final journalProvider = FutureProvider.autoDispose
    .family<List<JournalModel>, int>((ref, companyId) async {
  return await ref.watch(journalRepositoryProvider).getJournals(companyId);
});

final postJournalProvider =
    FutureProvider.autoDispose.family<void, PostJournal>((ref, data) async {
  return await ref.watch(journalRepositoryProvider).postJournal(data);
});
