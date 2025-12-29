import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/src/response.dart' as dioResp;

class CustomApi {
  static Map<String, String> headers = {'Content-Type': 'application/json'};
  static String userToken = '';
  static Map<String, String> get authorizedHeaders {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${userToken}'
    };
  }

  static Future<String?> SpeedApi(
      {bool isPost = false,
      String? customBaseUrl,
      required String path,
      Function(int?)? statusCode,
      bool test = true,
      bool secondBaseUrl = false,
      Map<String, dynamic>? bodyParameters,
      Map<String, dynamic>? urlParameters,
      String? baseUrl2}) async {
    Dio http = Dio();
    Uri domain = Uri.parse(customBaseUrl ?? (baseUrl2!));
    Uri uri = Uri();
    if (domain.scheme == 'https')
      uri = Uri.https(domain.host, domain.path + path, urlParameters ?? {});
    else
      uri = Uri.http(domain.host, domain.path + path, urlParameters ?? {});

    try {
      debugPrint('SpeedApi URL : $uri');
      if (bodyParameters != null)
        debugPrint('SpeedApi Parameters Body : $bodyParameters');
      if (bodyParameters != urlParameters)
        debugPrint('SpeedApi Parameters Url: $urlParameters');

      var body = jsonEncode(bodyParameters);
      var headers = authorizedHeaders;
      var request = await http
          .request(
            uri.toString(),
            cancelToken: CancelToken(),
            data: isPost ? body : null,
            options: Options(headers: headers, method: isPost ? 'POST' : 'GET'),
          )
          .onError((error, stackTrace) =>
              dioResp.Response(requestOptions: RequestOptions(path: 'path')));

      if (statusCode != null) statusCode(request.statusCode);
      if (request.statusCode == 200) {
        String res = json.encode(await request.data).toString();
        debugPrint("SpeedApi Response : " + res);
        if (test)
          // await insertApiTestSupport(
          //     apiUrl: uri.toString(),
          //     isPost: isPost,
          //     statusCode: request.statusCode.toString(),
          //     urlParameters: urlParameters,
          //     bodyParameters: bodyParameters,
          //     response: res);
          return res;
      } else {
        debugPrint(request.statusMessage.toString());
        if (test)
          // await insertApiTestSupport(
          //     apiUrl: uri.toString(),
          //     isPost: isPost,
          //     urlParameters: urlParameters,
          //     bodyParameters: bodyParameters,
          //     statusCode: request.statusCode.toString(),
          //     response: request.statusMessage.toString());
          return 'somethingWentWrong'.tr;
      }
    } catch (e) {
      if (test)
        // await insertApiTestSupport(
        //     apiUrl: uri.toString(),
        //     isPost: isPost,
        //     urlParameters: urlParameters,
        //     bodyParameters: bodyParameters,
        //     statusCode:
        //         'Error until calling api , please Recheck from mobile side',
        //     response: e.toString());
        debugPrint('SpeedApi error:$e');
      return 'somethingWentWrong'.tr;
    }
  }

  static Future<String?> SpeedApi2(
      {bool isPost = false,
      String? customBaseUrl,
      required String path,
      Function(int?)? statusCode,
      bool test = true,
      bool secondBaseUrl = false,
      Map<String, dynamic>? bodyParameters,
      Map<String, dynamic>? urlParameters,
      String? baseUrl2}) async {
    Dio http = Dio();
    Uri domain = Uri.parse(customBaseUrl ?? baseUrl2!);
    Uri uri = Uri();
    if (domain.scheme == 'https')
      uri = Uri.https(domain.host, domain.path + path, urlParameters ?? {});
    else
      uri = Uri.http(domain.host, domain.path + path, urlParameters ?? {});

    try {
      debugPrint('SpeedApi URL : $uri');
      if (bodyParameters != null)
        debugPrint('SpeedApi Parameters Body : $bodyParameters');
      if (bodyParameters != urlParameters)
        debugPrint('SpeedApi Parameters Url: $urlParameters');

      var body = jsonEncode(bodyParameters);
      var headers = authorizedHeaders;
      var request = await http.request(
        uri.toString(),
        cancelToken: CancelToken(),
        data: isPost ? body : null,
        options: Options(headers: headers, method: isPost ? 'POST' : 'GET'),
      );

      if (statusCode != null) statusCode(request.statusCode);
      if (request.statusCode == 200) {
        String res = json.encode(await request.data).toString();
        debugPrint("SpeedApi Response : " + res);
        if (test)
          // await insertApiTestSupport(
          //     apiUrl: uri.toString(),
          //     isPost: isPost,
          //     statusCode: request.statusCode.toString(),
          //     urlParameters: urlParameters,
          //     bodyParameters: bodyParameters,
          //     response: res);
          return res;
      } else {
        debugPrint(request.statusMessage.toString());
        if (test)
          // await insertApiTestSupport(
          //     apiUrl: uri.toString(),
          //     isPost: isPost,
          //     urlParameters: urlParameters,
          //     bodyParameters: bodyParameters,
          //     statusCode: request.statusCode.toString(),
          //     response: request.statusMessage.toString());
          return 'error${request.statusCode}';
      }
    } catch (e) {
      if (test)
        // await insertApiTestSupport(
        //     apiUrl: uri.toString(),
        //     isPost: isPost,
        //     urlParameters: urlParameters,
        //     bodyParameters: bodyParameters,
        //     statusCode:
        //         'Error until calling api , please Recheck from mobile side',
        //     response: e.toString());
        debugPrint('SpeedApi error:$e');
      return 'error';
    }
  }
}

// Future insertApiTestSupport({
//   String? apiUrl,
//   bool? isPost,
//   String? response = 'error',
//   String? statusCode,
//   Map<String, dynamic>? urlParameters,
//   Map<String, dynamic>? bodyParameters,
// }) async {
//   try {
//     if (Main.apiTest) {
//       Dio http = Dio();
//       Map<String, dynamic> map = {
//         'School': Main.currentSchool!.name ?? '',
//         'Api': apiUrl ?? '',
//         'Token': '${AuthController.userToken ?? ''}',
//         'MobileAppBlockName':
//             '${GeneralController.read(NavigatorKey.instance.currentContext!).initBlockName ?? 'MainApi(onLogin)'}',
//         'Method': (isPost! ? 'POST' : 'GET') ?? '',
//         if (urlParameters != null && urlParameters.isNotEmpty)
//           'UrlParameters': urlParameters ?? '',
//         if (bodyParameters != null && bodyParameters.isNotEmpty)
//           'BodyParameters': bodyParameters ?? '',
//         'StatusCode': statusCode,
//         if (response != null && response.isNotEmpty)
//           'Response': json.decode(response) ?? [],
//       };

//       try {
//         var request = await http.patch(
//             "https://apisupport-2e69b-default-rtdb.firebaseio.com/Apis/${map.hashCode}.json",
//             data: json.encode(map),
//             options: Options(headers: {'Content-Type': 'application/json'}));
//         if (request.statusCode == 200) {
//           return request.data.toString();
//         } else {
//           debugPrint(request.statusMessage.toString());
//           return null;
//         }
//       } catch (e) {
//         debugPrint('CustomApi insertApiTestSupport error:$e');
//         return null;
//       }
//     }
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }

//http
// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
//
// import 'endpoints.dart';
//
// class CustomApi {
//   static Future<dynamic> SpeedApi({
//     @required bool isPost,
//     @required String path,
//     Map<String, dynamic> bodyParameters,
//     Map<String, dynamic> urlParameters,
//   }) async {
//     try {
//       Uri uri = Uri();
//       if (Endpoints.baseUrl.contains('https'))
//         uri = Uri.https(
//             Endpoints.baseUrl.replaceAll('https://', '').replaceAll('/api', ''),
//             "/api" + path,
//             urlParameters);
//       else
//         uri = Uri.http(
//             Endpoints.baseUrl.replaceAll('http://', '').replaceAll('/api', ''),
//             "/api" + path,
//             urlParameters);
//
//       debugPrint('SpeedApi URL : $uri');
//       var request = http.Request(isPost ? 'POST' : 'GET', uri);
//       request.headers.addAll(Endpoints.authorizedHeaders);
//       if (isPost) {
//         request.body = jsonEncode(bodyParameters);
//         debugPrint('SpeedApi Parameters : $bodyParameters');
//       } else
//         debugPrint('SpeedApi Parameters : $urlParameters');
//
//       http.StreamedResponse response = await request.send();
//
//       if (response.statusCode == 200) {
//         return await response.stream.bytesToString();
//       } else {
//         debugPrint(response.reasonPhrase);
//         return null;
//       }
//     } catch (e) {
//       debugPrint('SpeedApi error:$e');
//       return null;
//     }
//   }
// }
