import 'package:jsonplaceholder_client/jsonplaceholder_client.dart';

enum UserAuthenticationStatus {
  unknown,
  signedIn,
  signedOut,
}

class UserRepository {
  UserRepository(JsonplaceholderClient jsonPlaceholderClient)
      : _jsonplaceholderClient = jsonPlaceholderClient;

  final JsonplaceholderClient _jsonplaceholderClient;

  Stream<UserAuthenticationStatus> get authenticationStatus {
    return _jsonplaceholderClient.authenticationStatus.map((status) {
      switch (status) {
        case AuthenticationStatus.authenticated:
          return UserAuthenticationStatus.signedIn;
        case AuthenticationStatus.unauthenticated:
          return UserAuthenticationStatus.signedOut;
        case AuthenticationStatus.initial:
          return UserAuthenticationStatus.unknown;
      }
    });
  }

  Future<void> signIn({
    required String fullName,
    required String password,
    required String phone,
    required String birthDate,
    required String gender,
  }) async {
    await _jsonplaceholderClient.authenticate(
      userRegisterModel: UserRegisterModel(fullName: fullName, phone: phone, birthDate: birthDate, password: password, gender: gender)
    );
  }

  Future<void> signOut() async {
    await _jsonplaceholderClient.unauthenticate();
  }
}
