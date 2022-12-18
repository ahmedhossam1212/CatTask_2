abstract class AppRegisterStates{}

class AppRegisterInitialState extends AppRegisterStates {}

class AppRegisterLoadingState extends AppRegisterStates {}

class AppRegisterSuccessState extends AppRegisterStates {}

class AppRegisterErrorState extends AppRegisterStates
{
  late final String error;
  AppRegisterErrorState(this.error);
}

class AppRegisterChangePasswordVisibilityState extends AppRegisterStates {}

class AppCreateUserSuccessState extends AppRegisterStates {}

class AppCreateUserErrorState extends AppRegisterStates
{
  late final String error;
  AppCreateUserErrorState(this.error);
}
