class MessageException implements Exception {
  final String message;

  MessageException({required this.message});
}

class SomethingWentWrongException extends MessageException {
  SomethingWentWrongException({super.message = 'Something went wrong'});
}

class ImageNotSelectedException implements Exception {}

class ImageFileNotSupportedException implements Exception {}

class ImageSizeExceedsSizeLimitException implements Exception {
  ImageSizeExceedsSizeLimitException();
}

class StoragePermissionDeniedPermanently implements Exception {
  StoragePermissionDeniedPermanently({this.message});
  final String? message;
}

class StoragePermissionDenied implements Exception {
  StoragePermissionDenied({this.message});
  final String? message;
}

class CameraPermissionDeniedPermanently implements Exception {
  CameraPermissionDeniedPermanently({required this.message});
  final String message;
}

class CameraPermissionDenied implements Exception {
  CameraPermissionDenied({required this.message});
  final String message;
}

class LocationPermissionDenied implements Exception {
  final String message;

  LocationPermissionDenied({required this.message});
}

class LocationPermissionDeniedPermanently implements Exception {
  LocationPermissionDeniedPermanently({required this.message});
  final String message;
}
