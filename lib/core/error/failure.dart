abstract class AppFailure {
  final String message;

  AppFailure(this.message);

  @override
  String toString() => 'AppFa: $message';
}
class RemoteFailure extends AppFailure {
   RemoteFailure(super.message);
}