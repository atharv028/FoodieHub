import 'dart:convert';

class SignInRequest {
  String? phone;
  String? password;

  SignInRequest({this.phone, this.password});

  factory SignInRequest.fromMap(Map<String, Object?> data) => SignInRequest(
        phone: data['phone'] as String?,
        password: data['password'] as String?,
      );

  Map<String, Object?> toMap() => {
        'phone': phone,
        'password': password,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SignUpRequest].
  factory SignInRequest.fromJson(String data) {
    return SignInRequest.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [SignUpRequest] to a JSON string.
  String toJson() => json.encode(toMap());
}
