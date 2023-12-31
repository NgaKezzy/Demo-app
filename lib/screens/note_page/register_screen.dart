import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_bloc/cubit/register_cubit.dart';
import 'package:test_bloc/screens/note_page/login_screen.dart';
import 'package:test_bloc/widgets/button_submit.dart';
import 'package:test_bloc/widgets/custom_textfield_login.dart';
import 'package:test_bloc/widgets/input_password.dart';
import 'package:test_bloc/widgets/show_alert_dialog.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKeyRegister = GlobalKey<FormState>();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final RegisterBloc blocRead = context.read<RegisterBloc>();
    final RegisterCubit registerCubit = context.read<RegisterCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF83A2FF),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: BlocListener<RegisterCubit, RegisterCubitState>(
            listener: (context, state) {
              state.isRegister
                  ? ShowAlertDialog(
                      statusDialog: StatusDialog.success,
                      context: context,
                      title: 'Đăng ký thành công',
                      content: 'Nhấn ok để đăng nhập',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                    )
                  : ShowAlertDialog(
                      statusDialog: StatusDialog.warning,
                      context: context,
                      title: 'Đăng thất bại !',
                      content: 'Nhấn ok để tiếp tục đăng ký,',
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
            },
            child: Form(
              key: formKeyRegister,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'Đăng ký',
                    style: TextStyle(color: Color(0xFF83A2FF), fontSize: 50),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfieldLogin(
                    labelText: 'username',
                    controller: userNameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputPassword(
                    labelText: 'password',
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputPassword(
                    labelText: 'confirm password',
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 40,
                    child: ButtonSubmit(
                      textButton: "Đăng ký",
                      onPressed: () {
                        if (formKeyRegister.currentState!.validate()) {
                          registerCubit.registerCheck(
                              userName: userNameController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text);
                          userNameController.text = '';
                          passwordController.text = '';
                          confirmPasswordController.text = '';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
