
import 'dart:convert';
import 'employee_model.dart';

EmployeeRes employeeResFromJson(String str) => EmployeeRes.fromJson(json.decode(str));

String employeeResToJson(EmployeeRes data) => json.encode(data.toJson());

class EmployeeRes {
  String? status;
  List<Employee>? data;
  String? message;

  EmployeeRes({
    this.status,
    this.data,
    this.message,
  });

  factory EmployeeRes.fromJson(Map<String, dynamic> json) => EmployeeRes(
    status: json["status"],
    data: List<Employee>.from(json["data"].map((x) => Employee.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}