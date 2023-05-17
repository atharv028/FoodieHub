import 'dart:convert';

class User {
  int? id;
  String? fName;
  String? phone;
  String? email;
  int? status;
  dynamic emailVerifiedAt;
  String? password;
  dynamic rememberToken;
  dynamic createdAt;
  dynamic updatedAt;
  int? orderCount;

  User({
    this.id,
    this.fName,
    this.phone,
    this.email,
    this.status,
    this.emailVerifiedAt,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.orderCount,
  });

  @override
  String toString() {
    return 'User(id: $id, fName: $fName, phone: $phone, email: $email, status: $status, emailVerifiedAt: $emailVerifiedAt, password: $password, rememberToken: $rememberToken, createdAt: $createdAt, updatedAt: $updatedAt, orderCount: $orderCount)';
  }

  factory User.fromMap(Map<String, Object?> data) => User(
        id: data['id'] as int?,
        fName: data['f_name'] as String?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        status: data['status'] as int?,
        emailVerifiedAt: data['email_verified_at'] as dynamic,
        password: data['password'] as String?,
        rememberToken: data['remember_token'] as dynamic,
        createdAt: data['created_at'] as dynamic,
        updatedAt: data['updated_at'] as dynamic,
        orderCount: data['order_count'] as int?,
      );

  Map<String, Object?> toMap() => {
        'id': id,
        'f_name': fName,
        'phone': phone,
        'email': email,
        'status': status,
        'email_verified_at': emailVerifiedAt,
        'password': password,
        'remember_token': rememberToken,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'order_count': orderCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, Object?>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
