import 'package:dio/dio.dart';
import 'package:fresh/fresh.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:jsonplaceholder_client/jsonplaceholder_client.dart';

class PhotosRequestFailureException implements Exception {}

class JsonplaceholderClient {
  JsonplaceholderClient({Dio? httpClient})
      : _httpClient = (httpClient ?? Dio())
          ..options.baseUrl = 'http://192.168.1.12:8080/api/v1/'
          ..interceptors.add(_fresh)
          ..interceptors.add(
            LogInterceptor(request: false, responseHeader: false),
          );

  static final _fresh = Fresh.oAuth2(
    tokenStorage: InMemoryTokenStorage<OAuth2Token>(),
    refreshToken: (token, client) async {
      try {
        final Response response = await client.post(
          'http://192.168.1.12:8080/api/v1/user/get/token/refreshToken',
          data: "${token!.refreshToken}",
        );
        print("response ${response.data['data']['accessToken']}");
        if (response.data['data']['accessToken'] == null) {
          throw RevokeTokenException();
        }
        return OAuth2Token(
          accessToken: response.data['data']['accessToken'],
          refreshToken: token.refreshToken,
        );
      } catch (e) {
        print("catch exeption $e");
        throw RevokeTokenException();
      }
    },
    shouldRefresh: (_) => true,
  );

  final Dio _httpClient;

  Stream<AuthenticationStatus> get authenticationStatus =>
      _fresh.authenticationStatus;

  Future<void> authenticate({
    required UserRegisterModel userRegisterModel,
  }) async {
    try {
      var formData = FormData.fromMap(userRegisterModel.toJson());
      var response = await _httpClient.post(
        'http://192.168.1.12:8080/api/v1/user/register',
        data: formData,
      );
      await _fresh.setToken(
        OAuth2Token(
          accessToken: response.data['data']['accessToken'],
          refreshToken: response.data['data']['refreshToken'],
        ),
      );
    } catch (e) {
      print("authenticate Exeption $e");
    }
  }

  Future<void> unauthenticate() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _fresh.setToken(null);
  }

  // Future<List<Photo>> photos() async {
  //   final response = await _httpClient.get('/photos');

  //   if (response.statusCode != 200) {
  //     throw PhotosRequestFailureException();
  //   }

  //   return (response.data as List)
  //       .map((dynamic item) => Photo.fromJson(item as Map<String, dynamic>))
  //       .toList();
  // }
}
