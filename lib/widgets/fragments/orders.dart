
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/domain/order_entity.dart';
import 'package:savekart/domain/return_policy_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/app_version_entity.dart';
import '../../domain/order_details_entity.dart';
import '../../web/apimethodes.dart';
import '../../web/ecommerce_api_helper.dart';
import '../order_details.dart';
import '../uploadPhotosToReturn.dart';



class Orders extends StatefulWidget {
   Orders() ;

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {


  List<OrderDetailsData>? data = [];
  String serverdate="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOrders();
    getAppUpdates();
  }

  getAppUpdates()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();


    String version = packageInfo.version;


    EcommerceApiHelper apihelper=new EcommerceApiHelper();
    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getCartUpdate+"?q="+t.toString());
    AppVersionEntity appversion=AppVersionEntity.fromJson(jsonDecode(response1));
    if(appversion.status==1) {

      double currentversion=double.parse(version);
      String versionfromserver=appversion.data!.version.toString();
      double appversionfromserver=double.parse(versionfromserver);

      if (appversionfromserver>currentversion) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              AlertDialog(
                title: Text("App Version"),

                content: Text("New version: $versionfromserver is available"),
                actions: [
                  (appversionfromserver > currentversion) ? TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.integra.savekart"); // Change URL based on platform

                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                            url, mode: LaunchMode.externalApplication);
                      } else {
                        throw "Could not launch $url";
                      }
                    },
                    child: Text("Update"),
                  ) : Container(),

                ],
              ),
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(

        title: const Text('Orders',style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        leading: Container(),
        actions: [

          Padding(padding: EdgeInsets.all(5),

          child: IconButton(

            icon: Icon(Icons.refresh,size: 20,), onPressed: () { getAllOrders(); },
          ),

          )
        ],

      ),
      body:


      Stack(

        children: [

    Align(
      alignment: FractionalOffset.topCenter,
      child: (data!.length>0)? Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),
        child: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (context, index) {
            final item = data![index];
            final order = item.cartOrder!;
            final product = item.cartProduct!;
            final returnRequest = item.cartReturnRequests!;
            final paymentDetails=item.paymentDetails!;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderItemDetailsScreen(item),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                child: Container(
                    width: double.infinity,
                    // height:  item.cartOrder!.orderItemStatus.toString().compareTo("5")==0 ?150: item.cartOrder!.orderItemStatus.toString().compareTo("0")==0? 180:230 ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Image.network(
                            EcommerceApiHelper.productimageurl + product.primeImage.toString(),
                            width: ResponsiveInfo.isMobile(context) ? 60 : 75,
                            height: ResponsiveInfo.isMobile(context) ? 60 : 75,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: CircularProgressIndicator());
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.image, size: 50, color: Colors.black26);
                            },
                          ),
                          title: Text(
                            product.productName.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Price : ${order.price} Rs",
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black26),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderItemDetailsScreen(item),
                                ),
                              );
                            },
                          ),
                        ),

                        // Order Status Messages

                        ...[
                          if (paymentDetails.paymentStatus.toString().compareTo("1")!=0)
                            _buildStatusText("Payment failed", Colors.red)
                          else ...[
                            if (order.orderItemStatus.toString().compareTo("0") == 0)
                              _buildStatusText("Order created.", Colors.green),
                            if (order.orderItemStatus.toString().compareTo("1")==0)
                              _buildStatusText("Packing is in progress..", Colors.green),
                            if (order.orderItemStatus.toString().compareTo("2")==0)
                              _buildStatusText("Out for delivery", Colors.green),
                            if (order.orderItemStatus.toString().compareTo("3")==0)
                              _buildStatusText("Order delivered successfully", Colors.green),
                            if (order.orderItemStatus.toString().compareTo("4")==0)
                              _buildStatusText("You returned this product", Colors.redAccent),
                            if (order.orderItemStatus.toString().compareTo("5")==0)
                              _buildStatusText("You cancelled this order item", Colors.red),
                            if (order.status.toString().compareTo("1")==0)
                              _buildStatusText("You accepted this order item", Colors.green),
                            if (order.status.toString().compareTo("2")==0)
                              _buildStatusText("You rejected this order item", Colors.redAccent),

                            // Cancel Button
                            if (order.status.toString().compareTo("0")==0 && order.orderItemStatus.toString().compareTo("0") == 0)
                              _buildActionButton("Cancel", Colors.white, Color(0xff0B7D97), () {
                                _showConfirmationDialog(
                                  context,
                                  "Do you want to cancel this order item?",
                                      () => updateOrderCancelStatus(order.id.toString()),
                                );
                              }),

                            // Accept/Reject Buttons (on delivery)
                            if (order.status.toString().compareTo("0") == 0 &&
                                order.orderItemStatus.toString().compareTo("3") == 0 &&
                                isEligibleToShowAcceptReturn(item) &&
                                returnRequest.id.toString().isEmpty)
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildActionButton("Reject", Colors.white, Color(0xff0B7D97), () {
                                        _showConfirmationDialog(
                                          context,
                                          "Do you want to return this order item?",
                                              () => getReturnPolicies(order.productId.toString(), item),
                                        );
                                      }),
                                    ),
                                    Expanded(
                                      child: _buildActionButton("Accept", Color(0xff0B7D97), Colors.white, () {
                                        updateOrderAcceptStatus(order.id.toString());
                                      }),
                                    ),
                                  ],
                                ),
                              ),

                            // Return Request Status
                            if (returnRequest.status.toString().compareTo("0") == 0 &&
                                returnRequest.refundStatus.toString().compareTo("0") == 0)
                              _buildStatusText(
                                "You have submitted a return request on ${getFormatedDate(returnRequest.createdAt.toString())}",
                                Color(0xff0B7D97),
                              ),
                            if (returnRequest.status.toString() == "1")
                              _buildStatusText(
                                "Your return request accepted" +
                                    (returnRequest.refundStatus.toString() == "1"
                                        ? "\nRefunded on ${returnRequest.refundedDate != null ? getFormatedDate(returnRequest.refundedDate.toString()) : ""}"
                                        : "\nNot Refunded"),
                                Colors.redAccent,
                              ),
                          ]
                        ],

                      ],
                    ),
                  ) ,




              ),
            );
          },
        ),


      ) : Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/2.2),

      child: CircularProgressIndicator(),

      ),
    )



        

        ],
      ),
    );
  }
  Widget _buildStatusText(String text, Color color) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Text(text, style: TextStyle(color: color)),
    );
  }

  Widget _buildActionButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        height: ResponsiveInfo.isMobile(context) ? 50 : 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xff0B7D97), width: 1),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(color: textColor, fontSize: ResponsiveInfo.isMobile(context) ? 14 : 16)),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String message, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Savekart"),
          content: Text(message),
          actions: [
            TextButton(child: Text("Yes"), onPressed: () {
              Navigator.pop(context);
              onConfirm();
            }),
            TextButton(child: Text("No"), onPressed: () => Navigator.pop(context)),
          ],
        );
      },
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

  updateOrderCancelStatus(String orderid) async{

    ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.UpdateOrderCancel+"?q="+t.toString()+"&id="+orderid);

    var js= jsonDecode( response) ;
    Navigator.pop(context);
    getAllOrders();

  }

  updateOrderAcceptStatus(String orderid) async{

    ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.updateAcceptStatus+"?q="+t.toString()+"&id="+orderid);

    var js= jsonDecode( response) ;
    Navigator.pop(context);
    getAllOrders();

  }



  getAllOrders() async{

    // Timer.periodic(Duration(seconds: 3), (timer) async {
    //
    // });

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getOrderItems+"?q="+t.toString());

    var js= jsonDecode( response) ;

    // OrderEntity entity=OrderEntity.fromJson(js);
    OrderDetailsEntity entity=OrderDetailsEntity.fromJson(js);

    if(entity.status==1)
    {



      serverdate=entity.serverDate!;

      if(entity.data!.length>0) {
        setState(() {
          data!.clear();

          data!.addAll(   entity.data!.reversed.toList());
        });
      }
      else{
        ResponsiveInfo.showAlertDialog(context, "Save Kart", "No data found");
      }

    }


  }

  getReturnPolicies(String product_id,OrderDetailsData ord)
  async {
    ResponsiveInfo.showLoaderDialog(context);
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getReturnPolicyData+"?q="+t.toString()+"&product_id="+product_id);


    Navigator.pop(context);

    var js= jsonDecode( response) ;
ReturnPolicyEntity entity=ReturnPolicyEntity.fromJson(js);

if(entity.status==1)
  {
    Widget noButton = TextButton(
      child: Text("no"),
      onPressed: () {

        Navigator.pop(context);

      },
    );

    Widget okButton = TextButton(
      child: Text("Yes"),
      onPressed: () {

        Navigator.pop(context);

        Navigator.push(context,
            MaterialPageRoute(builder:
                (context) =>
                    ReturnProductImagePickerWidget(product_id,entity!.data!.policyId.toString(),ord)
            )
        );


      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Savekart"),
      content: Text(entity.data!.policy.toString()+"\n Do you want to continue ?"),
      actions: [
        okButton,
        noButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }
else{

  ResponsiveInfo.showAlertDialog(context, "", "Error while fetching Return Policy of this product");
}




  }
  
  
  bool isEligibleToShowAcceptReturn(OrderDetailsData data)
  {
    bool a=false;
    String days="0";
   if(serverdate!=null&&serverdate.isNotEmpty)
     {

       DateTime s_dateTime = DateFormat("yyyy-MM-dd hh:mm:ss a").parse(serverdate);
       
       if(data.cartOrder?.deliveryRecvedDateFromAgency!=null &&data.cartOrder!.deliveryRecvedDateFromAgency.toString().isNotEmpty)
         {
           DateTime o_dateTime = DateTime.parse(data.cartOrder!.deliveryRecvedDateFromAgency.toString());
           
           if(data.cartProduct?.returnable.toString().compareTo("1")==0)
             {
        
                days=data.cartProduct!.returnDays!;
               
               if(days!.isNotEmpty&&days!=null)
                 {
                   int d=int.parse(days);
                   
                 DateTime dt_afterreturntime=  o_dateTime.add(Duration(days: d));
                 
                 if(s_dateTime.isAfter(dt_afterreturntime))
                   {
                     a=false;
                   }
                 else{


                     a = true;

                 }
                   
                 }
               
               
               
             }
           
           
         }
       
       
     }
    
    
    return a;
  }


}
