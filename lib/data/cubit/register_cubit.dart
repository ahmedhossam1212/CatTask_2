
import 'package:cat_task2/data/models/user_model.dart';
import 'package:cat_task2/data/states/register_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class  AppRegisterCubit extends Cubit<AppRegisterStates> {
  AppRegisterCubit() : super(AppRegisterInitialState());

  static AppRegisterCubit get(context) => BlocProvider.of(context);


  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,

  }) {

    emit(AppRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      userCreate(
          email: email,
          name: name,
          phone: phone,
          uId:value.user!.uid
      );

    }).catchError((error){
      emit(AppRegisterErrorState(error.toString()));
    });
  }
  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  })
{    UserModel model = UserModel(
  name:name,
  email: email,
  phone: phone,
  uId: uId,
  );

FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .set(model.toMap())
    .then((value){

      emit(AppCreateUserSuccessState());
    })
    .catchError((error){

      emit(AppCreateUserErrorState(error.toString()));
    });
}
}
