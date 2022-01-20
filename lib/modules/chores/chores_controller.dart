import 'package:chore_manager_mobile/data/chore_manager_web/chores/chores_adapter.dart';
import 'package:chore_manager_mobile/modules/auth/auth_controller.dart';
import 'package:chore_manager_mobile/modules/chores/chore.dart';
import 'package:get/get.dart';

class ChoresController extends GetxController {
  final AuthController auth = Get.find();
  final RxList<Chore> chores = RxList<Chore>();
  late final ChoresAdapter adapter;

  @override
  Future<void> onInit() async {
    super.onInit();

    adapter = ChoresAdapter(auth.authToken());
    chores(await adapter.index());
  }
}
