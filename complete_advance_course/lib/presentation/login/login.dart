import 'package:complete_advance_course/presentation/login/login_viewmodel.dart';
import 'package:complete_advance_course/presentation/resources/app_string.dart';
import 'package:complete_advance_course/presentation/resources/assets_manager.dart';
import 'package:complete_advance_course/presentation/resources/color_manager.dart';
import 'package:complete_advance_course/presentation/resources/routes_manager.dart';
import 'package:complete_advance_course/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginViewModel _viewModel = LoginViewModel(null); // TODO: pass data
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
    return _getContentWidget();
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        padding: EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(children: [
            Image(image: AssetImage(ImageAssets.splashLogo)),
            SizedBox(height: AppSize.s28),

            //! UserName
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _userNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: AppString.username,
                          labelText: AppString.username,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.usernameError),
                    );
                  }),
            ),
            SizedBox(height: AppSize.s28),

            //! Password
            Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p28, right: AppPadding.p28),
              child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: AppString.password,
                          labelText: AppString.password,
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppString.passwordError),
                    );
                  }),
            ),
            SizedBox(height: AppSize.s28),

            //! Login Button
            Padding(
                padding: const EdgeInsets.only(
                    left: AppPadding.p28, right: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () => _viewModel.login()
                              : null,
                          child: Text(AppString.login)),
                    );
                  },
                )),

            Padding(
              padding: EdgeInsets.only(
                top: AppPadding.p8,
                left: AppPadding.p28,
                right: AppPadding.p28,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    //! Forget Password
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.forgetPasswordRoute);
                        },
                        child: Text(
                          AppString.forgetPassword,
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                    // ! Register Text
                        TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text(
                          AppString.registerText,
                          style: Theme.of(context).textTheme.titleSmall,
                        )),
                  ]),
            ),
          ]),
        )),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
