import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc_with_freezed_with_test/data/network/api_endpoint.dart';


class ApiHitter {
  static Dio? _dio;

  // ----------------------------- Dio Request Call ----------------------------

  Dio? getDio({String baseUrl = ''}) {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: baseUrl.isEmpty ? ApiEndPoint.baseUrl : baseUrl,
        connectTimeout: 30000,
        receiveTimeout: 30000,
      );
      return Dio(options)
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              return handler.next(options);
            },
            onResponse: (response, handler) {
              return handler.next(response);
            },
            onError: (DioError e, handler) async {
              debugPrint("onError method called");
               if (e.response?.statusCode != null &&
                  e.response?.statusCode == 401) {
                // const ChooseLanguagePage().navigate(isInfinity: true);
                // navigate to splash screen and logout...
                // bese method when server not working....
              } else {
                debugPrint("response in error :: ${e.toString()}");
                return handler.next(e);
              }
            },
          ),
        );
    } else {
      return _dio;
    }
  }

  // ------------------------------- Get Post API ------------------------------

  Future<ApiResponse> postApiResponse(String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String baseUrl = '',
  }) async {
    print("platformchecking");
    bool value= true;

    print("platformcheckingedddd");
    if (value) {
      try {
        var response = await getDio(baseUrl: baseUrl)!.post(
          endPoint,
          options: Options(
            headers: headers,
            contentType: "application/json",
          ),
          data: data,
        );
        return ApiResponse(
          response.statusCode == 200,
          response: response,
          msg: response.statusMessage,
        );
      } catch (error) {
        debugPrint("Exception :: ${error.toString()}");
        return exception(error);
      }
    } else {
      return ApiResponse(
        false,
        msg: "Check your internet connection and Please try again later.",
      );
    }
  }

  // ------------------------------- Get Put API -------------------------------

  Future<ApiResponse> putApiResponse(String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String baseUrl = '',
  }) async {
    bool value = true;

    if (value) {
      try {
        var response = await getDio(baseUrl: baseUrl)!.put(
          endPoint,
          options: Options(
            headers: headers,
            contentType: "application/json",
          ),
          data: data,
        );
        //debugPrint("Get put response :: ${response.statusMessage}");
        return ApiResponse(
          response.statusCode == 200,
          response: response,
          msg: response.statusMessage,
        );
      } catch (error) {
        return exception(error);
      }
    } else {
      return ApiResponse(
        false,
        msg: "Check your internet connection and Please try again later.",
      );
    }
  }

  // --------------------------------- Get API ---------------------------------

  Future<ApiResponse> getApiResponse(String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String baseUrl = '',
  }) async {
    bool value = true;

    if (value) {
      try {
        var response = await getDio(
          baseUrl: baseUrl,
        )!.get(
          endPoint,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType: "application/json",
          ),
        );
        //debugPrint("Get API response :: ${response.statusMessage}");
        return ApiResponse(
          response.statusCode == 200,
          response: response,
          msg: response.statusMessage,
        );
      } catch (error) {
        debugPrint("Error get API response :: $error");
        return exception(error);
      }
    } else {
      debugPrint("internet not connected ");
      return ApiResponse(
        false,
        msg: "Check your internet connection and Please try again later.",
      );
    }
  }

  // --------------------------------- Delete API ------------------------------

  Future<ApiResponse> deleteApiResponse(String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String baseUrl = '',
  }) async {
    bool value = true;

    if (value) {
      try {
        var response = await getDio(baseUrl: baseUrl)!.delete(
          endPoint,
          options: Options(
            headers: headers,
            contentType: "application/json",
          ),
          queryParameters: data,
        );
        return ApiResponse(
          response.statusCode == 200,
          response: response,
          msg: response.data["responseMessage"],
        );
      } catch (error) {
        return exception(error);
      }
    } else {
      return ApiResponse(
        false,
        msg: "Check your internet connection and Please try again later.",
      );
    }
  }

  // -------------------------------- Get Form API -----------------------------

  Future<ApiResponse> formApiResponse(String endPoint, {
    FormData? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String baseUrl = '',
  }) async {
    bool value = true;

    if (value) {
      try {
        var response = await getDio(baseUrl: baseUrl)!.post(
          endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType: "application/json",
          ),
        );
        debugPrint("url print $endPoint");
        //debugPrint("Response of form :: ${response.statusMessage}");
        return ApiResponse(
          response.statusCode == 200,
          response: response,
          msg: response.statusMessage,
        );
      } catch (error) {
        debugPrint("Error response of form :: $error");
        return exception(error);
      }
    } else {
      return ApiResponse(
        false,
        msg: "Check your internet connection and Please try again later.",
      );
    }
  }

  exception(error) {
    try {
      debugPrint("response  get in exception " + error.toString());
      return ApiResponse(
        false,
        msg:
        "${error?.response?.data['message'] ?? "Sorry Something went wrong."}",
      );
    } catch (e) {
      if (DioErrorType.other == error.type ||
          DioErrorType.receiveTimeout == error.type ||
          DioErrorType.connectTimeout == error.type) {
        debugPrint("error msg" + error.toString());
        if (error.message.contains('SocketException')) {
          return ApiResponse(
            false,
            msg: "Check your internet connection and Please try again later.",
          );
        }
      } else {
        return ApiResponse(false, msg: "Sorry Something went wrong.");
      }
    }
  }
}

// -----------------------------------------------------------------------------

class ApiResponse {
  final bool status;
  final String? msg;
  final Response? response;

  ApiResponse(this.status, {
    this.msg = "Success",
    this.response,
  });
}
