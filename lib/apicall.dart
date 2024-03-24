import 'dart:convert';

import 'package:api/datamodel.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  Future<List<DataModel>> fetchdata() async {
    final response =
        await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      final jsondata = jsonDecode(response.body);
      final List<dynamic> usersData = jsondata['data'];
      return usersData.map((e) => DataModel.fromJson(e)).toList();
    } else {
      throw Exception("error while fetching data from api");
    }
  }
}
