import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class NetworkResponse{
  final bool isSuccess;
  final Map<String , dynamic>? body;
  final int statusCode;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.body,
    this.errorMessage
});
}


class NetworkCaller {
  static const String _defaultErrorMessage = "Something Went Wrong";

 static Future<NetworkResponse> getRequest({required String url}) async {
    try{
      Uri uri = Uri.parse(url);
      _logRequest(url, null);
      Response response = await get(uri);
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodedJson
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            body: decodedJson["data"] ?? _defaultErrorMessage
        );
      }
    }catch(e){
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: e.toString()
      );
    }
  }

 static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body}) async {
    try{
      Uri uri = Uri.parse(url);
      _logRequest(url, body);
      Response response = await post(
        uri,
        body: jsonEncode(body),
        headers: {
          "content-type" : "application/json"
        }
      );
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodedJson
        );
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            body: decodedJson["data"] ?? _defaultErrorMessage
        );
      }
    }catch(e){
      return NetworkResponse(
          isSuccess: false,
          statusCode: -1,
          errorMessage: e.toString()
      );
    }
  }



static void _logRequest(String url , Map<String , dynamic> ? body){
     debugPrint("=============Request======================\n"
                "URL : $url"
                "BODY  : $body\n "
         "========================================================\n"
     );
   }
static  void _logResponse(String url , Response response){
    debugPrint("=============Response======================\n"
        "URL : $url"
    "StatusCode : ${response.statusCode}\n"
        "BODY  : ${response.body}\n "
        "========================================================"
    );
  }


}