part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class LoginUsernameChanged extends LoginEvent {
  LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginGenderChanged extends LoginEvent {
  LoginGenderChanged(this.gender);

  final String gender;

  @override
  List<Object> get props => [gender];
}

class LoginPhoneChanged extends LoginEvent {
  LoginPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class LoginDateChanged extends LoginEvent {
  LoginDateChanged(this.date);

  final String date;

  @override
  List<Object> get props => [date];
}

class LoginSubmitted extends LoginEvent {}
