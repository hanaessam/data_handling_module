import 'dart:convert';
import 'dart:io';

import 'package:data_handling_module/models/employee_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class EmployeeController {
  var url = "http://dummy.restapiexample.com/api/v1/employees";

  Future<List<Employee>> getEmployees() async {
    List<Employee> employees = [];

    try {
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.cookieHeader: 'humans_21909=1'
          },
           validateStatus: (status) {
              return status! < 500; 
            },
        ),
      );
     if (response.statusCode == 200) {
        var data = response.data['data'];
    

        for (var emp in data) {
          var employee = Employee.fromJson(emp);
          employees.add(employee);
        }
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception(e);
    }
    return employees;
  }
}
