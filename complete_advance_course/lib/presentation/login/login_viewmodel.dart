import 'dart:async';

import 'package:complete_advance_course/domain/usecase/login_usecase.dart';
import 'package:complete_advance_course/presentation/base/base_view_moderl.dart';
import 'package:complete_advance_course/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  LoginUseCase? _loginUseCase; //! remove ?
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {}

  //! input
  @override
  Sink get inputPassword => _passwordStreamController;

  @override
  Sink get inputUserName => _userNameStreamController;

  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    (await _loginUseCase!.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // left -> failure
                  print(failure.message)
                },
            (data) => {
                  // right -> success (data)
                  print(data.customer?.name)
                });
  }

  // ? output
  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); //? data class operation same as kotlin
    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    _validate();
  }

  Stream<bool> get outputIsAllInputValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsvalid());

  //private functions
  _validate() {
    inputIsAllInputsValid.add(null);
  }

  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  _isAllInputsvalid() {
    return (_isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName));
  }
}

mixin LoginViewModelInputs {
  //three functions for actions
  setUserName(String userName);
  setPassword(String password);
  login();
  //two sink for streams
  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputsValid;
}

mixin LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputValid;
}
