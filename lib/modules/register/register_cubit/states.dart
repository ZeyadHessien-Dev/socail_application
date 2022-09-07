
abstract class RegisterStates {}
class InitialRegisterState extends RegisterStates {}
class RegisterChangePasswordState extends RegisterStates {}



class LoadingRegisterUserState extends RegisterStates {}
class SuccessRegisterUserState extends RegisterStates {}
class ErrorRegisterUserState extends RegisterStates {
  final String error;
  ErrorRegisterUserState(this.error);
}

class LoadingCreateUserState extends RegisterStates {}
class SuccessCreateUserState extends RegisterStates {
  String uid;
  SuccessCreateUserState(this.uid);
}

class ErrorCreateUserState extends RegisterStates {
  final String error;
  ErrorCreateUserState(this.error);
}