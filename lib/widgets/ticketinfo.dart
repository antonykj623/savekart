import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/domain/ssm/s_s_m_event_entity.dart';
import 'package:savekart/web/SavekartApiHelper.dart';
import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/profile_data_entity.dart';
import '../web/AppStorage.dart';
import '../web/api_helper.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';
import 'Home.dart';

class TicketInfoScreen extends StatefulWidget {
  final int quantity;
  final SSMEventData ssmEventData;

   TicketInfoScreen({super.key, required this.quantity,required this.ssmEventData});

  @override
  State<TicketInfoScreen> createState() => _TicketInfoScreenState();
}

class _TicketInfoScreenState extends State<TicketInfoScreen> {
  final double unitAmount = 100.0;
  final Color _ticketColor =  Color(0xFF1E5149);
  String email="",phone="",fullname="";
  double totalAmount =0;

  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProfileDetails();
    wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
  }

  @override
  Widget build(BuildContext context) {
     totalAmount = widget.quantity * double.parse(widget.ssmEventData.ticketAmount.toString());

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text('SSM Ticket confirmation', style: TextStyle(color: Colors.black,fontSize: 14)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding:  EdgeInsets.all(16.0),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding:  EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              decoration: BoxDecoration(
                color: _ticketColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==================== TOP BRAND HEADER ====================
                  Row(
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: Image.network("https://mysaving.in/assets/images/logo/saveicon.png",width: 45,height: 45, fit: BoxFit.fill,),
                      ),
                       SizedBox(width: 16),
                       Text(
                        'SAVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                   SizedBox(height: 24),

                  // ==================== CUSTOMER DETAILS ====================
                   Text(
                    'CUSTOMER:-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                   SizedBox(height: 4),
                   Text(
                     fullname+"\n"+phone+"\n"+email,
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                   SizedBox(height: 20),

                  // ==================== TICKET BREAKDOWN ====================
                  Text(
                    'Quantity :-   ${widget.quantity}',
                    style:  TextStyle(fontSize: 16, color: Colors.white),
                  ),
                   SizedBox(height: 8),
                  Text(
                    'Unit Amount :-  ${widget.ssmEventData.ticketAmount.toString()} ₹',
                    style:  TextStyle(fontSize: 16, color: Colors.white),
                  ),
                   SizedBox(height: 32),

                  // ==================== TOTAL & CONFIRM SECTION ====================
                  Container(
                    padding:  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: ${totalAmount.toStringAsFixed(2)} ₹',
                          style:  TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: _ticketColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:  Text('Confirm Purchase'),
                                  content:  Text('Are you sure you want to confirm this ticket booking?'),
                                  actions: [
                                    // Cancel Button
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                      },
                                      child:  Text('Cancel'),
                                    ),
                                    // Confirm Button
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Close the dialog
                                        // Add your confirmation logic here (e.g., navigation or API call)

                                        placeTicketOrder();



                                      },
                                      child:  Text('Yes, Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );


                          },
                          child:  Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  showProfileDetails() async {

    WidgetsBinding.instance.addPostFrameCallback((_) {

      ResponsiveInfo.showLoaderDialog(context);
    });
    //ResponsiveInfo.ShowProgressDialog(context);
    Map<String,String> m=new HashMap();
    ApiHelper apihelper1 = new ApiHelper();

    var response2= await  apihelper1.post(Apimethodes.getUserDetails,formDataPayload: m);
    WidgetsBinding.instance.addPostFrameCallback((_) {

      Navigator.pop(context);
    });
    var js= jsonDecode(jsonDecode(response2)) ;
    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);

    setState(() {

      email=entity.data!.emailId.toString();
      phone=entity.data!.mobile.toString();
      fullname=entity.data!.fullName.toString();
    });


   // Navigator.pop(context);
  }

  placeTicketOrder() async{

    ResponsiveInfo.ShowProgressDialog(context);

    String idTransaction="0";

    String? token= await AppStorage.getString(AppStorage.token);

    final res = await SavekartApiService.post(
      Apimethodes.addEventBookingDetails,
      token: token,
      body: {
        'event_id': widget.ssmEventData.id.toString(),
        'name': fullname,
        'email': email,
        'mobile': phone,
        'payment_type': '1',
        'qty': widget.quantity.toString(),
      },
    );

    Navigator.pop(context);

    if(res!=null)
      {
        print(res);

        if(res['status'].toString().compareTo("true")==0) {
          idTransaction = res['event_id'].toString();
        }

      }



    ResponsiveInfo.ShowProgressDialog(context);


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t = EcommerceApiHelper.getTimeStamp();

    var response = await apihelper.get(
        Apimethodes.getPaymentCredentials + "?q=" + t.toString());

    print(response);

    Navigator.pop(context);

    var data1 = jsonDecode(response);


    String customerid = data1['customerid'];
    String merchantcode = data1['merchantcode'];
    String salt = data1['saltkey'];
    String txnid = idTransaction.toString();

    String a = merchantcode + "|" + txnid + "|" + totalAmount.toString() + "||" +
        customerid + "|" + phone.trim() + "|" + email + "||||||||||" + salt;



    ResponsiveInfo.ShowProgressDialog(context);

    Map<String, String> mp = new HashMap();
    mp['data'] = a;

    EcommerceApiHelper apihelper1 = new EcommerceApiHelper();

    var t1 = EcommerceApiHelper.getTimeStamp();

    var response1 = await apihelper1.post(
        Apimethodes.generateHash + "?q=" + t1.toString(),
        formDataPayload: mp);

    Navigator.pop(context);

    String d1 = jsonDecode(response1);

    Map<String, dynamic> data2 = jsonDecode(d1);

    String value = data2["value"];

    var reqJson = {
      "features": {
        "enableAbortResponse": true,
        "enableExpressPay": true,
        "enableInstrumentDeRegistration": true,
        "enableMerTxnDetails": true
      },
      "consumerData": {
        "deviceId": "AndroidSH2",
        "token": value,
        "paymentMode": "all",
        "merchantLogoUrl":
        "https://mysaving.in/client/savekart_api/ic_launcher.png",
        "merchantId": merchantcode,
        "currency": "INR",
        "consumerId": customerid,
        "consumerMobileNo": phone,
        "consumerEmailId": email,
        "txnId": txnid, //Unique merchant transaction ID
        "items": [
          {"itemId": "first", "amount": totalAmount.toString(), "comAmt": "0"}
        ],
        "customStyle": {
          "PRIMARY_COLOR_CODE":
          "#0B7D97", //merchant primary color code
          "SECONDARY_COLOR_CODE":
          "#FFFFFF", //provide merchant's suitable color code
          "BUTTON_COLOR_CODE_1":
          "#0B7D97", //merchant"s button background color code
          "BUTTON_COLOR_CODE_2":
          "#FFFFFF" //provide merchant's suitable color code for button text
        }
      }
    };


    wlCheckoutFlutter.open(reqJson);






  }

  void handleResponse(dynamic response) {
    //  ResponsiveInfo.showAlertDialog(context, "Response", response.toString());
    print(response);
    List<String> parts = response['msg']!.split('|');
    String statusCode = parts[0];              // 0300
    String statusMessage = parts[1];           // SUCCESS
    String description = parts[2];             // Verification SUCCESS Transaction
    String transactionId = parts[3];           // 1234567
    String orderId = parts[4];                 // 33570
    String customerId = parts[5];              // 669013977
    String amount = parts[6];                  // 1.00
    String txnDateTime = parts[8];             // 27-06-2025 12:50:34
    String uuid = parts[14];                   // 607369e3-68fe-4f9b-b3a4-fe0a2e7fd5a3
    String hashValue = parts[15];              // Long hash string
    String merchantCode = response['merchant_code'] ?? '';
    String transactiondetails="Transaction ID : "+
        transactionId+"\n"+"Order ID : "+orderId+"\nCustomer ID : "+customerId+"\n"+
        "Transaction Date : "+txnDateTime+"\nmessage : "+statusMessage;

    String paymentstatus="0";

    if(statusCode.compareTo("0300")==0)
    {
      if(statusMessage.toLowerCase().compareTo("success")==0)
      {

        paymentstatus="1";



        updatePaymentStatus(transactionId,paymentstatus);



      }
      else{

        paymentstatus="0";

        // updatePaymentStatus(transactiondetails,transactionId,paymentstatus);

        // ResponsiveInfo.showAlertDialog(context, "Savekart", "Payment failed");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<
              dynamic> route) => false, // Remove all previous routes
        );
      }
    }



    else{
      paymentstatus="0";
      //  updatePaymentStatus(transactiondetails,transactionId,paymentstatus);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<
            dynamic> route) => false, // Remove all previous routes
      );

    }


  }

  updatePaymentStatus(String transactionId,String paymentstatus)async{

    WidgetsBinding.instance.addPostFrameCallback((_) {

      ResponsiveInfo.showLoaderDialog(context);
    });

    String? token= await AppStorage.getString(AppStorage.token);

    final res = await SavekartApiService.post(
      Apimethodes.updatePaymentStatus,
      token: token,
      body: {
        'ref_id': transactionId,
        'payment_status': paymentstatus
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {

  Navigator.pop(context);
    });

    if(res!=null){

      if(res['status'].toString().compareTo("true")==0) {

        showOrderDialog(context, true, "Ticket booking completed successfully");

      }

    }

  }
  void showOrderDialog(BuildContext context, bool isSuccess, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle : Icons.error,
                color: isSuccess ? Colors.green : Colors.red,
                size: 40,
              ),
              SizedBox(width: 8),
              Text(isSuccess ? 'Order Successful' : 'Order Failed'),
            ],
          ),
          content: Text(message +"\n"+"Name : "+fullname+"\nmobile : "+phone),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                      (Route<
                      dynamic> route) => false, // Remove all previous routes
                );
              },
            ),
          ],
        );
      },
    );
  }

}

// Custom Painter to draw the stylized 'S' shape logo
