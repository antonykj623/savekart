import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:savekart/domain/points_entity.dart';

import '../design/ResponsiveInfo.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class PurchasePoints extends StatefulWidget {
   PurchasePoints() ;

  @override
  _PurchasePointsState createState() => _PurchasePointsState();
}

class _PurchasePointsState extends State<PurchasePoints> {

  int walletpoints=0;
  List<PointsData>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWalletPoints();
    getWalletPointsList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(title: Text("Purchase Points",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:17,color: Colors.white),),
          leading: GestureDetector(

            child:Icon(Icons.arrow_back,color: Colors.white,size:ResponsiveInfo.isMobile(context)?20:25 ,) ,

            onTap: (){

              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff0B7D97),
          actions: [








          ]

          ,),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Expanded(child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Icon(Icons.star, color: Colors.orange, size: ResponsiveInfo.isMobile(context)?55:60),
                    SizedBox(height: 5,),
                    Text("Purchase Points Balance : "+walletpoints.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:17,color: Colors.black),),



                  ],
                )




            ),flex: 1,),

            Expanded(child: (data!.length>0)? ListView.builder(
                itemCount: data!.length,
                itemBuilder: (BuildContext context, int index) {

                  // List<String> date=data![index]!.transactionDate.toString().split(" ");
                  // String d=date[0];
                  final dateTime = getFormatedDate(data![index]!.insDate.toString());

                  return Card(

                    child:ListTile(
                      leading:  Icon(Icons.star,color: Colors.black54,size: ResponsiveInfo.isMobile(context)?25:30,),
                      trailing: (data![index].debit.toString().compareTo("0")==0 && data![index].credit.toString().compareTo("0")!=0) ?
                      Text(
                        "+"+data![index].credit.toString(),
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ) : Text(
                        "-"+data![index].debit.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      title: Text((data![index].description!=null&& data![index].description!.isNotEmpty)?   data![index]!.description.toString():"Purchase Points"),
                      subtitle: Text(dateTime.toString()),

                    ) ,
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                  )


                  ;
                }) : Stack(
              children: [

                Align(
                  alignment: FractionalOffset.center,
                  child: Text("No data found"),
                )
              ],
            ),flex: 5,)







          ],
        )


    );
  }
  getFormatedDate(String dateString) {
    // String dateString = "2025-03-26 21:39:05"; // Input date string

    // Parse the string into DateTime
    DateTime dateTime = DateTime.parse(dateString);

    // Format DateTime into 12-hour format with AM/PM
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss a').format(dateTime);

    return formattedDate; // Output: 2025-03-26 09:39:05 PM
  }

  getWalletPoints()
  async {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getWalletPoints+"?q="+t.toString());
    var js1= jsonDecode( response1) ;
    setState(()  {
      walletpoints=int.parse(js1['data'].toString());



    });



  }



  getWalletPointsList() async{
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      ResponsiveInfo.showLoaderDialog(context);
    });
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getWalletPointsTransaction+"?q="+t.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      Navigator.pop(context);
    });
    var js1= jsonDecode( response1) ;

    PointsEntity pointsEntity=PointsEntity.fromJson(js1);

    setState(() {
      data!.clear();
      data!.addAll(pointsEntity.data!);


    });


    print(js1);

  }


}
