
import 'package:leader_test/Constants.dart';
import 'package:leader_test/testpage/model/list_resp_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class ListRepo{


  static Future<List<ListRespModel>> fetchData() async{

    try{
      var response= await http.get(Uri.parse(Constants.baseUrl+"users"));
      var respJson = jsonDecode(response.body) as List;
      List<ListRespModel> data = respJson.map((json) => ListRespModel.fromJson(json)).toList();
      return data;
    }catch(exception){
      if(exception is SocketException){
        throw "No Internet";
      }
      else {
        throw "Something went wrong";
      }
    }

  }
}