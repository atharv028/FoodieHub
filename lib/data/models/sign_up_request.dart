import 'dart:convert';

class SignUpRequest {
  String? name;
  String? phone;
  String? email;
  String? password;

  SignUpRequest({this.name, this.phone, this.email, this.password});

  @override
  String toString() {
    return 'SignUpRequest(name: $name, phone: $phone, email: $email, password: $password)';
  }

  factory SignUpRequest.fromMap(Map<String, Object?> data) => SignUpRequest(
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        password: data['password'] as String?,
      );

  Map<String, Object?> toMap() => {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SignUpRequest].
  factory SignUpRequest.fromJson(String data) {
    return SignUpRequest.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [SignUpRequest] to a JSON string.
  String toJson() => json.encode(toMap());
}
