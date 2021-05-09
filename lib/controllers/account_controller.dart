import 'package:help_me/models/user_model.dart';
import 'package:help_me/repository/account_repository.dart';
import 'package:help_me/view_model/login_view_model.dart';
import 'package:help_me/view_model/singup_view_model.dart';

class AccountController {
  static UserModel userAuth;
  AccountRepository accountRepository = new AccountRepository();

  registerUser(SingupViewModel singupViewModel) {
    return accountRepository.createUserWithEmail(singupViewModel);
  }

  loginUser(LoginViewModel loginViewModel) async {
    var response = await accountRepository.authUserWithEmail(loginViewModel);
    userAuth = UserModel.fromUser(await verifyUserAuth());
    return response;
  }

  Future verifyUserAuth() async {
    return accountRepository.verifyUserAuth();
  }

  singOut() async {
    return accountRepository.singOut();
  }
}
