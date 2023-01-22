import 'package:bloc_with_freezed_with_test/data/model/login_model/login_response.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_response.dart';
import 'package:bloc_with_freezed_with_test/data/model/login_model/login_response.dart';
import 'package:bloc_with_freezed_with_test/data/network/api_endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../network/ApiHitter.dart';


class AuthenticationRepo {
  final int interErrorCode = 12004;
  final apiHitter = ApiHitter();



  Future<Login_response>  login_apiAPI(
      Map<String, dynamic> userRequest,
      ) async {
    var response = await apiHitter.postApiResponse(
      ApiEndPoint.login_api,
      baseUrl: ApiEndPoint.baseUrl,
      data: userRequest,
    );
    if (response.status) {
      return Login_response.fromJson(response.response!.data);
    } else {
      return Login_response();
    }
  }



}
