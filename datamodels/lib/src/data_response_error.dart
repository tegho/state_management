import 'data_response.dart';

class DataResponseError extends DataResponse {
  final bool isError = true;
  late final String _message;

  DataResponseError({String message = ''}) {
    _message = message;
  }

  String get message => _message;
}
