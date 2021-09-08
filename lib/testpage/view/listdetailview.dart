import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leader_test/testpage/model/list_resp_model.dart';

class DetailView extends StatelessWidget {
  final ListRespModel listRespModel;
  DetailView({Key? key,required this.listRespModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Item Details'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 15,
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          height: 500,
          width: double.infinity,
          child: Card(
            elevation: 10,
            color: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Name : "+listRespModel.name!,style: TextStyle(color: Colors.white,fontSize: 20),),
                  SizedBox(height: 10),
                  Text("Email : "+listRespModel.email!,style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(height: 10),
                  Text(listRespModel.addressConcated??"",style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(height: 10),
                  Text("Phone : "+listRespModel.phone!,style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(height: 10),
                  Text("Website : "+listRespModel.website!,style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(height: 10),
                  Text(listRespModel.companyConcated??"",style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(height: 10),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
