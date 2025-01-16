import 'package:data_handling_module/controllers/employee_controller.dart';
import 'package:data_handling_module/models/employee_model.dart';
import 'package:data_handling_module/views/employee_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> employees = [];
  bool isLoading = true;

  Future<void> getMyEmployees() async {
    employees = await EmployeeController().getEmployees();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getMyEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeScreen(
                        employee: employees[index],
                      ),
                    ),
                  ),
                  title: Text(employees[index].employeeName),
                  subtitle:
                      Text('Salary: \$ ${employees[index].employeeSalary}'),
                );
              }),
    );
  }
}
