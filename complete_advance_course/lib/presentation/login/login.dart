import 'package:complete_advance_course/presentation/login/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = LoginViewModel(null); // TODO: pass data
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
