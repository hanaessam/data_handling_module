import 'dart:convert';
import 'dart:io';

import 'package:data_handling_module/models/employee_model.dart';
import 'package:http/http.dart' as http;

class EmployeeController {
  var url = "http://dummy.restapiexample.com/api/v1/employees";

  Future<List<Employee>> getEmployees() async {
    List<Employee> employees = [];

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.cookieHeader: 'humans_21909=1',
        },
      );
      var data = jsonDecode(response.body);

      data['data'].forEach((emp) {
        var employee = Employee.fromJson(emp);
        employees.add(employee);
      });
    } catch (e) {
      throw Exception(e);
    }
    return employees;
  }
}
