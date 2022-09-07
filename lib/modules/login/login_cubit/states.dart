
abstract class LoginStates {}
class InitialLoginState extends LoginStates {}
class LoginChangePasswordState extends LoginStates {}



class LoadingLoginUserState extends LoginStates {}
class SuccessLoginUserState extends LoginStates {
  String uid;
  SuccessLoginUserState(this.uid);
}

class ErrorLoginUserState extends LoginStates {
  final String error;
  ErrorLoginUserState(this.error);
}