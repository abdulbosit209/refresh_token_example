part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  submissionInProgress,
  submissionSuccess,
  submissionFailure
}

class LoginState extends Equatable {
  const LoginState({
    required this.userRegisterModel,
    this.status = LoginStatus.initial,
  });

  final LoginStatus status;
  final UserRegisterModel userRegisterModel;

  bool get submissionEnabled =>
      status != LoginStatus.submissionInProgress &&
          userRegisterModel.gender.isNotEmpty &&
          userRegisterModel.phone.isNotEmpty &&
          userRegisterModel.password.isNotEmpty;

  LoginState copyWith({
    LoginStatus? status,
    UserRegisterModel? userRegisterModel
  }) {
    return LoginState(
      status: status ?? this.status,
      userRegisterModel: userRegisterModel ?? this.userRegisterModel
    );
  }

  @override
  List<Object> get props => [status, userRegisterModel];

  @override
  bool get stringify => true;
}
