import 'package:dart_frog/dart_frog.dart';
import 'package:frogging/source/data_source.dart';
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

  final email = body['email'].toString();
  final password = body['password'].toString();
  final fullname = body['fullname'].toString();

  final dataRepository = context.read<DataSource>();
  // based on that we will await and fetch the fields from our database
  final users = await dataRepository.addUser(fullname, email, password);

  if (users == false) {
    return Response.json(
        body: {'status': 'fail', 'code': 200, 'message': 'fail'});
  }

  // than we will return the response as JSON
  return Response.json(
      body: {'status': 'ok', 'code': 200, 'message': 'ok'});
}
