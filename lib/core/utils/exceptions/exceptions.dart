class MessageException implements Exception {
  final String message;

  MessageException({required this.message});
}

class SomethingWentWrongException extends MessageException {
  SomethingWentWrongException({super.message = 'Something went wrong'});
}
