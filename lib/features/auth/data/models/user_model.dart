class UserModel {
  dynamic id;
  String? name;
  String? nis;
  String? email;
  String? passHash;
  String? updatedAt;

  UserModel({this.name, this.nis, this.email, this.passHash, this.updatedAt});

  // Method untuk membuat instance dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      nis: json['nis'],
      email: json['email'],
      passHash: json['pass_hash'],
      updatedAt: json['updated_at'],
    );
  }

  // Method untuk mengubah instance menjadi JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nis': nis,
      'email': email,
      'pass_hash': passHash,
      'updated_at': updatedAt,
    };
  }
}
