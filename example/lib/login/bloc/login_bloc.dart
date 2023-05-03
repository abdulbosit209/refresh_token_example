import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jsonplaceholder_client/jsonplaceholder_client.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(UserRepository userRepository)
      : _userRepository = userRepository,
        super(LoginState(
            userRegisterModel: UserRegisterModel(
          phone: "",
          password: "",
          birthDate: "",
          gender: "",
          fullName: "",
        ))) {
    on<LoginUsernameChanged>(_onLoginUsernameChanged);
    on<LoginPasswordChanged>(_onLoginPasswordChanged);
    on<LoginPhoneChanged>(_loginPhoneChanged);
    on<LoginDateChanged>(_loginDateChanged);
    on<LoginGenderChanged>(_loginGenderChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final UserRepository _userRepository;

  void _loginGenderChanged(
      LoginGenderChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(userRegisterModel:  state.userRegisterModel.copyWith(gender: event.gender)));
  }


  void _loginDateChanged(
      LoginDateChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(userRegisterModel:  state.userRegisterModel.copyWith(birthDate: event.date)));
  }
  void _loginPhoneChanged(
      LoginPhoneChanged event,
      Emitter<LoginState> emit,
      ) {
    emit(state.copyWith(userRegisterModel:  state.userRegisterModel.copyWith(phone: event.phone)));
    }

  void _onLoginUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(userRegisterModel:  state.userRegisterModel.copyWith(fullName: event.username)));
  }

  void _onLoginPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(userRegisterModel: state.userRegisterModel.copyWith(password: event.password)));
  }


  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.submissionInProgress));
    try {
      await _userRepository.signIn(
        password: state.userRegisterModel.password,
        phone: state.userRegisterModel.phone,
        gender: state.userRegisterModel.gender,
        birthDate: state.userRegisterModel.birthDate,
        fullName: state.userRegisterModel.fullName
      );
      emit(state.copyWith(status: LoginStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: LoginStatus.submissionFailure));
    }
  }
}
