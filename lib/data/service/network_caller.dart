import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ostad_tm/ui/controllers/auth_controller.dart';
import 'package:ostad_tm/ui/screens/sign_in_screen.dart';

import '../../app.dart';

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
  static const String _unAuthorizeMessage = "Un-Authorize token";

 static Future<NetworkResponse> getRequest({required String url}) async {
    try{
      Uri uri = Uri.parse(url);
      _logRequest(url, null , null);
      Response response = await get(uri);
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodedJson
        );
      } else if(response.statusCode == 401) {
        _onUnAuthorize();
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: _unAuthorizeMessage
        );
      }else {
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

 static Future<NetworkResponse> postRequest({required String url, Map<String, dynamic>? body, bool isFromLogin = false}) async {
    try{
      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        "content-type" : "application/json",
        "token" : AuthController.accessToken ?? ""
      };
      _logRequest(url, body, headers);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      _logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            body: decodedJson
        );
      }else if(response.statusCode == 401) {
        if(isFromLogin == false) {
          _onUnAuthorize();
        }
        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: _unAuthorizeMessage
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



static void _logRequest(String url , Map<String , dynamic> ? body,  Map<String , dynamic> ? headers){
     debugPrint("=============Request======================\n"
                "URL : $url"
                "headers  : $headers\n "
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

  static Future<void> _onUnAuthorize() async {
    await AuthController.clearData();
    Navigator.of(TaskManagerApp.navigator.currentContext!).pushNamedAndRemoveUntil(SignInScreen.name, (predicate)=> false);
  }


}