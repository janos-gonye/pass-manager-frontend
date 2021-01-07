import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/services/interceptors.dart';
import 'package:pass_manager_frontend/services/loader.dart' as loader;
import 'package:pass_manager_frontend/services/settings.dart';

class ApiService {
  http.Client client = HttpClientWithInterceptor.build(interceptors: [
    ContentTypeJsonInterceptor(),
  ]);

  Future<Uri> _getServerUrl(String path) async {
    Uri url = await SettingsService.getServerUrl();
    return url.replace(path: path);
  }

  Future<http.Response> handleResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return Future.delayed(Duration(seconds: 0), () => response);
    } else if (response.statusCode == 401) {
      return Future.error(
          exceptions.UnAuthenticatedException('Unauthenticated'));
    } else if (response.statusCode == 500) {
      return Future.error(
          exceptions.InternalServerErrorException('Internal server error'));
    } else {
      return Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }

  Future<http.Response> get(String path, {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await client.get(await _getServerUrl(path));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      return Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }

  Future<http.Response> post(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response =
          await client.post(await _getServerUrl(path), body: json.encode(body));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      return Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }

  Future<http.Response> put(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response =
          await client.put(await _getServerUrl(path), body: json.encode(body));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      return Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }

  Future<http.Response> patch(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await client.patch(await _getServerUrl(path),
          body: json.encode(body));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      return Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }

  Future<http.Response> delete(String path,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await client.delete(await _getServerUrl(path));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      return Future.error(
          exceptions.ApiException('Error when connecting to the server'));
    }
  }
}
