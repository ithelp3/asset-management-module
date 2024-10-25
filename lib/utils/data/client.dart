import 'package:asset_management_module/utils/data/nav_key.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: '${dotenv.env['BASE_SOCKET_URL']}/api'
    )
  )
    ..interceptors.add(LogInterceptor(
    logPrint: (o) => debugPrint(o.toString()),
  ),);

  Options options = Options(
    contentType: 'application/json',
    headers: {
      'Accept': 'application/json',
      'Authorization': (NavKey.user == null)
          ? 'Bearer Elrumi2024'
          : 'Bearer ${NavKey.user!.token}'
    }
  );

  Future post(
    String uri, {
      dynamic data,
      Map<String, dynamic>? params,
      // Options? options,
  }) async {
    try{
      final response = await dio.post(
        uri,
        data: data,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } catch(err) {
      return {'success': false};

    }
  }

  Future get(
    String uri, {
      Map<String, dynamic>? data,
      Map<String, dynamic>? params,
      CancelToken? cancelToken,
  }) async {
    try{
      final response = await dio.get(
        uri,
        data: data,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future put(
    String uri, {
      dynamic data,
      // Options? options,
    }) async {
    try{
      final response = await dio.put(
        uri,
        data: data,
        options: options,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future delete(
    String uri, {
      dynamic data,
      // Options? options,
    }) async {
    try{
      final response = await dio.delete(
        uri,
        data: data,
        options: options,
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }
}