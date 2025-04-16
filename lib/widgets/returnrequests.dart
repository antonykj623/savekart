import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/return_request_entity.dart';
import 'package:savekart/widgets/returned_order_item.dart';

import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class ReturnRequestsScreen extends StatefulWidget {
  @override
  _ReturnRequestsScreenState createState() => _ReturnRequestsScreenState();
}

class _ReturnRequestsScreenState extends State<ReturnRequestsScreen> {
  // Dummy data for return requests (Replace with API data)
  // final List<Map<String, dynamic>> returnRequests = [
  //   {
  //     "refundStatus": "Pending",
  //     "adminStatus": "Accepted",
  //     "requestedDate": "2024-02-01",
  //     "returnReason": "Product was damaged",
  //     "refundDate": "2024-02-05"
  //   },
  //   {
  //     "refundStatus": "Completed",
  //     "adminStatus": "Rejected",
  //     "requestedDate": "2024-01-20",
  //     "returnReason": "Wrong product received",
  //     "refundDate": "2024-01-25"
  //   },
  //   {
  //     "refundStatus": "Processing",
  //     "adminStatus": "Pending",
  //     "requestedDate": "2024-02-03",
  //     "returnReason": "Size issue",
  //     "refundDate": "2024-02-10"
  //   },
  // ];

  List<ReturnRequestData>? returnRequests = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReturnRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Requests"),
      ),
      body: (returnRequests!.length>0)? ListView.builder(
        itemCount: returnRequests!.length,
        itemBuilder: (context, index) {
          final request = returnRequests![index];
          final dateTime = DateTime.parse(request.createdAt.toString());

          DateTime? dtrefund=null;
          if(request.refundedDate!=null)
            {
              dtrefund=DateTime.parse(request.refundedDate.toString());
            }



          return Card(
            margin: EdgeInsets.all(10),
            elevation: 3,
            child:
                GestureDetector(

        child:    Padding(
              padding: EdgeInsets.all(12),
              child: Row(

                children: [
                  Expanded(child:               Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (request.refundStatus.toString().compareTo("0")==0)?  Text("Refund Status: "+"Pending",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)) :
                      Text("Refund Status: "+"Success",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green))
                      ,
                      (request.status.toString().compareTo("0")==0)?  Text("Admin Status: "+"Pending",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)) :Container(),

                      (request.status.toString().compareTo("1")==0)?  Text("Admin Status: "+"Accepted",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)) :Container(),
                      (request.status.toString().compareTo("2")==0)?  Text("Admin Status: "+"Rejected",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)) :Container()

                      ,
                      Text("Requested Date: "+dateTime.day.toString()+"-"+dateTime.month.toString()+"-"+dateTime.year.toString()),
                      Text("Reason: "+request.reason.toString()),
                      (request.refundedDate!=null)? Text("Refund Date: "+dtrefund!.day.toString()+"-"+dtrefund!.month.toString()+"-"+dtrefund!.year.toString()) : Container(),
                    ],
                  ),
                  flex: 2,),

                  Expanded(child: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black54,size: ResponsiveInfo.isMobile(context)?25:30,),
                  flex: 1,)
                ],
              )
        ) ,
                  onTap: (){

                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            ReturnedOrderItem(request)
                        )
                    );
                  },

            ),
          );
        },
      ) : Stack(
        children: [

          Align(
            alignment: FractionalOffset.center,
            child: Text("No data found"),
          )
        ],
      ),
    );
  }



  getReturnRequests()async
  {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getReturnRequests+"?q="+t.toString());

    var js=jsonDecode(response);

    ReturnRequestEntity entity=ReturnRequestEntity.fromJson(js);

    if(entity.status==1)
{

      setState(() {

        returnRequests!.clear();
        returnRequests!.addAll(entity.data!);
      });


      }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("no data found"),
        ),
      );


    }


  }

}
