import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Function() onUnauthorized;

  AuthInterceptor(this.onUnauthorized);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      onUnauthorized();
    }
    super.onError(err, handler);
  }
}
