import 'package:data_handling_module/models/employee_model.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  final Employee employee;
  const EmployeeScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Employee Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16.0,
          children: [
            Icon(Icons.person, size: 100),
            Text('Name: ${employee.employeeName}'),
            Text('Salary: \$ ${employee.employeeSalary}'),
            Text('Age: ${employee.employeeAge}'),
          ],
        ),
      ),
    );
  }
}
