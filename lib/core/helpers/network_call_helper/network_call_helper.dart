abstract class NetworkCallHelper {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  });

  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  });

  Future<Map<String, dynamic>> multipart(
    String url, {
    List<String>? filePaths,
    String? filesParam,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
}
