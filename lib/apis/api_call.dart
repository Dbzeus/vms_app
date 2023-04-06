import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:vms_app/apis/urls.dart';
import 'package:vms_app/helper/utils.dart';
import 'package:vms_app/main.dart';
import 'package:vms_app/model/approver_list_response.dart';
import 'package:vms_app/model/host_dashboard_response.dart';
import 'package:vms_app/model/host_visitor_response.dart';
import 'package:vms_app/model/insert_appointment.dart';
import 'package:vms_app/model/insert_visitor.dart';
import 'package:vms_app/model/login_response.dart';
import 'package:vms_app/model/search_visitor_response.dart';
import 'package:vms_app/model/visitor_response.dart';

class ApiCall {
  static final ApiCall _instance = ApiCall._internal();

  static final Dio _dio = Dio();

  factory ApiCall() {
    return _instance;
  }

  ApiCall._internal() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.connectTimeout = 1000 * 60;
    _dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  Future<LoginResponse?> login(
    String userName,
    String password,
    String token,
  ) async {
    try {
      var params = {
        "UserID": '0',
        "UserName": userName,
        "Password": password,
        "MobileNo": "",
        "MobileToken": token,
        "WebToken": "",
        "Latitude": "0.0",
        "Longitude": "0.0"
      };

      log('${_dio.options.baseUrl} $LOGIN_URL ${jsonEncode(params)}');
      final response = await _dio.post(LOGIN_URL, data: jsonEncode(params));

      log('response ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return LoginResponse.fromJson(response.data); //GateID,GateName
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getClients(
    String userId,
  ) async {
    try {
      var params = {
        "UserID": userId,
      };
      log('${_dio.options.baseUrl} $GET_CLIENT_URL ${jsonEncode(params)}');
      final response = await _dio.get(GET_CLIENT_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //ClientID,ClientName
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', '${e.toString()}');
      return null;
    }
  }

  Future<dynamic> getLocations(
    String clientId,
  ) async {
    try {
      var params = {
        "ClientID": clientId,
      };

      log('${_dio.options.baseUrl} $GET_LOCATION_URL ${jsonEncode(params)}');
      final response =
          await _dio.get(GET_LOCATION_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.requestOptions.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //LocationID,LocationName
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getGateLit(
    String groupId,
    String clientId,
    String locationId,
    String gateId,
  ) async {
    try {
      var params = {
        "GroupID": groupId,
        "ClientID": clientId,
        "LocationID": locationId,
        "GateID": gateId,
      };

      log('${_dio.options.baseUrl} $GET_GATE_URL ${jsonEncode(params)}');
      final response = await _dio.get(GET_GATE_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //GateID,GateName
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', '${e.toString()}');
      return null;
    }
  }

  Future<dynamic> getSystemList(String clientId, String locationId,
      String gateId, String systemId) async {
    try {
      var params = {
        "SystemID": systemId,
        "ClientID": clientId,
        "LocationID": locationId,
        "GateID": gateId,
      };

      log('${_dio.options.baseUrl} $GET_SYSTEM_URL ${jsonEncode(params)}');
      final response = await _dio.get(GET_SYSTEM_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //SystemID,SystemName
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', '${e.toString()}');
      return null;
    }
  }

  Future<SearchVisitorResponse?> getVisitor(
    String otp,
    String phone,
    String clientId,
  ) async {
    try {
      var params = {
        "OTP": otp,
        "PhoneNo": phone,
        "ClientID": clientId,
        // "PassNo": passNo,
      };

      log('${_dio.options.baseUrl} $GET_VISITOR_URL ${jsonEncode(params)}');
      final response = await _dio.get(GET_VISITOR_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return SearchVisitorResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<ApproverListResponse?> getApproverList(
    String clientId,
    String locationId,
    String tenantId,
    String visitorTypeId,
    String approvalId,
  ) async {
    try {
      var params = {
        "ClientID": clientId,
        "LocationID": locationId,
        "TenantID": tenantId,
        "VisitorTypeID": visitorTypeId,
        "ApprovalID": approvalId,
      };

      log('${_dio.options.baseUrl} $GET_APPROVER_LIST ${jsonEncode(params)}');
      final response =
          await _dio.get(GET_APPROVER_LIST, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return ApproverListResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<VisitorResponse?> getVisitorList(
    String systemId,
    String visitorId,
  ) async {
    try {
      var params = {
        "SystemID": systemId,
        "VisitorID": visitorId,
      };

      log('${_dio.options.baseUrl} $GET_VISITOR_LIST_URL ${jsonEncode(params)}');
      final response =
          await _dio.get(GET_VISITOR_LIST_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return VisitorResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getVisitorType(
    String groupId,
    String vtid,
  ) async {
    try {
      var params = {
        "GroupID": groupId,
        "VisitorTypeID": vtid,
      };

      log('${_dio.options.baseUrl} $GET_VISITOR_TYPE_URL ${jsonEncode(params)}');
      final response =
          await _dio.get(GET_VISITOR_TYPE_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //VisitorTypeID,VisitorTypeName, IsApprovalNeed
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getGateVisitorType(
    String clientId,
    String vtid,
  ) async {
    try {
      var params = {
        "ClientID": clientId,
        "VisitorTypeID": vtid,
      };

      log('${_dio.options.baseUrl} $GET_GATE_VISITOR_TYPE_URL ${jsonEncode(params)}');
      final response =
          await _dio.get(GET_GATE_VISITOR_TYPE_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //VisitorTypeID,VisitorTypeName, IsApprovalNeed
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getPurpose(
    String groupId,
    String pid,
  ) async {
    try {
      var params = {
        "GroupID": groupId,
        "PurposeOfVisitID": pid,
      };

      log('${_dio.options.baseUrl} $GET_PURPOSE_URL ${jsonEncode(params)}');
      final response = await _dio.get(GET_PURPOSE_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //PurposeofVisitID,PurposeofVisitName, IsHostNeed
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getProofAndVehicle() async {
    try {
      log('${_dio.options.baseUrl} $GET_PROOF_VEH_URL ');
      final response = await _dio.get(
        GET_PROOF_VEH_URL,
      );

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response
            .data; //DropdownID,TypeID, Dropdown type 1 proof type 2 vehicle
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getUserByClient(
    String clientId,
    String tid,
  ) async {
    try {
      var params = {
        "ClientID": clientId,
        "TenantID": tid,
      };

      log('${_dio.options.baseUrl} $GET_USER_BY_CLIENT_URL ${jsonEncode(params)}');
      final response =
          await _dio.get(GET_USER_BY_CLIENT_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //UserID,UserName, MobileNo
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> visitorInTimeUpdate(
    String visitorId,
  ) async {
    try {
      var params = {
        "VisitorID": visitorId,
      };

      log('${_dio.options.baseUrl} $VISITOR_INTIME_URL ${jsonEncode(params)}');
      final response =
          await _dio.post(VISITOR_INTIME_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //RtnStatus,RtnMessage
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> visitorOutTimeUpdate(
    String visitorId,
  ) async {
    try {
      var params = {
        "VisitorID": visitorId,
      };

      log('${_dio.options.baseUrl} $VISITOR_OUTTIME_URL ${jsonEncode(params)}');
      final response =
          await _dio.post(VISITOR_OUTTIME_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //RtnStatus,RtnMessage
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> insertVisitor(
    InsertVisitor body,
  ) async {
    try {
      log('${_dio.options.baseUrl} $INSERT_VISITOR_URL ${body.toJson()}');
      final response = await _dio.post(INSERT_VISITOR_URL, data: body);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //RtnStatus,RtnMessage
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> requestVisitor(
    InsertVisitor body,
  ) async {
    try {
      log('${_dio.options.baseUrl} $REQUEST_VISITOR_URL ${body.toJson()}');
      final response = await _dio.post(REQUEST_VISITOR_URL, data: body);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //RtnStatus,RtnMessage
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> insertAppointment(
    InsertAppointment body,
  ) async {
    try {
      log('${_dio.options.baseUrl} $INSERT_APPOINTMENT ${body.toJson()}');
      final response = await _dio.post(INSERT_APPOINTMENT, data: body);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //RtnStatus,RtnMessage
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<HostDashboardResponse?> getHostDashboard(
    String groupId,
    String clientId,
    String userId,
    String fromDate,
    String toDate,
  ) async {
    try {
      var body = {
        "GroupID": groupId,
        "ClientID": clientId,
        "UserID": userId,
        "FromDate": fromDate, //dd/MM/yyyy
        "ToDate": toDate
      };

      log('${_dio.options.baseUrl} $HOST_DAHBOARD ${body.toString()}');
      final response = await _dio.post(HOST_DAHBOARD, data: body);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return HostDashboardResponse.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<HostVisitorResponse?> getHostVisitorList(
    String groupId,
    String clientId,
    String userId,
    String fromDate,
    String toDate,
    String visitorId,
  ) async {
    try {
      var params = {
        "GroupID": groupId,
        "ClientID": clientId,
        "UserID": userId,
        "FromDate": fromDate, //dd/MM/yyyy
        "ToDate": toDate,
        "VisitorID": visitorId
      };

      log('${_dio.options.baseUrl} $HOST_VISITOR_LIST ${jsonEncode(params)}');
      final response =
          await _dio.get(HOST_VISITOR_LIST, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return HostVisitorResponse.fromJson(
            response.data); //UserID,UserName, MobileNo
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

/*  Future<dynamic> getAppVersion() async {
    var uri = Uri.https(
      'dbzmind.dbzapps.com',
      'app_version.json',
    );
    final response = await _dio.getUri(uri);

    if ((response.statusCode ?? -1) <= 205) {
      return jsonDecode(response.data);
    } else {
      print('notification : response status code > 205');
      return null;
    }
  }*/

  Future<dynamic> sendActionCall(int userId, int id, int visitorId) async {
    var params = {
      "VisitorID": visitorId.toString(),
      "ApproveStatus": id.toString(),
      "ApproverID": userId.toString(),
      "Level": 1
    };

    try {
      log('${_dio.options.baseUrl} $HOST_ACTION_URL ${jsonEncode(params)}');
      final response = await _dio.get(HOST_ACTION_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //UserID,UserName, MobileNo
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }

  Future<dynamic> getNotification(int userId) async {
    try {
      var params = {"UserID": "$userId"};
      log('${_dio.options.baseUrl} $NOTIFICATION_URL ');
      final response =
          await _dio.get(NOTIFICATION_URL, queryParameters: params);

      log('response code ${response.requestOptions.path} ${response.statusCode} ${response.data}');
      if ((response.statusCode ?? -1) >= 205) {
        showSnackbar(null, response.statusMessage);
        return null;
      } else {
        return response.data; //NotificationMsg,NotificationTitle,CuDate
      }
    } catch (e) {
      log(e.toString());
      showSnackbar('Exception', e.toString());
      return null;
    }
  }
}
