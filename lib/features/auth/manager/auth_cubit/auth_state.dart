part of 'auth_cubit.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthloadingLogin extends AuthState {}

final class AuthSuccessLogin extends AuthState {}

final class AuthFailureLogin extends AuthState {
  String errmessage;
  AuthFailureLogin({required this.errmessage});
}

final class AuthloadingRegister extends AuthState {}

final class AuthSuccessRegister extends AuthState {}

final class AuthFailureRegister extends AuthState {
  String errmessage;
  AuthFailureRegister({required this.errmessage});
}
