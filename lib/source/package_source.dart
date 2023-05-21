// ignore_for_file: lines_longer_than_80_chars
import 'package:frogging/database/package_model.dart';
import 'package:frogging/database/sql_client.dart';

/// data source form MySQL

class PackageSource {
  /// initializing
  const PackageSource(
    this.sqlClient,
  );

  /// accessing you client
  final MySQLClient sqlClient;

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
  Future<List<PackageModel>> fetchFields(name) async {
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
