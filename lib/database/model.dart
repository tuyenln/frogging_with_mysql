/// Model based on you table inside MySQL

// ignore_for_file: public_member_api_docs

/*

Your database model - forExample

you created a database name profiles AND it has a table
called users and users have have rows and column you create
this model based on your fields inside you table



*/

class DatabaseModel {
  const DatabaseModel({
    this.id,
    this.fullname,
    this.email,
    this.password,
    this.role,
  });

  // fromJSON
  factory DatabaseModel.fromJson(Map<String, dynamic> json) {
    return DatabaseModel(
      id: json['id'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      role: json['role'] as String,
    );
  }

  // Create an DatabaseModel given a row.assoc() map
  factory DatabaseModel.fromRowAssoc(Map<String, String?> json) {
    return DatabaseModel(
      email: json['email'],
      password: json['password'],
      id: json['id'],
      fullname: json['fullname'],
      role: json['role'],
    );
  }

  // toJSON
  Map<String, dynamic> toJson() {
    return {
      'id': int.parse(id!),
      'email': email.toString(),
      // 'password': password.toString(),
      'fullname': fullname.toString(),
      'role': role.toString(),
    };
  }

  final String? email;
  final String? password;
  final String? fullname;
  final String? role;
  final String? id;
}
