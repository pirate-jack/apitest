import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/CarResponseModel.dart';
import '../Model/REsponseModel.dart';
import 'Linkurl.dart';

class APIService {
  Future<ResponseModel> signup(Map<String, dynamic> map) async {
    String url = Linkurl.url + "signup.php";
    var result = await http.post(Uri.parse(url), body: map);
    var res = jsonDecode(result.body);
    ResponseModel model = ResponseModel.FromJason(res);
    return model;
  }


  Future<ResponseModel> login(Map<String, dynamic> map) async {
    String url = Linkurl.url + "login.php";

    var result = await http.post(Uri.parse(url), body: map);

    var res = jsonDecode(result.body);
    ResponseModel model = ResponseModel.FromJason(res);
    return model;
  }


  Future<CarModel> carData() async {
    String url = Linkurl.url + "getCar.php";
    var result = await http.get(Uri.parse(url));
    print(result.body);
    var res = jsonDecode(result.body);
    CarModel model = CarModel.fromJson(res);
    return model;
  }
}
