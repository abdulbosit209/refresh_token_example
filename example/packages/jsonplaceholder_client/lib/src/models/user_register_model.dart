class UserRegisterModel {
  UserRegisterModel({
    required this.fullName,
    required this.phone,
    required this.birthDate,
    required this.password,
    required this.gender,
  });

  final String fullName;
  final String phone;
  final String birthDate;
  final String password;
  final String gender;


  UserRegisterModel copyWith({
    String? fullName,
    String? phone,
    String? birthDate,
    String? password,
    String? gender,
  }) =>
      UserRegisterModel(
          phone: phone ?? this.phone,
          password: password ?? this.password,
          gender: gender ?? this.gender,
          birthDate: birthDate ?? this.birthDate,
          fullName: fullName ?? this.fullName
      );


  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phone": phone,
    "birthDate": birthDate,
    "password": password,
    "gender": gender,
  };
}