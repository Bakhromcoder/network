import 'package:flutter/material.dart';
import 'package:ng_demo_home13/models/employee_model.dart';
import 'package:ng_demo_home13/services/http_service.dart';
import 'package:ng_demo_home13/services/log_service.dart';

class UpdatePage extends StatefulWidget {
  final Employee employee;

  const UpdatePage({
    super.key,
    required this.employee,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  _updateEmployee() async {
    String name = _nameController.text.toString().trim();
    String salary = _salaryController.text.toString().trim();
    String age = _ageController.text.toString().trim();

    Employee newEmployee = widget.employee;
    newEmployee.employeeName = name;
    newEmployee.employeeSalary = int.parse(salary);
    newEmployee.employeeAge = int.parse(age);

    var response = await Network.PUT(
        Network.API_EMPLOYEE_UPDATE + newEmployee.id.toString(),
        Network.paramsUpdate(newEmployee));
    LogService.d(response!);
    _backToFinish();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.employee.employeeName!;
    _salaryController.text = widget.employee.employeeSalary.toString();
    _ageController.text = widget.employee.employeeAge.toString();
  }

  _backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Update'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ),
              Container(
                child: TextField(
                  controller: _salaryController,
                  decoration: InputDecoration(hintText: 'Salary'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                child: TextField(
                  controller: _ageController,
                  decoration: InputDecoration(hintText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 10),
                child: MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: (){
                    _updateEmployee();
                  },
                  child: Text("Update"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
