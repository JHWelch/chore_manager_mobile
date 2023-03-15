import 'package:chore_manager_mobile/data/auth/auth_service.dart';
import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_adapter.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:get/get.dart';

class ChoresController extends GetxController {
  final AuthService auth = Get.find();
  final RxList<Chore> chores = RxList<Chore>();
  final RxList<Chore> homePageChores = RxList<Chore>();
  final RxBool isLoading = false.obs;
  final ChoresAdapter adapter = ChoresAdapter();

  @override
  Future<void> onInit() async {
    super.onInit();

    await refreshChores();
  }

  Chore chore(int id) => chores().firstWhere((chore) => chore.id == id);

  List<Chore> withDueDate() =>
      chores().where((chore) => chore.nextDueDate != null).toList();

  Future<void> completeChore(int choreId) async {
    final int index = chores.indexWhere((chore) => chore.id == choreId);
    final Chore chore = chores[index];

    await adapter.complete(chore);

    chores.removeAt(index);
    _setFilterViews();

    return refreshChores();
  }

  Future<void> refreshChores() async {
    isLoading(true);

    final List<Chore> newChores = await adapter.index();
    newChores.sort(_choresByDueDate);
    chores(newChores);

    _setFilterViews();

    isLoading(false);
  }

  void _setFilterViews() {
    homePageChores(chores
        .where((chore) => chore.hasNoDueDate && _choreBelongsToUser(chore))
        .toList());
  }

  bool _choreBelongsToUser(Chore chore) =>
      chore.nextDueUserId == auth.user()?.id;

  int _choresByDueDate(Chore choreA, Chore choreB) {
    if (choreA.nextDueDate == null) {
      return choreB.nextDueDate == null ? 0 : 1;
    }

    if (choreB.nextDueDate == null) {
      return -1;
    }

    return choreA.nextDueDate!.difference(choreB.nextDueDate!).inDays;
  }
}
