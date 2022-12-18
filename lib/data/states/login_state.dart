
abstract class AppLoginStates{}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates
{
  final String  uId ;
  AppLoginSuccessState(this.uId);
}

class AppLoginErrorState extends AppLoginStates
{
  late final String error;
  AppLoginErrorState(this.error);
}

class AppLoginChangePasswordVisibilityState extends AppLoginStates {}
