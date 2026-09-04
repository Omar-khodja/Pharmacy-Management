abstract class AppFailure {
  final String message;
  final int? statusCode;
  AppFailure({required this.message,this.statusCode});

  @override
  String toString() => 'AppFa: $message';
}

class RemoteFailure extends AppFailure {
  RemoteFailure({required super.message , super.statusCode});
}

class DioFailure extends AppFailure {
  DioFailure({required super.message });
}

class LocalStorageFailure extends AppFailure {
  LocalStorageFailure({required super.message });
}

class UnexpectedFailure extends AppFailure {
  UnexpectedFailure({required super.message });
}
