import 'package:dio/dio.dart';

class DataState<T> {
  final T? successData;
  final DioException? error;
  final RequestFailed  requestFailData;

  final String? message;

  const DataState({this.message, this.successData, this.error, this.requestFailData});
}



class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data, {super.message}) : super(successData: data);
}

class DataFailedWithResponse<T> extends DataState<T> {
  const DataFailedWithResponse(RequestFailed requestFailData) : super(requestFailData: requestFailData);
}

class DataFailedWithoutResponse<T> extends DataState<T> {
  const DataFailedWithoutResponse(DioException error) : super(error: error);
}