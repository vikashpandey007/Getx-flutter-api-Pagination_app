import 'package:get/get.dart';

import '../userdata_model.dart';

class UserdataProvider extends GetConnect {
  Future<List<dynamic>> getUserdata(int _page, int per_page) async {
    try {
      final response = await get(
          "https://api.github.com/users/JakeWharton/repos?page=$_page&per_page=$per_page");
      if (response.status.hasError) {
        return Future.error(response.statusText.toString());
      } else {
        print(response.body);
        return response.body;
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
