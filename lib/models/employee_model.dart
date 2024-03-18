

class Employee {
  int? id;
  String? employeeName;
  int? employeeSalary;
  int? employeeAge;


  Employee({
     this.id,
     this.employeeName,
     this.employeeSalary,
     this.employeeAge,
  });

 Map<String, dynamic> toMap(){
   return {
     'id': id,
     'employeeName': employeeName,
     'employeeSalary': employeeSalary,
     'employeeAge': employeeAge
   };
 }

 factory Employee.fromJson(Map<String, dynamic> json) =>Employee(
   id: json['id'],
   employeeName: json['employee_name'],
   employeeSalary: json['employee_salary'],
   employeeAge: json['employee_age']
 );



  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
    "employee_salary": employeeSalary,
    "employee_age": employeeAge,
  };
}
