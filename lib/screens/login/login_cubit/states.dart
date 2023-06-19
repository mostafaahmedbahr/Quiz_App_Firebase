abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class ChangeSuffixIconState extends LoginStates{}

class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{}
class LoginErrorState extends LoginStates{
  final String errorMsg;
  LoginErrorState({required  this.errorMsg});
}

class GetUserDataLoadingState extends LoginStates{}
class GetUserDataSuccessState extends LoginStates{}
class GetUserDataErrorState extends LoginStates{}