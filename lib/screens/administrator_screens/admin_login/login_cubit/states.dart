abstract class AdminLoginStates{}

class AdminLoginInitialState extends AdminLoginStates{}

class ChangeSuffixIconState extends AdminLoginStates{}

class LoginLoadingState extends AdminLoginStates{}
class LoginSuccessState extends AdminLoginStates{}
class LoginErrorState extends AdminLoginStates{
  final String errorMsg;
  LoginErrorState({required  this.errorMsg});
}

class GetUserDataLoadingState extends AdminLoginStates{}
class GetUserDataSuccessState extends AdminLoginStates{}
class GetUserDataErrorState extends AdminLoginStates{}