import 'dart:convert';
import 'package:http/http.dart';
import '../models/employee_model.dart';
import '../models/employee_res_model.dart';

class Network {
  static String BASE = "dummy.restapiexample.com";
  static Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};

  /* Http Apis */
  static String API_EMPLOYEE_LIST = "/api/v1/employees";
  static String API_EMPLOYEE_CREATE = "/api/v1/create";
  static String API_EMPLOYEE_UPDATE = "/api/v1/update/"; // {id}
  static String API_EMPLOYEE_DELETE = "/api/v1/delete/"; // {id}

  /* Http Requests */
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.http(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      'employeeName': employee.employeeName.toString(),
      'employeeSalary': employee.employeeSalary.toString(),
      'employeeAge': employee.employeeAge.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Employee employee) {
    Map<String, String> params = {};
    params.addAll({
      'id': employee.id.toString(),
      'employeeName': employee.employeeName.toString(),
      'employeeSalary': employee.employeeSalary.toString(),
      'employeeAge': employee.employeeAge.toString(),
    });
    return params;
  }

  /* Http Parsing */

  static List<Employee> parseEmployees(String response){
    dynamic json = jsonDecode(response);
    return EmployeeRes.fromJson(json).data!;
  }
}
