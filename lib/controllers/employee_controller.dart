import 'dart:convert';
import 'dart:io';

import 'package:data_handling_module/models/employee_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeController {
  var url = "http://dummy.restapiexample.com/api/v1/employees";
  static const String cacheKey = 'cachedEmployees';

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
        await cacheEmployees(employees);
      } else {
        print('Error: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e) {
      print('Exception: $e');
      employees = await loadCachedEmployees();
    }
    return employees;
  }

  Future<void> cacheEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(employees.map((e) => e.toJson()).toList());
    await prefs.setString(cacheKey, encodedData);
  }

  Future<List<Employee>> loadCachedEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(cacheKey);
    if (encodedData != null) {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      return decodedData.map((e) => Employee.fromJson(e)).toList();
    }
    return [];
  }
}