// ignore_for_file: lines_longer_than_80_chars

import 'package:frogging/database/model.dart';
import 'package:frogging/database/sql_client.dart';

/// data source form MySQL

class DataSource {
  /// initializing
  const DataSource(
    this.sqlClient,
  );

  /// accessing you client
  final MySQLClient sqlClient;

  ///Fetches all table fields from users table in our database
  Future<List<DatabaseModel>> fetchFields() async {
    // sqlQuey
    const sqlQuery = 'SELECT email, password FROM users;';
    // executing our sqlQuery
    final result = await sqlClient.execute(sqlQuery);
    // a list to save our users from the table -
    // i mean whatever as many as user we get from table

    final users = <DatabaseModel>[];
    for (final row in result.rows) {
      users.add(DatabaseModel.fromRowAssoc(row.assoc()));
    }
    // simply returning the whatever the the users
    // we will get from the MySQL database
    return users;
  }

  ///Fetches user table fields from users table in our database
  Future<List<DatabaseModel>> fetchUser(email, password) async {
    // sqlQuey
    const sqlQuery =
        'SELECT * FROM users WHERE email = :email AND password = :password';

    // Map<String, dynamic> user = {
    //   'email': email,
    // };
    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = password;
    // executing our sqlQuery
    final result = await sqlClient.execute(sqlQuery, params: params);
    // a list to save our users from the table -
    // i mean whatever as many as user we get from table

    final users = <DatabaseModel>[];
    for (final row in result.rows) {
      users.add(DatabaseModel.fromRowAssoc(row.assoc()));
    }
    // simply returning the whatever the the users
    // we will get from the MySQL database
    return users;
  }

  ///Fetches user table fields from users table in our database
  // Future<bool> addUser(fullname, email, password) async {
  ///Fetches user table fields from users table in our database
  Future<bool> addUser(fullname, email, password) async {
    const sqlQueryCount = 'SELECT COUNT(*) FROM users WHERE email = :email';

    Map<String, dynamic> param = {
      'email': email,
    };
    final res = await sqlClient.execute(sqlQueryCount, params: param);

    int count = res.length;
    print(count);
    if (count > 0) {
      return false;
    }

    // sqlQuey
    const sqlQuery =
        'INSERT INTO users (email, password, fullname, role) VALUES (:email, :password, :fullname, :role)';

    // Map<String, dynamic> user = {
    //   'email': email,
    // };
    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = password;
    params['fullname'] = fullname;
    params['role'] = 'Member';
    final result = await sqlClient.execute(sqlQuery, params: params);
    print(result.affectedRows);
    if (result.affectedRows != 0) {
      return true;
    }
    return false;
  }
}
