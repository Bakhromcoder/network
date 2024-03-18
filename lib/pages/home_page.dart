

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ng_demo_home13/models/employee_model.dart';
import 'package:ng_demo_home13/pages/update_page.dart';
import 'package:ng_demo_home13/services/log_service.dart';

import '../services/http_service.dart';
import 'creat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoading = true;
  List<Employee> employeesList = [];


  _loadEmployees() async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_EMPLOYEE_LIST, Network.paramsEmpty());
    LogService.d(response!);
    List<Employee> postList = Network.parseEmployees(response);
    setState(() {
      employeesList = postList;
      isLoading = false;
    });
  }

  // _deleteEmployee(Employee employee) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var response = await Network.DEL(
  //     Network.API_EMPLOYEE_DELETE + employee.id.toString(),
  //     Network.paramsEmpty(),
  //   );
  //   LogService.d(response!);
  //   _loadEmployees();
  // }

  _deleteEmployee(Employee employee) async {
    setState(() {
      isLoading = true;
    });
    var response = await Network.DEL(
        Network.API_EMPLOYEE_DELETE + employee.id.toString(),
        Network.paramsEmpty());
    LogService.d(response!);
    _loadEmployees();
  }

  Future _callCreatePage() async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const CreatePage();
    }));

    if (result) {
      _loadEmployees();
    }
  }

  Future _callUpdatePage(Employee employee) async {
    bool result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return UpdatePage(employee: employee);
    }));

    if (result) {
      _loadEmployees();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadEmployees();
  }

  Future _hendleRefresh() async{
    _loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Employees', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _hendleRefresh,
            child: ListView.builder(
              itemCount: employeesList.length,
              itemBuilder: (ctx, index){
                return _itemOfEmployee(employeesList[index]);
              },
            ),
          ),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          _callCreatePage();
        },
      ),
    );
  }

  Widget _itemOfEmployee(Employee employee) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _callUpdatePage(employee);
            },
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _deleteEmployee(employee);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${employee.employeeName}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            Text('Age ${employee.employeeAge}'),
            Text('Salary \$${employee.employeeSalary}'),
            Divider(),
          ],
        ),
      ),
    );
  }
}
