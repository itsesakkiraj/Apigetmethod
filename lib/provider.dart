import 'package:api/apicall.dart';
import 'package:flutter/cupertino.dart';

import 'datamodel.dart';

class ApiProvider extends ChangeNotifier {
  ApiCall apicall = ApiCall();

  List<DataModel> usersData = [];

  Future<void> getdata() async {
    try {
      usersData = await apicall.fetchdata();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
