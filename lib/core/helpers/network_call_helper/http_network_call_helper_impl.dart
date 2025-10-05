import 'dart:convert';
import 'dart:io';

import 'package:moviedb_task/core/helpers/network_call_helper/network_call_helper.dart';
import 'package:moviedb_task/core/utils/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@LazySingleton(as: NetworkCallHelper)
class HttpNetworkCallHelperImpl implements NetworkCallHelper {
  final Logger logger;

  HttpNetworkCallHelperImpl({required this.logger});

  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    try {
      if (params != null) {
        final query = params.entries
            .where((element) => element.value != null)
            .map((e) => '${e.key}=${e.value}')
            .join('&');
        url = '$url?$query';
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', ...?headers},
      );

      final statusCode = response.statusCode;
      if (statusCode == 200) {
        final body = response.body;
        final jsonBody = json.decode(body);

        return jsonBody as Map<String, dynamic>;
      } else {
        if (json.decode(response.body)['message'] != null) {
          throw MessageException(
            message: json.decode(response.body)['message'] as String,
          );
        }
        throw HttpException('Failed with status code $statusCode');
      }
    } catch (e) {
      logger.e("Error $e");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      logger.i(body);
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json', ...?headers},
      );
      logger.i(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        // Successful response
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException('Failed with status code $statusCode');
      }
    } catch (e) {
      logger.e("Error $e");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> multipart(
    String url, {
    List<String>? filePaths,
    String? filesParam,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));

      if (filePaths != null && filePaths.isNotEmpty) {
        assert(filesParam != null);
        for (final path in filePaths) {
          if (path.isEmpty) {
            continue;
          }
          request.files.add(
            await http.MultipartFile.fromPath(filesParam!, path),
          );
        }
      }

      request.headers.addAll({'Content-Type': 'application/json', ...?headers});

      final data = body?.entries
          .where((element) => element.value != null)
          .map((entry) => MapEntry(entry.key, entry.value.toString()))
          .toList();

      logger.i(data);
      request.fields.addAll({...Map.fromEntries(data ?? [])});
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      logger.i(responseBody);
      return json.decode(responseBody) as Map<String, dynamic>;
    } catch (e) {
      logger.e("Error $e");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> delete(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json', ...?headers},
        body: json.encode(body), // Convert body to JSON string
      );

      logger.i(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        // Successful response
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException('Failed with status code $statusCode');
      }
    } catch (e) {
      logger.e("Error $e");
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> put(
    String url,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    try {
      logger.i(body);
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json', ...?headers},
      );
      logger.i(response.body);
      final statusCode = response.statusCode;
      if (statusCode == 200 || statusCode == 422) {
        // Successful response
        return json.decode(response.body) as Map<String, dynamic>;
      } else {
        throw HttpException('Failed with status code $statusCode');
      }
    } catch (e) {
      logger.e("Error $e");
      rethrow;
    }
  }
}
