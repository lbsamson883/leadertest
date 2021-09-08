
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leader_test/testpage/model/list_resp_model.dart';
import 'package:leader_test/testpage/repo/listrepo.dart';

class ListProvider extends ChangeNotifier{

  List<ListRespModel> list=[];
  bool _listener=false;
  bool _noInternet=false;

  bool get noInternet => _noInternet;

  set noInternet(bool value) {
    _noInternet = value;
  }

  bool get listener => _listener;

  set listener(bool value) {
    _listener = value;
  }


  changeList(){
    _listener=!_listener;
    notifyListeners();
  }

  void fetchApi() async {
    list.clear();
    var hiveBox = await Hive.openBox('list');
    if (hiveBox.isNotEmpty) {
       addDatafromHive(hiveBox);
    } else {
      ListRepo.fetchData().then((value) async{
        if (value.isNotEmpty) {
          await hiveBox.clear();
          value.forEach((element) {
            element.addressConcated="Address : " +element.address!.street!+" , "+element.address!.suite!+" , "+element.address!.city!;
            element.companyConcated="Company name : "+element.company!.name!;
          });
          list.addAll(value.toList());
          await hiveBox.addAll(value);
        }
        changeList();
      }
      ).catchError((onError) async {
        var hiveBox = await Hive.openBox('list');
        if (hiveBox.isNotEmpty) {
          addDatafromHive(hiveBox);
        }else{
          _noInternet=true;
          await changeList();
        }
      });
    }
  }

  void addDatafromHive(Box hiveBox) {
     list.addAll(List<ListRespModel>.from(hiveBox
         .toMap()
         .values
        .toList()));
    changeList();
  }
}