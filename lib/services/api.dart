import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/services/loader.dart' as loader;
import 'package:pass_manager_frontend/services/settings.dart';

class ApiService {
  Future<Uri> _getServerUrl(String path) async {
    Uri url = await SettingsService.getServerUrl();
    return url.replace(path: path);
  }

  @protected
  Future<Map<String, String>> extendHeaders(Map<String, String> headers) async {
    headers = headers ?? {};
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";
    return headers;
  }

  Future<http.Response> handleResponse(http.Response response) {
    if (200 <= response.statusCode && response.statusCode < 300) {
      return Future.delayed(Duration(seconds: 0), () => response);
    } else if (response.statusCode == 401) {
      throw new exceptions.UnAuthenticatedException('Unauthenticated');
    } else if (response.statusCode == 500) {
      throw new exceptions.InternalServerErrorException(
          'Internal server error');
    } else {
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }

  Future<http.Response> get(String path, {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await http.Client().get(
          await _getServerUrl(path),
          headers: await extendHeaders(headers));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }

  Future<http.Response> post(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await http.Client().post(
          await _getServerUrl(path),
          body: json.encode(body),
          headers: await extendHeaders(headers));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }

  Future<http.Response> put(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await http.Client().put(
          await _getServerUrl(path),
          body: json.encode(body),
          headers: await extendHeaders(headers));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }

  Future<http.Response> patch(String path, body,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await http.Client().patch(
          await _getServerUrl(path),
          body: json.encode(body),
          headers: await extendHeaders(headers));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }

  Future<http.Response> delete(String path,
      {Map<String, String> headers}) async {
    try {
      loader.LoaderService.displayLoader();
      http.Response response = await http.Client().delete(
          await _getServerUrl(path),
          headers: await extendHeaders(headers));
      loader.LoaderService.hideLoader();
      return handleResponse(response);
    } on http.ClientException {
      loader.LoaderService.hideLoader();
      throw new exceptions.ApiException('Error when connecting to the server');
    }
  }
}
