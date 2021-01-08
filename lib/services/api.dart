import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/services/interceptors.dart';
import 'package:pass_manager_frontend/services/loader.dart' as loader;
import 'package:pass_manager_frontend/services/settings.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;

// TODO: Use the Dio package
// https://pub.dev/packages/dio
class ApiService {
  http.Client client = HttpClientWithInterceptor.build(interceptors: [
    ContentTypeJsonInterceptor(),
  ], requestTimeout: constants.requestTimeout);

  Future<Uri> _getServerUrl(String path) async {
    Uri url = await SettingsService.getServerUrl();
    return url.replace(path: path);
  }

  Future<http.Response> handleResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return Future.delayed(Duration(seconds: 0), () => response);
    } else if (response.statusCode == 401) {
      return new Future.error(
          exceptions.UnAuthenticatedException('Unauthenticated'));
    } else if (response.statusCode == 500) {
      return new Future.error(
          exceptions.InternalServerErrorException('Internal server error'));
    } else {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }

  Future<http.Response> get(String path, {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await client.get(await _getServerUrl(path));
      return handleResponse(response);
    } on SocketException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: wrong port number or no internet connection'));
    } on FormatException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: invalid hostname or IP address set'));
    } on TimeoutException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Cause: Request timeout'));
    } catch (e) {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    } finally {
      loader.LoaderService.hideLoader();
    }
  }

  Future<http.Response> post(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response =
          await client.post(await _getServerUrl(path), body: json.encode(body));
      return handleResponse(response);
    } on SocketException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: wrong port number, no internet connection'));
    } on FormatException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: invalid hostname or IP address set'));
    } on TimeoutException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Cause: Request timeout'));
    } catch (e) {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    } finally {
      loader.LoaderService.hideLoader();
    }
  }

  Future<http.Response> put(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response =
          await client.put(await _getServerUrl(path), body: json.encode(body));
      return handleResponse(response);
    } on SocketException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: wrong port number or no internet connection'));
    } on FormatException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: invalid hostname or IP address set'));
    } on TimeoutException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Cause: Request timeout'));
    } catch (e) {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    } finally {
      loader.LoaderService.hideLoader();
    }
  }

  Future<http.Response> patch(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await client.patch(await _getServerUrl(path),
          body: json.encode(body));
      return handleResponse(response);
    } on SocketException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: wrong port number or no internet connection'));
    } on FormatException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: invalid hostname or IP address set'));
    } on TimeoutException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Cause: Request timeout'));
    } catch (e) {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    } finally {
      loader.LoaderService.hideLoader();
    }
  }

  Future<http.Response> delete(String path,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await client.delete(await _getServerUrl(path));
      return handleResponse(response);
    } on SocketException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: wrong port number or no internet connection'));
    } on FormatException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Possible causes: invalid hostname or IP address set'));
    } on TimeoutException {
      return new Future.error(exceptions.ApiException(
          'Error when connecting to the server. Cause: Request timeout'));
    } catch (e) {
      return new Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    } finally {
      loader.LoaderService.hideLoader();
    }
  }
}
