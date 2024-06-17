import 'package:easypack/pages/signup_login/signup_form.dart';
import 'package:easypack/providers/auth_user_provider.dart';
import 'package:easypack/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';

class SignUpLoginScreen extends StatelessWidget {
  const SignUpLoginScreen({super.key});

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
    final errorMessage = await loginProvider.forgotPassword(context, email);
    return errorMessage;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Easy Pack',
      theme: LoginTheme(
        primaryColor: const Color.fromARGB(255, 25, 68, 123),
        accentColor: const Color.fromARGB(255, 239, 226, 226),
        buttonTheme: const LoginButtonTheme(backgroundColor: Colors.grey),
      ),
      logo: const AssetImage('lib/assets/logo/suitcase_airplane.png'),
      onLogin: (LoginData data) => _authUser(context, data),
      passwordValidator: (String? password) =>
          Validators.validatePasswordStrength(password),
      onSignup: (SignupData data) => _moreInfo(context, data),
      onRecoverPassword: (String name) => _forgotPassword(context, name),
      messages: LoginMessages(
        recoverPasswordDescription:
            "Hang tight! We'll send you an email with a link to reset your password.",
      ),
    );
  }
}
