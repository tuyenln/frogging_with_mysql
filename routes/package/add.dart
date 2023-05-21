import 'package:dart_frog/dart_frog.dart';
import 'package:frogging/source/data_source.dart';
import 'package:frogging/source/package_source.dart';
import 'package:test/expect.dart';

// we will create a request to read our dataSource
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method.value != 'POST') {
    return Response.json(body: {
      'code': 400,
      'status': 'fail',
      'message': 'Method do not allow'
    });
  }
  // reading the context of our dataSource
  final request = context.request;
  final body = await request.json();

  final name = body['name'].toString();
  final description = body['description'].toString();
  final price = body['price'].toString();

  final dataRepository = context.read<DataSource>();
  // based on that we will await and fetch the fields from our database
  final package = await dataRepository.addPackage(name, description, price);

  if (package == false) {
    return Response.json(
        body: {'status': 'fail', 'code': 200, 'message': 'fail'});
  }

  // than we will return the response as JSON
  return Response.json(body: {'status': 'ok', 'code': 200, 'message': 'ok'});
}
