import 'package:flutter/material.dart';
import 'package:leader_test/testpage/provider/detailprovider.dart';
import 'package:leader_test/testpage/provider/listprovider.dart';
import 'package:leader_test/testpage/view/listdetailview.dart';
import 'package:provider/provider.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewState createState() => _ListViewState();

}


class _ListViewState extends State<ListViewPage> {
  ListProvider? listProvider;
  BuildContext? dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    listProvider=Provider.of<ListProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      listProvider?.fetchApi();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Selector<ListProvider, bool>(
            builder: (context,_,child){
              if(listProvider!.list.length>0){
                return ListView.builder(
                  itemCount: listProvider!.list.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (__) => ChangeNotifierProvider<DetailProvider>(create: (context)=>DetailProvider(),child: DetailView(listRespModel: listProvider!.list[index],),)));
                      },
                      child: Container(
                        height: 120,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
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
                                  Text(listProvider!.list[index].name??"",style: TextStyle(color: Colors.white,fontSize: 20),),
                                  SizedBox(height: 10),
                                  Text(listProvider!.list[index].phone??"",style: TextStyle(color: Colors.white,fontSize: 15),)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else if(listProvider!.noInternet){
                return Center(child: Text("No Internet Connectivity"));
              }else{
                return Center(child: CircularProgressIndicator());
              }

            },
            selector: (context,provider)=>provider.listener,
          ),
        ),
      ],
    );
  }
}
