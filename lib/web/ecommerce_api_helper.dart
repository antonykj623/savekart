
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

import 'AppStorage.dart';


String imagePath = 'https://eduklader.com/public/assets/uploads/user-images/';

class EcommerceApiHelper  {
  static const _baseUrl = 'https://mysaving.in/IntegraAccount/ecommerce_api/';

  static const baseUrldata = 'https://mysaving.in/IntegraAccount/ecommerce_api/';

  static const categoryimageurl="https://mysaving.in/cart/category/";
  static const brandimageurl="https://mysaving.in/cart/brand/";

  static const productimageurl="https://mysaving.in/cart/";
  static const returnproductimagesurl="https://mysaving.in/cart/returnproductimages/";

  String sessionTimedOutMessage = 'Server is taking too long to respond';

  final int timeoutDuration = 40;

  static double totalamount=0;

  static String getTimeStamp()
  {
    var date = DateTime.now().toIso8601String();
    return date.toString();
  }




  
  
  
  
  
  

  Future<dynamic> get(String endpoint,
      {bool showLoadingDialog = false,
        bool isV5 = false,
        bool showErrorDialog = true}) async {
    try {
      String url = (endpoint.startsWith(_baseUrl) ? '' : _baseUrl) + endpoint;
      String? token= await AppStorage.getString(AppStorage.token);
      Map<String, String> headers = {"Authorization" : token.toString()};



      _logRequest('GET', url, headers);

      http.Response response = await http.get(Uri.parse(url), headers: headers);



      _logResponse('GET', url, headers, response);

      return _processResponse(response, showErrorDialog: showErrorDialog);
    } on SocketException {
      // if (showLoadingDialog) AppDialogs.closeDialog();
      // if (showErrorDialog) {
      //   throw FetchDataException('No Internet connection');
      // }
    } on TimeoutException {
      // if (showLoadingDialog) AppDialogs.closeDialog();
      // if (showErrorDialog) {
      //   throw ApiNotRespondingException(sessionTimedOutMessage);
      // }
    }
  }

  Future<dynamic> post(endpoint,
      {dynamic jsonPayload,
        Map<String, String>? formDataPayload,
        Map<String, dynamic> formDataFiles = const {},
        bool showLoadingDialog = false,
        bool? urlV5,
        bool showErrorDialog = true}) async {
    // assert((jsonPayload == null && formDataPayload != null) ||
    //     (jsonPayload != null && formDataPayload == null));

    try {
      String url = (endpoint.startsWith(_baseUrl) ? '' : _baseUrl) + endpoint;
      // String token = (await AppStorage.getValue(AppStorage.token)) ?? '';
      String? token= await AppStorage.getString(AppStorage.token);
      Map<String, String> headers = {"Authorization" : token.toString()};

      http.Response response;
      // if (showLoadingDialog) AppDialogs.showLoadingDialog();

      if (jsonPayload != null) {
        headers = {
          'Content-type': 'application/json',

        };
        _logRequest('POST', url, headers,
            jsonPayload: jsonPayload,
            formDataPayload: formDataPayload,
            formDataFiles: formDataFiles);

        response = await http
            .post(Uri.parse(url),
            headers: headers, body: json.encode(jsonPayload))
            .timeout(Duration(seconds: timeoutDuration));
      } else if (formDataPayload != null) {
        // headers = {
        //   'Content-type': 'multipart/form-data;',
        //   'Authorization': 'Bearer $token'
        // };

        _logRequest('POST', url, headers,
            jsonPayload: jsonPayload,
            formDataPayload: formDataPayload,
            formDataFiles: formDataFiles);

        dio.FormData formData = dio.FormData();

        if (formDataFiles.isNotEmpty) {
          formDataFiles.forEach((key, value) async {
            if (value is List) {
              List<String> list = [];
              for (int i = 0; i < value.length; i++) {
                if (value.isNotEmpty) {
                  list.add(value[i]);
                }
              }

              formData.files.addAll(list.map(
                      (e) => MapEntry(key, dio.MultipartFile.fromFileSync(e))));
            } else {
              formData.files
                  .add(MapEntry(key, dio.MultipartFile.fromFileSync(value)));
            }
          });
        }
        formData.fields.addAll(formDataPayload.entries);

        var res = await dio.Dio().post(
          url,
          options: dio.Options(validateStatus: (_) => true, headers: headers),
          data: formData,
          onSendProgress: (received, total) {
            // print('send:${(received / total * 100).toStringAsFixed(1)}%');
          },
        );
        response = http.Response(json.encode(res.data), res.statusCode ?? 0);
      } else {
        _logRequest('POST', url, headers,
            jsonPayload: jsonPayload,
            formDataPayload: formDataPayload,
            formDataFiles: formDataFiles);

        headers = {};
        var res = await dio.Dio().post(
          url,
          options: dio.Options(validateStatus: (_) => true, headers: headers),
          onSendProgress: (received, total) {
            // print('send:${(received / total * 100).toStringAsFixed(1)}%');
          },
        );
        response = http.Response(json.encode(res.data), res.statusCode ?? 0);
      }
      // if (showLoadingDialog) AppDialogs.closeDialog();

      _logResponse('POST', url, headers, response,
          jsonPayload: jsonPayload,
          formDataPayload: formDataPayload,
          formDataFiles: formDataFiles);



      return _processResponse(response, showErrorDialog: showErrorDialog);
    } on SocketException {
      // if (showLoadingDialog) AppDialogs.closeDialog();
      // if (showErrorDialog) {
      //   throw FetchDataException('No Internet connection');
      // }
    } on TimeoutException {
      // if (showLoadingDialog) AppDialogs.closeDialog();
      // if (showErrorDialog) {
      //   throw ApiNotRespondingException(sessionTimedOutMessage);
      // }
    } catch (e, s) {
      // Completer().completeError(e, s);
      // if (showLoadingDialog) AppDialogs.closeDialog();
    }
  }


  Future<String> postMark(endpoint,dynamic requestModel,String method) async {
    // assert((jsonPayload == null && formDataPayload != null) ||
    //     (jsonPayload != null && formDataPayload == null));
    String data = "",token="";
    try {


      String serverurl = (endpoint.startsWith(_baseUrl) ? '' : _baseUrl) + endpoint;

      token = "";

      var url = Uri.parse(serverurl);
      dynamic response = await http.post(url, headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': "Bearer " + token
      }, body: {
        "exam_id":"1",
        "class_id":26,
        "section_id":30,
        "exam_category_id":7,
        "subject_id":12,
        "student_id":113,
        "session_id":30,
        "marks":80,
        "comment":"Nice"


      } );
      if (response.statusCode == 201) {
        data = response.body.toString();
      } else {
        throw Exception("Failed to Data");
      }
    }
    catch (e, s) {
      print(e.toString());

    }

    // try {
    //   String url = (endpoint.startsWith(_baseUrl) ? '' : _baseUrl) + endpoint;
    //   String token = (await AppStorage.getValue(AppStorage.token)) ?? '';
    //   Map<String, String> headers = {};
    //
    //   http.Response response;
    //   if (showLoadingDialog) AppDialogs.showLoadingDialog();
    //
    //   if (jsonPayload != null) {
    //     headers = {
    //       'Content-type': 'application/json',
    //       'Authorization': 'Bearer $token'
    //     };
    //
    //     print("POST "+jsonPayload.toString()+" ");
    //
    //     // _logRequest('POST', url, headers,
    //     //     jsonPayload: jsonPayload,
    //     //     formDataPayload: dynamic,
    //     //     formDataFiles: formDataFiles);
    //
    //     response = await http
    //         .post(Uri.parse(url),
    //         headers: headers, body: json.encode(jsonPayload))
    //         .timeout(Duration(seconds: timeoutDuration));
    //   }
    //
    //   else if (formDataPayload != null) {
    //     headers = {
    //       'Content-type': 'multipart/form-data;',
    //       'Authorization': 'Bearer $token'
    //     };
    //
    //     // _logRequest('POST', url, headers,
    //     //     jsonPayload: jsonPayload,
    //     //     formDataPayload: formDataPayload,
    //     //     formDataFiles: formDataFiles);
    //
    //     dio.FormData formData = dio.FormData();
    //
    //     if (formDataFiles.isNotEmpty) {
    //       formDataFiles.forEach((key, value) async {
    //         if (value is List) {
    //           List<String> list = [];
    //           for (int i = 0; i < value.length; i++) {
    //             if (value.isNotEmpty) {
    //               list.add(value[i]);
    //             }
    //           }
    //
    //           formData.files.addAll(list.map(
    //                   (e) => MapEntry(key, dio.MultipartFile.fromFileSync(e))));
    //         } else {
    //           formData.files
    //               .add(MapEntry(key, dio.MultipartFile.fromFileSync(value)));
    //         }
    //       });
    //     }
    //     // formData.fields.addAll(formDataPayload.entries);
    //
    //     var res = await dio.Dio().post(
    //       url,
    //       options: dio.Options(validateStatus: (_) => true, headers: headers),
    //       data: formData,
    //       onSendProgress: (received, total) {
    //         // print('send:${(received / total * 100).toStringAsFixed(1)}%');
    //       },
    //     );
    //     response = http.Response(json.encode(res.data), res.statusCode ?? 0);
    //   } else {
    //     _logRequest('POST', url, headers,
    //         jsonPayload: jsonPayload,
    //         formDataPayload: formDataPayload,
    //         formDataFiles: formDataFiles);
    //
    //     headers = {'Authorization': 'Bearer $token'};
    //     var res = await dio.Dio().post(
    //       url,
    //       options: dio.Options(validateStatus: (_) => true, headers: headers),
    //       onSendProgress: (received, total) {
    //         // print('send:${(received / total * 100).toStringAsFixed(1)}%');
    //       },
    //     );
    //     response = http.Response(json.encode(res.data), res.statusCode ?? 0);
    //   }
    //   if (showLoadingDialog) AppDialogs.closeDialog();
    //
    //   _logResponse('POST', url, headers, response,
    //       jsonPayload: jsonPayload,
    //       formDataPayload: formDataPayload,
    //       formDataFiles: formDataFiles);
    //   return _processResponse(response, showErrorDialog: showErrorDialog);
    // } on SocketException {
    //   if (showLoadingDialog) AppDialogs.closeDialog();
    //   if (showErrorDialog) {
    //     throw FetchDataException('No Internet connection');
    //   }
    // } on TimeoutException {
    //   if (showLoadingDialog) AppDialogs.closeDialog();
    //   if (showErrorDialog) {
    //     throw ApiNotRespondingException(sessionTimedOutMessage);
    //   }
    // } catch (e, s) {
    //   Completer().completeError(e, s);
    //   if (showLoadingDialog) AppDialogs.closeDialog();
    // }

    return data;
  }



  Future<String?> postAttendance(endpoint,dynamic requestModel,String method) async {


    String data="";

    String serverurl = (endpoint.startsWith(_baseUrl) ? '' : _baseUrl) + endpoint;

    String token =  '';

    var url = Uri.parse(serverurl);
    final response = await http.post(url, headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'Authorization':"Bearer "+ token
    }, body: requestModel);
    if (response.statusCode == 201 ) {


      data=response.body.toString();


    } else {
      throw Exception("Failed to Data");
    }



    return data;
  }










  dynamic _processResponse(http.Response response,
      {bool showErrorDialog = true}) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
      case 400:
        String? msg;
        try {
          Map map = json.decode(utf8.decode(response.bodyBytes));
          if (map.containsKey('current_password') &&
              map['current_password'].isNotEmpty) {
            //user profile reset password
            msg = map['current_password'][0];
          } else if (map.containsKey('non_field_errors') &&
              map['non_field_errors'].isNotEmpty) {
            //user profile reset password
            msg = map['non_field_errors'][0];
          }
          else if (map.containsKey('message') &&
              map['message'].isNotEmpty) {
            //user profile reset password
            msg = map['message'][0];

          }
        } catch (e, s) {
          // Completer().completeError(e, s);
        }
    // if (showErrorDialog) {
    //   throw BadRequestException(msg ??
    //       'Server cannot or will not process the request due to something that is perceived to be a client error');
    // }
      case 401:
        Map map = json.decode(utf8.decode(response.bodyBytes));
    // throw UnAuthorizedException(
    //   map['message'] ?? 'Session expired! Please login to continue',
    // );
      case 403:
        try {
          Map map = json.decode(utf8.decode(response.bodyBytes));
          // if (map.containsKey('message')) {
          //   AppMessage.toast(map['message']);
          //   return map;
          // }
        } catch (e, s) {
          Completer().completeError(e, s);
        }

    // throw UnAuthorizedException(
    //   'Session expired! Please login to continue',
    // );

    // throw AppMessage.simpleSnackBarMessage(
    //     'You are not authorised to perform this action',
    //     duration: SnackBarDuration.short);
      case 404:
        String? msg;
        try {
          Map map = json.decode(utf8.decode(response.bodyBytes));
          if (map.containsKey('msg')) {
            msg = map['msg'];
          }
        } catch (e, s) {
          Completer().completeError(e, s);
        }
        if (showErrorDialog) {
          // throw NotFoundException(msg ?? 'Requested resource is missing');
        }
      case 422:
        if (showErrorDialog) {
          // throw BadRequestException('Unable to process the request');
        }
    // case 424:
    // var responseJson = utf8.decode(response.bodyBytes);
    // return responseJson;
    // String? msg;
    // try {
    //   Map map = json.decode(utf8.decode(response.bodyBytes));
    //   if (map.containsKey('msg')) {
    //     msg = map['msg'];
    //   }
    // } catch (e, s) {
    //   Completer().completeError(e, s);
    // }
    // throw NotFoundException(msg ?? 'Unable to process the request');
      case 500:
      default:
        String? msg;
        try {
          Map map = json.decode(utf8.decode(response.bodyBytes));
          if (map.containsKey('detail')) {
            msg = map['detail'];
          }
        } catch (e, s) {
          Completer().completeError(e, s);
        }
        if (msg != null) {
          if (showErrorDialog) {
            // throw FetchDataException(msg
            //     // ?? 'Server encountered an unexpected condition that prevented it from fulfilling the request'
            //     );
          }
        }
    }
  }

  _logRequest(
      String method,
      String url,
      Map<String, String> headers, {
        dynamic jsonPayload,
        Map<String, String>? formDataPayload,
        Map<String, dynamic> formDataFiles = const {},
      }) {
    try {
      String msg = '';

      msg += '\n=======REQUEST-$method=========BEGIN========================\n';
      msg += '[URL] :$url\n';
      msg += '[HEADERS] :${json.encode(headers)}\n';
      if (jsonPayload != null) {
        msg += '[JSON_PAYLOAD] :${json.encode(jsonPayload)}\n';
      }
      if ((formDataPayload ?? {}).isNotEmpty) {
        msg += '[FORM_DATA_PAYLOAD] :${json.encode(formDataPayload)}\n';
      }
      if (formDataFiles.isNotEmpty) {
        msg += '[FORM_DATA_FILES] :${json.encode(formDataFiles)}\n';
      }
      msg += '=======REQUEST-$method=========END==========================\n';

      log(msg);
    } catch (e, s) {
      Completer().completeError(e, s);
    }
  }



  _logResponse(
      String method,
      String url,
      Map<String, String> headers,
      http.Response response, {
        dynamic jsonPayload,
        Map<String, String>? formDataPayload,
        Map<String, dynamic> formDataFiles = const {},
      }) {
    String msg = '';
    msg += '=======RESPONSE-$method==========BEGIN======================\n';
    msg += '[URL] :$url\n';
    msg += '[HEADERS] :${json.encode(headers)}\n';
    if (jsonPayload != null) {
      msg += '[JSON_PAYLOAD] :${json.encode(jsonPayload)}\n';
    }
    if ((formDataPayload ?? {}).isNotEmpty) {
      msg += '[FORM_DATA_PAYLOAD] :${json.encode(formDataPayload)}\n';
    }
    if (formDataFiles.isNotEmpty) {
      msg += '[FORM_DATA_FILES] :${json.encode(formDataFiles)}\n';
    }
    msg += '[RESPONSE_CODE] :${response.statusCode}\n';
    msg += '[RESPONSE_BODY] :${response.body.toString()}\n';
    msg += '=======RESPONSE-$method==========END========================\n';
    log(msg);
  }
}
