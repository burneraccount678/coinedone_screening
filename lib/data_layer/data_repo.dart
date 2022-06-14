import 'models.dart';
import 'package:http/http.dart' as http;

class DataRepo {
  Future<DataModel> fetchdata() async {
    var url = Uri.parse('https://api.mocklets.com/p68289/screentime');
    var response = await http.get(
      url,
    );
    return dataModelFromJson(response.body);
  }
}
