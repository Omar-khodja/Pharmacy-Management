class RemoteException implements Exception {
  final String message;

  RemoteException(this.message);

  @override
  String toString() => message;
}

class AppDioException implements Exception {
  final String message;

  AppDioException(this.message);

  @override
  String toString() => message;
}
