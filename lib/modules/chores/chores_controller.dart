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

    return refreshChores();
  }

  Future<void> refreshChores() async {
    isLoading(true);

    final List<Chore> newChores = await adapter.index();

    newChores.sort(_choresByDueDate);

    chores(newChores);

    homePageChores(newChores.where((chore) {
      return chore.hasNoDueDate && chore.nextDueUserId == auth.user()?.id;
    }).toList());

    isLoading(false);
  }

  int _choresByDueDate(Chore choreA, Chore choreB) {
    if (choreA.nextDueDate == null) {
      if (choreB.nextDueDate == null) {
        return 0;
      }
      return 1;
    }

    if (choreB.nextDueDate == null) {
      return -1;
    }

    return choreA.nextDueDate!.difference(choreB.nextDueDate!).inDays;
  }
}
