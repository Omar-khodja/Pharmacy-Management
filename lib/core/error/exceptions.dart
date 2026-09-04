class RemoteException implements Exception {
  final String message;
  final int? statusCode;
  RemoteException({required this.message , this.statusCode});

  @override
  String toString() => message;
}

class AppDioException implements Exception {
  final String message;

  AppDioException(this.message);

  @override
  String toString() => message;
}
