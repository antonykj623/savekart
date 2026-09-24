import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/domain/userdata_entity.dart';

import '../design/ResponsiveInfo.dart';
import '../web/AppStorage.dart';
import '../web/SavekartApiHelper.dart';
import '../web/apimethodes.dart';


class SearchListDialog extends StatefulWidget {
  SearchListDialog() ;

  @override
  _SearchListDialogState createState() => _SearchListDialogState();
}

class _SearchListDialogState extends State<SearchListDialog> {
  TextEditingController _searchController = TextEditingController();

  List<String> filteredItems = [];

   List<UserdataData> usrdata=[];
  //
  UserdataEntity? usr;

  @override
  void initState() {
    super.initState();



  }



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text("Select a new user to change"),
      content: Container(
        width: double.maxFinite,
        height: double.infinity,
        child: Column(
          children: [
            // 🔍 Search box
            Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Search with reg ID or number",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {

                    if(!_searchController.text.isEmpty)
                    {

                      //getUserDataBYRegid.php

                      // String urldata=ApiMethodeCredentials.ecommerce_baseurl+ApiMethodeCredentials.getUserDataBYRegid+"?data="+_searchController.text;
                      //
                      // ApiHelper apiHelper=new ApiHelper();
                      //
                      // String response=await apiHelper.getApiResponse(urldata);
                      //
                      // var js= jsonDecode(response) ;
                      //
                      //
                      // final userResponse = UserResponse.fromJson(js);


                      WidgetsBinding.instance.addPostFrameCallback((_) {

                        ResponsiveInfo.showLoaderDialog(context);
                      });

                      String? token= await AppStorage.getString(AppStorage.token);
                      final timestamp =
                          DateTime.now().millisecondsSinceEpoch ~/ 1000;

                      final res = await SavekartApiService.post(
                        Apimethodes.getUserDetailsByWord+"?q="+timestamp.toString(),
                        token: token,
                        body: {
                          'searchword': _searchController.text,
                          'timestamp':timestamp.toString()

                        },
                      );

                      print(res);

                      WidgetsBinding.instance.addPostFrameCallback((_) {


                        Navigator.pop(context);
                      });

                      setState(() {
                        usr=UserdataEntity.fromJson(res);
                        usrdata=usr!.data!;
                      });


                    }




                  },
                  child: Text("Search"),
                ),


              ],
            )    ,



            SizedBox(height: 10),

          //  📋 List of filtered items
            Expanded(
              child: ListView.builder(
                itemCount: usrdata.length,
                itemBuilder: (context, index) {
                  return Card(

                    child: ListTile(
                      title: Text(usrdata[index].fullName.toString()+"\nMobile : "+usrdata[index].mobile.toString()+"\nReg ID :"+usrdata[index].regCode.toString()),
                      subtitle: Padding(padding: EdgeInsets.all(10),

                        child: TextButton(onPressed: (){
                          Navigator.pop(context, usrdata[index]);

                        }, child: Text("Select",style: TextStyle(fontSize: 13,color: Colors.teal),)),

                      )



                      ,
                      onTap: () {
                        Navigator.pop(context, usrdata[index]);
                      },
                    ),
                    elevation: 10,
                  )



                    ;
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Close"),
        ),
      ],
    );
  }
}
