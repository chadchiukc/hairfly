import 'package:get/get.dart';
import 'package:hairfly/models/user.dart';
import 'package:hairfly/utils/database.dart';

class UserController extends GetxController {
  final Rx<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }

  void syncFirebase(String? uid) async {
    print('syncing');
    if (_userModel.value.id != uid &&
        uid != null &&
        _userModel.value.name == null) {
      try {
        _userModel.value = await Database().getUser(uid);
      } catch (e) {
        rethrow;
      }
    }
  }
}
