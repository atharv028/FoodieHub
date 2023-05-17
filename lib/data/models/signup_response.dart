import 'dart:convert';

class SignupResponse {
  String? status;
  String? token;

  SignupResponse({this.status, this.token});

  @override
  String toString() => 'SignupResponse(status: $status, token: $token)';

  factory SignupResponse.fromMap(Map<String, Object?> data) {
    return SignupResponse(
      status: data['status'] as String?,
      token: data['token'] as String?,
    );
  }

  Map<String, Object?> toMap() => {
        'status': status,
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SignupResponse].
  factory SignupResponse.fromJson(String data) {
    return SignupResponse.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [SignupResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
