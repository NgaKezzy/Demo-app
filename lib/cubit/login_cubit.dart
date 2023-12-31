import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_bloc/config/save_data.dart';
import 'package:test_bloc/cubit/login_state.dart';
import 'package:test_bloc/models/user_model.dart';

List<UserModel> users = [UserModel(userName: 'username', password: '11111')];

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitState());

  void authLogin(
      {required String userController,
      required String passwordController}) async {
    emit(state.copyWith(status: LoginStatus.start));
    for (int i = 0; i < users.length; i++) {
      if (users[i].userName == userController.trim() &&
          users[i].password == passwordController) {
        emit(state.copyWith(isLogin: true));

        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(SaveData.saveIsLogIn, true);
        sharedPreferences.setString(
            SaveData.saveUserName, userController.trim());
        sharedPreferences.setString(SaveData.savePassword, passwordController);
      } else {
        emit(state.copyWith(isLogin: false, status: LoginStatus.success));
      }
      emit(state.copyWith(
          user: UserModel(
              userName: userController.trim(), password: passwordController)));
    }
  }

  Future<void> getUserLocal() async {
    emit(state.copyWith(status: LoginStatus.start));

    final String user;
    final String pass;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    user = sharedPreferences.getString(SaveData.saveUserName) ?? '';
    pass = sharedPreferences.getString(SaveData.savePassword) ?? '';
    emit(state.copyWith(
        user: UserModel(userName: user, password: pass),
        status: LoginStatus.success));
  }

  Future<void> logout() async {
    emit(state.copyWith(status: LoginStatus.start));

    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove(SaveData.saveIsLogIn);
    sharedPreferences.remove(SaveData.saveUserName);
    sharedPreferences.remove(SaveData.savePassword);
    emit(state.copyWith(isLogin: false, status: LoginStatus.success));
  }
}
