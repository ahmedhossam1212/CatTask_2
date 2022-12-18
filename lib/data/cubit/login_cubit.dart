import 'package:cat_task2/data/states/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppLoginCubit extends Cubit<AppLoginStates>
{
 AppLoginCubit() : super(AppLoginInitialState());
  static AppLoginCubit get(context) => BlocProvider.of(context);



  void userLogin({
    required String email,
    required String password,
  })
  {
    emit(AppLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password).then((value) {
        emit(AppLoginSuccessState(value.user!.uid));
  }).catchError((error){
    emit( AppLoginErrorState(error.toString()) );
  });
  

  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility ()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppLoginChangePasswordVisibilityState());

  }


}