import 'dart:convert';

import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/order_item_by_i_d_entity.dart';
import '../domain/return_request_entity.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class ReturnedOrderItem extends StatefulWidget {
  ReturnRequestData returnRequestData;
   ReturnedOrderItem(this.returnRequestData) ;

  @override
  _ReturnedOrderItemState createState() => _ReturnedOrderItemState(this.returnRequestData);
}

class _ReturnedOrderItemState extends State<ReturnedOrderItem> {


  ReturnRequestData request;
  _ReturnedOrderItemState(this.request) ;

  OrderItemByIDEntity ordata=new OrderItemByIDEntity();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getOrderItemByID(request);
  }



  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(request.createdAt.toString());

    DateTime? dtrefund=null;
    if(request.refundedDate!=null)
    {
      dtrefund=DateTime.parse(request.refundedDate.toString());
    }
    return Scaffold(
      appBar: AppBar(

        title: const Text('Return Request',style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // handle back button press
            Navigator.pop(context);
          },

        ),

      ),

      body: Column(

        children: [

        Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),
                    child: (ordata.status!=0)? ListTile(
                      leading: Image.network(EcommerceApiHelper.productimageurl+ordata.data!.cartProduct!.primeImage.toString(), width:ResponsiveInfo.isMobile(context)? 60:75, height: ResponsiveInfo.isMobile(context)? 60:75, fit: BoxFit.cover),
                      title: Text(ordata.data!.cartProduct!.productName.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(ordata.data!.cartStock!.priceSales.toString()+"\nQty : "+ordata.data!.cartOrder!.quantity.toString(), style: TextStyle(color: Colors.green)),

                    ) : Container(),
                  ),

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

                  (request.image1!=null && request.image1.toString().isNotEmpty)?  Row(
                   children: [

                     (request.image1!=null && request.image1.toString().isNotEmpty)?
                     Image.network(EcommerceApiHelper.returnproductimagesurl+request.image1.toString(),width: ResponsiveInfo.isMobile(context)?100:150,height: ResponsiveInfo.isMobile(context)?100:150,) :Container(),
                     (request.image2!=null && request.image2.toString().isNotEmpty)?
                     Image.network(EcommerceApiHelper.returnproductimagesurl+request.image2.toString(),width: ResponsiveInfo.isMobile(context)?100:150,height: ResponsiveInfo.isMobile(context)?100:150) :Container(),
                     (request.image3!=null && request.image3.toString().isNotEmpty)?
                     Image.network(EcommerceApiHelper.returnproductimagesurl+request.image3.toString(),width: ResponsiveInfo.isMobile(context)?100:150,height: ResponsiveInfo.isMobile(context)?100:150) :Container()



                   ],
                 ) : Container(),









                ],
              )
          )





        ],
      ),

    );
  }


  getOrderItemByID(ReturnRequestData returnRequestData)async
  {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getOrderItemDetailsByid+"?q="+t.toString()+"&orderid="+returnRequestData.orderId.toString());

    var js= jsonDecode( response);

    OrderItemByIDEntity orderItem=OrderItemByIDEntity.fromJson(js);

    if(orderItem.status==1)
      {

        setState(() {
          ordata=orderItem;
        });



      }
    else{

    }


  }
}
