import 'data_response.dart';

class DataResponseError extends DataResponse {
  final bool isError = true;
  final String message;

  const DataResponseError({this.message = ''});
}
