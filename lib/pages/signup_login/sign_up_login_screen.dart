import 'package:easypack/pages/signup_login/signup_form.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class SignUpLoginScreen extends StatelessWidget {
  const SignUpLoginScreen({super.key});
  // final loginProvider = Provider.of<AuthUserProvider>;
  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(BuildContext context, LoginData data) async {
    final loginProvider = Provider.of<AuthUserProvider>(context, listen: false);
    final errorMessage =
        await loginProvider.authUser(context, data.name, data.password);
    return errorMessage;
  }

  Future<String?> _moreInfo(BuildContext context, SignupData data) async {
    final result = await Navigator.push<String?>(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpForm(data: data),
      ),
    );
    return result;
  }

  Future<String?> _forgotPassword(BuildContext context, String email) async {
    final loginProvider = Provider.of<AuthUserProvider>(context, listen: false);
    final errorMessage =
        await loginProvider.forgotPassword(context, email);
    return errorMessage;
  }


  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Easy Pack',
      theme: LoginTheme(
        primaryColor:const Color.fromARGB(255, 50, 50, 50),
        pageColorDark: const Color.fromARGB(255, 0, 0, 0),
        accentColor:const Color.fromARGB(255, 239, 226, 226),
        buttonTheme: const LoginButtonTheme(backgroundColor: Colors.grey),
      ),
      logo: const AssetImage('lib/assets/logo/suitcase_airplane.png'),
      onLogin: (LoginData data) => _authUser(context, data),
      onSignup: (SignupData data) => _moreInfo(context, data),
      onRecoverPassword: (String name) => _forgotPassword(context, name),
    );
  }
}
