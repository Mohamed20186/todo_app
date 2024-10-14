import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  String? uid = '';
  Future<void> createUser(
      {required String name,
      required String email,
      required String password}) async {
    emit(AuthloadingRegister());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      credential.user?.updateDisplayName(name);
      uid = credential.user?.uid;
      emit(AuthSuccessRegister());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(AuthFailureRegister(
            errmessage: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(AuthFailureRegister(
            errmessage: 'The account already exists for that email.'));
      } else {
        emit(AuthFailureRegister(errmessage: e.code));
      }
    } catch (e) {
      emit(AuthFailureRegister(errmessage: e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(AuthloadingLogin());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      uid = credential.user?.uid;
      emit(AuthSuccessLogin());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthFailureLogin(errmessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthFailureLogin(
            errmessage: 'Wrong password provided for that user.'));
      } else {
        emit(AuthFailureLogin(errmessage: e.code));
      }
    } catch (e) {
      emit(AuthFailureLogin(errmessage: e.toString()));
    }
  }

  String? get getUserUid => uid;
}
