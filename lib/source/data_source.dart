// ignore_for_file: lines_longer_than_80_chars

import 'package:frogging/database/model.dart';
import 'package:frogging/database/sql_client.dart';

import '../database/package_model.dart';
import '../ultils/helper.dart';

/// data source form MySQL

class DataSource {
  /// initializing
  const DataSource(
    this.sqlClient,
  );

  /// accessing you client
  final MySQLClient sqlClient;

  // ignore: inference_failure_on_untyped_parameter, public_member_api_docs
  Future<bool> updateUser(id, email, String password) async {
    const sqlQueryCount = 'SELECT id FROM users WHERE id = :id';

    // ignore: omit_local_variable_types, prefer_final_locals
    Map<String, dynamic> param = {
      'id': id,
    };

    final res = await sqlClient.execute(sqlQueryCount, params: param);
    // ignore: unused_local_variable
    // for (final row in res.rows) {
    //   // print(row.assoc());
    //   // print(row.colAt(0));
    //   return false;
    // }

    if (res.affectedRows != 0) {
      int count = res.length;
      // sqlQuey
      const sqlQuery = 'UPDATE users SET password = :password WHERE id = :id';

      final hashed = hashPassword(password);

      Map<String, dynamic> params = {};
      params['id'] = id;
      params['password'] = hashed;
      final result = await sqlClient.execute(sqlQuery, params: params);
      // ignore: unrelated_type_equality_checks
      if (result.affectedRows != 0) {
        return true;
      }
    }

    // ignore: omit_local_variable_types, prefer_final_locals
    // int count = res.length;
    // if (count > 0) {
    //   return false;
    // }
    return false;
  }

  ///Fetches all table fields from users table in our database
  Future<List<DatabaseModel>> fetchUserById(id) async {
    // sqlQuey
    const sqlQuery =
        'SELECT id, email, fullname, role FROM users WHERE id = :id';

    Map<String, dynamic> params = {};
    params['id'] = id;
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
  Future<List<DatabaseModel>> fetchUser(String email, String password) async {
    // sqlQuey
    const sqlQuery =
        'SELECT * FROM users WHERE email = :email AND password = :password';

    // Map<String, dynamic> user = {
    //   'email': email,
    // };
    final hashedPassword = hashPassword(password);
    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = hashedPassword;
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
  Future<bool> addUser(String fullname, String email, String password) async {
    const sqlQueryCount = 'SELECT id FROM users WHERE email = :email';

    Map<String, dynamic> param = {
      'email': email,
    };
    final res = await sqlClient.execute(sqlQueryCount, params: param);
    for (final row in res.rows) {
      // print(row.assoc());
      // print(row.colAt(0));
      return false;
    }

    int count = res.length;
    // print(count);
    // if (count > 0) {
    //   return false;
    // }

    final hashedPassword = hashPassword(password);
    // sqlQuey
    const sqlQuery =
        'INSERT INTO users (email, password, fullname, role) VALUES (:email, :password, :fullname, :role)';

    // Map<String, dynamic> user = {
    //   'email': email,
    // };
    Map<String, dynamic> params = {};
    params['email'] = email;
    params['password'] = hashedPassword;
    params['fullname'] = fullname;
    params['role'] = 'Member';
    final result = await sqlClient.execute(sqlQuery, params: params);
    print(result.affectedRows);
    if (result.affectedRows != 0) {
      return true;
    }
    return false;
  }

  ///Fetches all table fields from users table in our database
  Future<List<PackageModel>> fetchPackages() async {
    // sqlQuey
    const sqlQuery = 'SELECT * FROM packages;';
    // executing our sqlQuery
    final result = await sqlClient.execute(sqlQuery);

    final packages = <PackageModel>[];
    for (final row in result.rows) {
      packages.add(PackageModel.fromRowAssoc(row.assoc()));
    }
    return packages;
  }

  ///Fetches user table fields from users table in our database
  Future<List<PackageModel>> fetchPackage(name) async {
    // sqlQuey
    const sqlQuery = 'SELECT * FROM packages WHERE name = :name';

    // Map<String, dynamic> user = {
    //   'email': email,
    // };
    Map<String, dynamic> params = {};
    params['name'] = name;
    // executing our sqlQuery
    final result = await sqlClient.execute(sqlQuery, params: params);

    final package = <PackageModel>[];
    for (final row in result.rows) {
      package.add(PackageModel.fromRowAssoc(row.assoc()));
    }
    return package;
  }

  // ignore: inference_failure_on_untyped_parameter, public_member_api_docs
  Future<bool> addPackage(name, description, price) async {
    const sqlQueryCount = 'SELECT id FROM packages WHERE name = :name';

    // ignore: omit_local_variable_types, prefer_final_locals
    Map<String, dynamic> param = {
      'name': name,
    };

    final res = await sqlClient.execute(sqlQueryCount, params: param);
    // ignore: unused_local_variable
    for (final row in res.rows) {
      // print(row.assoc());
      // print(row.colAt(0));
      return false;
    }

    // ignore: omit_local_variable_types, prefer_final_locals
    int count = res.length;
    // print(count);
    // if (count > 0) {
    //   return false;
    // }

    // sqlQuey
    const sqlQuery =
        'INSERT INTO packages (name, description, price) VALUES (:name, :description, :price) ';

    Map<String, dynamic> params = {};
    params['name'] = name;
    params['description'] = description;
    params['price'] = price;
    final result = await sqlClient.execute(sqlQuery, params: params);
    // ignore: unrelated_type_equality_checks
    if (result.affectedRows != 0) {
      return true;
    }
    return false;
  }

  // ignore: inference_failure_on_untyped_parameter, public_member_api_docs
  Future<bool> updatePackage(id, name, description, price) async {
    const sqlQueryCount = 'SELECT id FROM packages WHERE id = :id';

    // ignore: omit_local_variable_types, prefer_final_locals
    Map<String, dynamic> param = {
      'id': id,
    };

    final res = await sqlClient.execute(sqlQueryCount, params: param);
    // ignore: unused_local_variable
    // for (final row in res.rows) {
    //   // print(row.assoc());
    //   // print(row.colAt(0));
    //   return false;
    // }

    if (res.affectedRows != 0) {
      int count = res.length;
      // sqlQuey
      const sqlQuery =
          'UPDATE packages SET name = :name, description = :description, price = :price WHERE id = :id';

      Map<String, dynamic> params = {};
      params['id'] = id;
      params['name'] = name;
      params['description'] = description;
      params['price'] = price;
      final result = await sqlClient.execute(sqlQuery, params: params);
      // ignore: unrelated_type_equality_checks
      if (result.affectedRows != 0) {
        return true;
      }
    }

    // ignore: omit_local_variable_types, prefer_final_locals
    // int count = res.length;
    // if (count > 0) {
    //   return false;
    // }
    return false;
  }

  // ignore: inference_failure_on_untyped_parameter, public_member_api_docs
  Future<bool> deletePackage(id) async {
    const sqlQueryCount = 'DELETE FROM packages WHERE id = :id';

    // ignore: omit_local_variable_types, prefer_final_locals
    Map<String, dynamic> param = {
      'id': id,
    };

    final result = await sqlClient.execute(sqlQueryCount, params: param);
    // ignore: unused_local_variable
    if (result.affectedRows != 0) {
      return true;
    }
    return false;
  }
}
