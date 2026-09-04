abstract class AppFailure {
  final String message;

  AppFailure(this.message);

  @override
  String toString() => 'AppFa: $message';
}
class RemoteFailure extends AppFailure {
   RemoteFailure(super.message);
}
class DioFailure extends AppFailure {
  DioFailure(super.message);
}
class LocalStorageFailure extends AppFailure {
  LocalStorageFailure(super.message);
}

class UnexpectedFailure extends AppFailure {
  UnexpectedFailure(super.message);
}
