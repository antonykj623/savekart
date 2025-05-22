import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:savekart/widgets/placeorder.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/order_details_entity.dart';
import '../domain/wallet_balance_entity.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';
import 'Home.dart';

class OrderItemDetailsScreen extends StatefulWidget {

  OrderDetailsData orderDetailsData;

  OrderItemDetailsScreen(this.orderDetailsData);

  @override
  _OrderItemDetailsScreenState createState() => _OrderItemDetailsScreenState(this.orderDetailsData);
}

class _OrderItemDetailsScreenState extends State<OrderItemDetailsScreen> {
  int _statusValue = 0;

  double walletbalance=0;
  double _totalAmount = 0,usedwalletamount=0,totalamount_to_paid=0;
  String? _selectedOption="0";
  final List<String> _options = ["Cash on Delivery", "Online Payment"];
  bool iswalletused=false;

  final _enteredwalletamountcontroller = TextEditingController();

  final List<String> _statuses = [
    "Order Created",
    "Packing",
    "Out for Delivery",
    "Delivered",
    "Returned"
    "Cancelled",

  ];

  OrderDetailsData orderDetailsData;

  _OrderItemDetailsScreenState(this.orderDetailsData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateWalletBalance();
    setState(() {

    if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("0")==0)
      {
        _statusValue=0;
      }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("1")==0)
      {

        _statusValue=1;
      }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("2")==0)
    {

      _statusValue=2;
    }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("5")==0)
    {

      _statusValue=5;
    }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("4")==0)
    {

      _statusValue=4;
    }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("3")==0)
    {

      _statusValue=3;
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(

                  children: [
                    Expanded(child: Image.network(EcommerceApiHelper.productimageurl+orderDetailsData.cartProduct!.primeImage.toString(), width:ResponsiveInfo.isMobile(context)? 60:75, height: ResponsiveInfo.isMobile(context)? 60:75, fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child; // Image loaded successfully
                        return Center(child: CircularProgressIndicator()); // Show loader while loading
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                      },),flex: 1,),

                    Expanded(child: Padding(

                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        orderDetailsData.cartProduct!.productName.toString()+"\n"+
                            "Pice : "+orderDetailsData.cartOrder!.price.toString()+"\n"
                            "Quantity : "+orderDetailsData.cartOrder!.quantity.toString()+"\n"+
                        "Order No. : "+orderDetailsData.cartOrder!.orderId.toString()+"\n"+
                        "Item Code : "+orderDetailsData.cartProduct!.productCode.toString()+"/"+orderDetailsData.cartOrder!.id.toString()
                        ,



                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    )


                      ,flex: 3,)


                  ],
                )



                ,
              ),
              SizedBox(height: 20),
              Text(
                "Order Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              IgnorePointer(
                child: create_appropriateStepper()
                ,
                ignoring: true,
              )
              ,
              SizedBox(height: 20),

              (orderDetailsData.paymentDetails?.paymentStatus?.compareTo("2")==0 ||
                  orderDetailsData.paymentDetails?.paymentStatus?.compareTo("0")==0)?
              Padding(
                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?15:20),
                child:   Container(
                  width: double.infinity,
                  height: ResponsiveInfo.isMobile(context)?50:70,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0B7D97), // background
                      foregroundColor: Colors.white, // foreground
                    ),
                    onPressed: () async {


                      showRetryDialog();


                    },
                    child: Text('Retry',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),
                  ),
                ),)  :Container()

            ],
          ),
        ),
      )


      ,
    );
  }



  void showRetryDialog() {
    _totalAmount = double.parse(orderDetailsData.cartOrder!.price!);
    EcommerceApiHelper.totalamount=_totalAmount;
    totalamount_to_paid=_totalAmount;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.7,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Wallet Balance',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(walletbalance.toString(),
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 20),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _enteredwalletamountcontroller,
                        style: TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          labelText: 'Enter your wallet amount to redeem',

                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.green, width: 2.0),
                          ),
                        ),
                        onChanged: (txt) {
                          if (txt.isNotEmpty) {
                            iswalletused = false;
                            double d = double.tryParse(txt) ?? 0;
                            usedwalletamount = d;

                            if (d <= walletbalance) {
                              setState(() {
                                _totalAmount =   EcommerceApiHelper.totalamount;
                                _totalAmount = _totalAmount - d;
                                iswalletused = true;
                              });
                            } else {
                              usedwalletamount = 0;
                              setState(() {
                                _enteredwalletamountcontroller.text = "";
                                iswalletused = false;
                                _totalAmount = EcommerceApiHelper.totalamount;
                              });
                              ResponsiveInfo.showAlertDialog(
                                context,
                                "SaveKart",
                                "Entered amount is greater than wallet amount",
                              );
                            }
                          } else {
                            setState(() {
                              usedwalletamount = 0;
                              iswalletused = false;
                              _totalAmount = EcommerceApiHelper.totalamount;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Amount',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(_totalAmount.toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?15:20),
                        child:   Container(
                          width: double.infinity,
                          height: ResponsiveInfo.isMobile(context)?50:70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff0B7D97), // background
                              foregroundColor: Colors.white, // foreground
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              int paymenttype=0;

                              if(_totalAmount==0)
                                {
                                  paymenttype=3;
                                }
                              else{
                                paymenttype=2;
                              }

                              PlaceOrder(totalamount_to_paid.toString(), iswalletused,
                                  _totalAmount.toString(), paymenttype,
                                  usedwalletamount.toString());



                            },
                            child: Text('Place Order',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),
                          ),
                        ),)

                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  PlaceOrder(String total,bool iswalletsused,String paidamount,int paymenttype,String walletamountused)async {
    ResponsiveInfo.ShowProgressDialog(context);


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t = EcommerceApiHelper.getTimeStamp();

    Map<String, String> mp = new HashMap();
    mp['order_id']=orderDetailsData.cartOrder!.orderId.toString();
    mp['order_details_id']=orderDetailsData.cartOrder!.id.toString();

    mp['totalprice'] = total;
    mp['isWalletUsed'] = (iswalletsused ? 1 : 0).toString();
    mp['paid_amount'] = paidamount;

    mp['payment_type'] = paymenttype.toString();
    mp['used_wallet_amount'] = walletamountused;

    var response= await  apihelper.post(Apimethodes.retryNewOrder+"?q="+t.toString(),formDataPayload: mp);
    Navigator.pop(context);

    print(response);

    String d = jsonDecode(response);

    Map<String, dynamic> data=  jsonDecode(d)  ;

    //print(js['data']);

    if(data['status']==1) {
      if (_totalAmount == 0 && paymenttype==3 ) {

        updateWalletBalance();
        updateWalletPoints(data['data']);

        showOrderDialog(context, true, "Your order placed successfully!");
      }
      else{

        String urldata=data['data'];

        Completer c=Completer();


        NativeBridge().redirectToNative(urldata,c);
        var result= await c.future;
        if(result!=null && result.toString().contains("https://mysaveapp.com/ecommercepayment/paymentgateway/result.php")) {
          showPaymentStatus(result);
        }
        else{
          ResponsiveInfo.showAlertDialog(context, "Savekart", "Cannot fetch your payment details");
        }

      }
    }



  }
  updateWalletBalance()async
  {
    if(iswalletused) {
      // ResponsiveInfo.ShowProgressDialog(context);
      EcommerceApiHelper apihelper = new EcommerceApiHelper();

      var t = EcommerceApiHelper.getTimeStamp();
      Map<String, String> mp = new HashMap();
      mp['amount'] = usedwalletamount.toString();
      mp['description'] = "Amount used for placing order";


      var response = await apihelper.post(
          Apimethodes.updateWalletBalance + "?q=" + t.toString(),
          formDataPayload: mp);

      var js = jsonDecode(response);
      print(js);
      // Navigator.pop(context);
    }
  }

  updateWalletPoints(String orderid)async
  {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.updateWalletPoints+"?q="+t.toString()+"&orderid="+orderid);

    var js= jsonDecode( response) ;
    print(js);
  }

  showPaymentStatus(String url)
  {
    Uri uri = Uri.parse(url);

    // Extract query parameters
    Map<String, String> queryParams = uri.queryParameters;

    // Print all parameters
    queryParams.forEach((key, value) {
      print("$key: $value");
    });

    // Access individual parameters
    String? message = queryParams['message'];
    String? transactionid = queryParams['transactionid'];
    String? order_id=queryParams['order_id'];




    if(message!=null)
    {
      String a=message;
      String orderid=order_id!;

      if(a.contains("Your transaction is successful"))
      {

        updateWalletBalance();
        updateWalletPoints(orderid);

        // For success
        showOrderDialog(context, true, "Your order  placed successfully!");

      }
      else{

// For failure
        showOrderDialog(context, false, "Payment failed. Please try again.");
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
          content: Text(message),
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




  calculateWalletBalance() async
  {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.calculateWalletBallence+"?q="+t.toString());

    var js= jsonDecode( response) ;
    print(js);

    WalletBalanceEntity entity=WalletBalanceEntity.fromJson(js);

    if(entity!=null)
    {

      setState(() {

        walletbalance=double.parse(entity.data!.balance.toString());
      });


    }

  }
   getFormatedDate(String dateString) {
    // String dateString = "2025-03-26 21:39:05"; // Input date string

    // Parse the string into DateTime
    DateTime dateTime = DateTime.parse(dateString);

    // Format DateTime into 12-hour format with AM/PM
    String formattedDate = DateFormat('dd-MMM-yyyy').format(dateTime);

    return formattedDate; // Output: 2025-03-26 09:39:05 PM
  }




  Widget create_appropriateStepper()
  {
    Widget w=Container();

    if(orderDetailsData.paymentDetails?.paymentStatus?.compareTo("2")==0  )
      {
        w=Stepper(steps: [
          Step(
            title: Text("Order Initiated"),
            subtitle: Text("You have initiated to create an order\nDate : "+  ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
                ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
                : " No date available")),
            content: SizedBox.shrink(),
            isActive: true,
          ),
          Step(
            title: Text("Payment Not Completed"),
            subtitle: Text("You have not completed your payment",style: TextStyle(color: Colors.redAccent),),
            content: SizedBox.shrink(),
            isActive: true,
          )
        ], controlsBuilder: (context,controller){
          return const SizedBox.shrink();
        });
      }
   else if(orderDetailsData.paymentDetails?.paymentStatus?.compareTo("0")==0  )
    {
      w=Stepper(steps: [
        Step(
          title: Text("Order Initiated"),
          subtitle: Text("You have initiated to create an order\nDate : "+  ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
              ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
              : " No date available")),
          content: SizedBox.shrink(),
          isActive: true,
        ),
        Step(
          title: Text("Payment Failed"),
          subtitle: Text("Your transaction failed",style: TextStyle(color: Colors.redAccent),),
          content: SizedBox.shrink(),
          isActive: true,
        )
      ], controlsBuilder: (context,controller){
        return const SizedBox.shrink();
      });
    }

   else {

     if(_statusValue==0 || _statusValue==1 || _statusValue==2 || _statusValue==3)
    {
    w= (orderDetailsData.cartReturnRequests!=null&&!orderDetailsData.cartReturnRequests!.id.toString().isEmpty) ? Stepper(
    controlsBuilder: (context,controller){
    return const SizedBox.shrink();
    },
    currentStep: _statusValue,
    steps: [
    Step(
    title: Text("Order Created"),
    subtitle: Text(
    "You have created an order. \nDate :" +
    ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
        : " No date available")
    ),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 0,
    ),

    Step(
    title: Text("Packing"),
    subtitle: Text("Order Packing is on progress.\nDate : "+((orderDetailsData!.cartOrder!.packedAt != null && orderDetailsData!.cartOrder!.packedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.packedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 1,
    ),
    Step(
    title: Text("Shipped"),
    subtitle: Text("Shipped.You will get your product soon."+((orderDetailsData!.cartOrder!.podNumber != null && orderDetailsData!.cartOrder!.podNumber!.isNotEmpty) ? "\nTracking Number : "+orderDetailsData!.cartOrder!.podNumber:"")+"\nDate : "+((orderDetailsData!.cartOrder!.shippedAt != null && orderDetailsData!.cartOrder!.shippedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.shippedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 2,
    ),

    Step(
    title: Text("Delivered"),
    subtitle: Text("Order Delivered successfully.\nDate : "+((orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency != null && orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 3,
    ),


    Step(
    title:(orderDetailsData!.cartReturnRequests!.status.toString().compareTo("1")==0)?
    Text("Return request accepted") :
    (orderDetailsData!.cartReturnRequests!.status.toString().compareTo("2")==0 ?
    Text("Return request Rejected") :
    Text("Return request submitted on "+getFormatedDate(orderDetailsData!.cartReturnRequests!.createdAt.toString()))) ,
    subtitle: (orderDetailsData!.cartReturnRequests!.status.toString().compareTo("1")==0)?
    Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

    child:Text("Your return request accepted" + (orderDetailsData!.cartReturnRequests!.refundStatus.toString().compareTo("1")==0 ? "\n Refunded on "+((orderDetailsData!.cartReturnRequests!.refundedDate!=null)? getFormatedDate(orderDetailsData!.cartReturnRequests!.refundedDate.toString()) : "") : "\nNot Refunded")


    ,style: TextStyle(color: Colors.green),) ,

    ) : Container(),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 3,
    ) ,


    ],
    )
        :Stepper(
    controlsBuilder: (context,controller){
    return const SizedBox.shrink();
    },
    currentStep: _statusValue,
    steps: [
    Step(
    title: Text("Order Created"),
    subtitle: Text(
    "You have created an order. \nDate :" +
    ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
        : " No date available")
    ),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 0,
    ),

    Step(
    title: Text("Packing"),
    subtitle: Text("Order Packing is on progress.\nDate : "+((orderDetailsData!.cartOrder!.packedAt != null && orderDetailsData!.cartOrder!.packedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.packedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 1,
    ),
    Step(
    title: Text("Shipped"),
    subtitle: Text("Shipped.You will get your product soon."+((orderDetailsData!.cartOrder!.podNumber != null && orderDetailsData!.cartOrder!.podNumber!.isNotEmpty) ? "\nTracking Number : "+orderDetailsData!.cartOrder!.podNumber:"")+"\nDate : "+((orderDetailsData!.cartOrder!.shippedAt != null && orderDetailsData!.cartOrder!.shippedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.shippedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 2,
    ),

    Step(
    title: Text("Delivered"),
    subtitle: Text("Order Delivered successfully.\nDate : "+((orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency != null && orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 3,
    ),


    ],
    );
    }
    else if(_statusValue==4){
  w= Stepper(
  controlsBuilder: (context,controller){
  return const SizedBox.shrink();
  },
  currentStep: _statusValue,
  steps: [
  Step(
  title: Text("Order Created"),
  subtitle: Text(
  "You have created an order. \nDate :" +
  ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
      : " No date available")
  ),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 0,
  ),

  Step(
  title: Text("Packing"),
  subtitle: Text("Order Packing is on progress.\nDate : "+((orderDetailsData!.cartOrder!.packedAt != null && orderDetailsData!.cartOrder!.packedAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.packedAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 1,
  ),
  Step(
  title: Text("Out for delivery"),
  subtitle: Text("Out for delivery.You will get your product soon.\nDate : "+((orderDetailsData!.cartOrder!.shippedAt != null && orderDetailsData!.cartOrder!.shippedAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.shippedAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 2,
  ),

  Step(
  title: Text("Delivered"),
  subtitle: Text("Order Delivered successfully.\nDate : "+((orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency != null && orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 3,
  ),
  Step(
  title: Text("Returned"),
  subtitle: Text("Order returned successfully. Your return request accepted" + (orderDetailsData!.cartReturnRequests!.refundStatus.toString().compareTo("1")==0 ? "\n Refunded on "+((orderDetailsData!.cartReturnRequests!.refundedDate!=null)? getFormatedDate(orderDetailsData!.cartReturnRequests!.refundedDate.toString()) : "") : "\nNot Refunded")


  ,style: TextStyle(color: Colors.redAccent),),
  content: SizedBox.shrink(),
  isActive: _statusValue == 4,
  ),


  ],
  );
  }
    else if(_statusValue==5){

  w=Stepper(steps: [
  Step(
  title: Text("Order Created"),
  subtitle: Text("You have created an order.\n Date : "+((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 0,
  ),
  Step(
  title: Text("Cancelled"),
  subtitle: Text("Order cancelled on  \n Date : "+((orderDetailsData!.cartOrder!.cancelledAt != null && orderDetailsData!.cartOrder!.cancelledAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.cancelledAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 5,
  )
  ], controlsBuilder: (context,controller){
  return const SizedBox.shrink();
  });
  }
  }
    return w;
  }



}


class NativeBridge {
  var platform = MethodChannel('com.example.native/redirect');

  Future<void> redirectToNative(String url,Completer c) async {
    try {
      String result =   await platform.invokeMethod('goToNativeActivity',{"msg": url});

      c.complete(result);



    } on PlatformException catch (e) {
      print("Failed to call native code: '${e.message}'.");
    }
  }


}