import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/profile_data_entity.dart';
import 'package:savekart/domain/wallet_balance_entity.dart';
import 'package:savekart/widgets/Home.dart';
import 'package:savekart/widgets/address_list.dart';

import 'package:weipl_checkout_flutter/weipl_checkout_flutter.dart';

import '../domain/address_data_entity.dart';
import '../domain/cart_products_entity.dart';
import '../domain/user_address_data_entity.dart';
import '../web/api_helper.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';
import '../web/paymentwebiew.dart';


class PlaceOrderWidget extends StatefulWidget {

  double total=0;

  PlaceOrderWidget(this.total);


  @override
  _PlaceOrderWidgetState createState() => _PlaceOrderWidgetState(this.total);
}

class _PlaceOrderWidgetState extends State<PlaceOrderWidget> {
  final List<UserAddressDataData> _addresses = [];
  String? _selectedAddress,selected_addressid="0",selected="0";
  final List<CartProductsData> _cartItems = [

  ];
  double _totalAmount = 0,walletbalance=0,usedwalletamount=0,totalamount_to_paid=0;
  String? _selectedOption="0";
  final List<String> _options = ["Cash on Delivery", "Online Payment"];
bool iswalletused=false;

  final _enteredwalletamountcontroller = TextEditingController();

  String orderid="0";

  WeiplCheckoutFlutter wlCheckoutFlutter = WeiplCheckoutFlutter();

  _PlaceOrderWidgetState(this._totalAmount);

  @override
  void initState() {
    super.initState();
    // Default address selection
    // _calculateTotalAmount();
    getCartItems();
    getAllAddress();
    calculateWalletBalance();
    EcommerceApiHelper.totalamount=_totalAmount;
    totalamount_to_paid=_totalAmount;
    wlCheckoutFlutter.on(WeiplCheckoutFlutter.wlResponse, handleResponse);
  }

  //
  // @override
  // void dispose() {
  //   wlCheckoutFlutter.clear();
  //   super.dispose();
  // }

  getCartItems()async
  {


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getCartData+"?q="+t.toString());

    var js= jsonDecode( response) ;
    CartProductsEntity entity=CartProductsEntity.fromJson(js);
    if(entity!.status==1)
    {

      setState(() {

        _cartItems.addAll(entity!.data!);

      });

      _calculateTotalAmount();


    }


  }

  void _calculateTotalAmount() {
    // _totalAmount = _cartItems.fold(0, (sum, item) {
    //   return sum + (double.parse(item.price.toString())   * int.parse(item.quantity.toString()) );
    // });

    double t=0;
    _totalAmount=0;

    for(int i=0;i<_cartItems.length;i++)
    {
      if(_cartItems[i].pointsRedeemed.toString().compareTo("1")==0)
      {
        t=t+(double.parse(_cartItems[i].price.toString()) * double.parse(_cartItems[i].quantity.toString())   );
      }
      else{
        t=t+(double.parse(_cartItems[i].savekartprice.toString()) * double.parse(_cartItems[i].quantity.toString()));
      }
    }
    print(t);

    setState(() {
      _totalAmount=t;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(title: Text('Place Order',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Colors.white)),
        backgroundColor: Color(0xff0B7D97),
          actions: [

            Padding(padding: EdgeInsets.all(10),

            child:      Center(
              child: ElevatedButton(
                onPressed: () async {
                  // PlaceOrder(_totalAmount.toString());

                  if(selected_addressid?.compareTo("0")!=0) {
                    if (_totalAmount == 0 ) {

                      PlaceOrder(totalamount_to_paid.toString(), iswalletused,
                          _totalAmount.toString(), 3,
                          usedwalletamount.toString());


                    }
                    else {
                      showSingleSelectionDialog();
                    }
                  }
                  else{

                    ResponsiveInfo.showAlertDialog(context, "Savekart", "Please Select Your Address");
                  }

                  // initiateTransaction();
                },
                child: Text('Confirm',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),
              ),
            ),

            )

          ],

        ),
    body:Column(

      children: [

        Expanded(child: SingleChildScrollView(

          child:  Padding(
            padding:  EdgeInsets.fromLTRB(16.0,16.0,16.0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address Section
                Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                (_addresses.length>0)?  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0),

                  child: Row(

                    children: [
                      Expanded(child: Text(_selectedAddress.toString(),style: TextStyle(color: Colors.black),),flex: 2,),

                      Expanded(child: Padding(

                        padding: EdgeInsets.all(4),
                        child: ElevatedButton(
                          onPressed: () async {

                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddressList(),
                              ),
                            );

                            // Show the returned result in a dialog
                            if (result != null) {
                              String   added = result['added'] ?? '';
                              String id=result['id']??'';
                              if(added.compareTo("1")==0)
                              {
                                print("Selected address${id}");
                                setState(() {
                                  selected=id;
                                  selected_addressid=id;
                                });

                                getAllAddress();



                              }


                            }


                          },
                          child: (_addresses.length>0)? Text('Change',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?13:15),) : Text("Add",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?13:15)),
                        ),
                      )

                        ,flex: 1,)

                    ],
                  ),

                ) :
                Container(width: double.infinity,
                    color: Colors.white54,

                    height: 200,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Align(

                          alignment: FractionalOffset.center,
                          child: Text('No Delivery Address Found', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        ),

                        TextButton(onPressed: () async {

                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddressList(),
                            ),
                          );

                          // Show the returned result in a dialog
                          if (result != null) {
                            String   added = result['added'] ?? '';
                            String id=result['id']??'';
                            if(added.compareTo("1")==0)
                            {
                              print("Selected address${id}");
                              setState(() {
                                selected=id;
                                selected_addressid=id;
                              });

                              getAllAddress();



                            }


                          }

                        }, child: Text('Click here to create new', style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal)))


                      ],
                    )





                ),


                Divider(),

                // Order Summary Section
                (_cartItems.length>0)? Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)): Container() ,
                ..._cartItems.map((item) {
                  return ListTile(
                    leading: Image.network(EcommerceApiHelper.productimageurl+item.primeImage.toString(),width: ResponsiveInfo.isMobile(context)?50:60,
                      height: ResponsiveInfo.isMobile(context)?50:60,fit: BoxFit.fill,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child; // Image loaded successfully
                        return Center(child: CircularProgressIndicator()); // Show loader while loading
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                      },

                    ),
                    title: Text(item.productName.toString()),
                    subtitle: Text('Quantity: '+item.quantity.toString()),
                    trailing:(item.pointsRedeemed.toString().compareTo("1")==0)? Text(''+(double.parse(item.price.toString())   * int.parse(item.quantity.toString())).toString() ) :
                    Text(''+(double.parse(item.savekartprice.toString())   * int.parse(item.quantity.toString())).toString() ),
                  );
                }).toList() ,
                (_cartItems.length>0)?  Divider() :Container(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wallet Balance', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Text(walletbalance.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 20),

                TextField(
                  keyboardType: TextInputType.number,
                  controller: _enteredwalletamountcontroller,
                  decoration: InputDecoration(
                    labelText: 'Enter your wallet amount to redeem',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.0), // Focused border color
                    ),
                  ),
                  onChanged: (txt){




                    if(txt.toString().isNotEmpty)
                    {
                      iswalletused=false;
                      double d=double.parse(txt.toString());
                      usedwalletamount=d;

                      if(d<=walletbalance) {
                        setState(() {
                          _totalAmount = EcommerceApiHelper.totalamount;
                          _totalAmount = _totalAmount - d;
                          iswalletused=true;
                        });
                      }
                      else{
                        usedwalletamount=0;

                        setState(() {
                          _enteredwalletamountcontroller.text="";
                          iswalletused=false;
                          _totalAmount = EcommerceApiHelper.totalamount;
                          ResponsiveInfo.showAlertDialog(context, "SaveKart", "Entered amount is greater than wallet amount");
                        });

                      }

                    }
                    else{
                      setState(() {
                        usedwalletamount=0;
                        iswalletused=false;
                        _totalAmount=EcommerceApiHelper.totalamount;

                      });

                    }


                  },
                ),

                SizedBox(height: 20),




                // Total Amount
              




              ],
            ),
          ),
        ),flex: 4,),

        Expanded(child: Padding(
    
    padding: EdgeInsets.all(16),
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Total Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(_totalAmount.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 20),
      ],


    ) ,
    )
        
        
        
        ,flex: 1,)

      ],
    )









    );
  }

  String _response = "No transaction yet";



  void showSingleSelectionDialog() async {
    _selectedOption="0";
    final selectedOption = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select an Option"),
          content: SingleChildScrollView(
            child: Column(
              children: _options.map((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedOption,
                  onChanged: (value) async {




                    if(value.toString().compareTo("Cash on Delivery")==0)
                      {

                         Navigator.pop(context);

                       ResponsiveInfo.showAlertDialog(context, "", "Sorry , this option is not applicable right now ");

                      }
                    else{
                      Navigator.pop(context);

                       PlaceOrder(totalamount_to_paid.toString(),iswalletused,_totalAmount.toString(),2,usedwalletamount.toString());


                    }

                    // Navigator.pop(context, value); // Close dialog with selection
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without selection
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );

    if (selectedOption != null) {
      setState(() {
        _selectedOption = selectedOption;
      });
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


  getAllAddress()async
  {

    WidgetsBinding.instance.addPostFrameCallback((_) {

      ResponsiveInfo.showLoaderDialog(context);


    });


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getAddressList+"?q="+t.toString());

    var js= jsonDecode( response) ;

    UserAddressDataEntity entity=UserAddressDataEntity.fromJson(js);
    WidgetsBinding.instance.addPostFrameCallback((_) {

    Navigator.pop(context);


    });
    if(entity.status==1)
      {

        setState(() {

          _addresses.clear();
          if(entity.data!.length>0) {
            _addresses.addAll(entity.data!);

            if(selected.toString().compareTo("0")==0) {
              selected_addressid = _addresses[0].id.toString();
              _selectedAddress = _addresses[0].name.toString() + "," +
                  _addresses[0].housename.toString() + "\n" +
                  _addresses[0].landmark.toString()+","+
                  _addresses[0].district.toString()+"\n"+
                 "Phone : "+ _addresses[0].phone.toString()+",\nPin code : "+_addresses[0].pincode.toString();
            }
            else{
              for(int i=0;i<_addresses.length;i++)
                {

                  if(_addresses[i].id.toString().compareTo(selected.toString())==0)
                    {

                      setState(() {
                        selected_addressid = _addresses[i].id.toString();
                        _selectedAddress = _addresses[i].name.toString() + "," +
                            _addresses[i].housename.toString() + "\n" +
                            _addresses[i].landmark.toString()+","+
                            _addresses[i].district.toString()+"\n"+
                            "Phone : "+_addresses[i].phone.toString()+",\nPin Code : "+_addresses[0].pincode.toString();

                      });

                    }


                }


            }
          }
        });
      }



  }

  PlaceOrder(String total,bool iswalletsused,String paidamount,int paymenttype,String walletamountused)async{

    String email="",phone="";
    ResponsiveInfo.ShowProgressDialog(context);
    Map<String,String> m=new HashMap();
    ApiHelper apihelper1 = new ApiHelper();

    var response2= await  apihelper1.post(Apimethodes.getUserDetails,formDataPayload: m);
    var js= jsonDecode(jsonDecode(response2)) ;
    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);
    email=entity.data!.emailId.toString();
    phone=entity.data!.mobile.toString();

    Navigator.pop(context);






     ResponsiveInfo.ShowProgressDialog(context);


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    Map<String,String> mp=new HashMap();
    mp['address_id']=selected_addressid.toString();
    mp['totalprice']=total;
    mp['isWalletUsed']=(iswalletsused?1:0).toString();
     mp['paid_amount']=paidamount;

    mp['payment_type']=paymenttype.toString();
    mp['wallet_amount_used']=walletamountused;



    var response= await  apihelper.post(Apimethodes.createOrder+"?q="+t.toString(),formDataPayload: mp);
 Navigator.pop(context);

 print(response);

     String d = jsonDecode(response);

     Map<String, dynamic> data=  jsonDecode(d)  ;

     if(data['status']==1) {
       if (_totalAmount == 0 && paymenttype==3 ) {



         Uri uri = Uri.parse(data['data']);

         String? idTransaction = uri.queryParameters["id_transaction"];
         orderid=idTransaction.toString();





         showOrderDialog(context, true, "Your order placed successfully!");

         updateWalletPoints(idTransaction.toString());
         updateWalletBalance();
       }
       else{

         Uri uri = Uri.parse(data['data']);

         String? idTransaction = uri.queryParameters["id_transaction"];
         orderid=idTransaction.toString();

         // String urldata=data['data'];

         //Completer c=Completer();
         //
         //
         // NativeBridge().redirectToNative(urldata,c);
         // var result= await c.future;
         // if(result!=null&&result.toString().isNotEmpty && result.toString().contains("https://mysaveapp.com/ecommercepayment/paymentgateway/result.php")) {
         //   showPaymentStatus(result);
         // }
         // else{
         //   ResponsiveInfo.showAlertDialog(context, "Savekart", "Cannot fetch your payment details");
         //   Navigator.of(context).pushAndRemoveUntil(
         //     MaterialPageRoute(builder: (context) => HomeScreen()),
         //         (Route<
         //         dynamic> route) => false, // Remove all previous routes
         //   );
         // }


         //fetching transaction credentials

         ResponsiveInfo.ShowProgressDialog(context);


         EcommerceApiHelper apihelper = new EcommerceApiHelper();

         var t=EcommerceApiHelper.getTimeStamp();

         var response= await  apihelper.get(Apimethodes.getPaymentCredentials+"?q="+t.toString());

         print(response);

         Navigator.pop(context);

         var data1 = jsonDecode(response);





         String customerid=data1['customerid'];
         String merchantcode=data1['merchantcode'];
         String salt=data1['saltkey'];
         String txnid=idTransaction.toString();

         String a=    merchantcode+"|"+txnid+"|"+paidamount+"||"+customerid+"|"+phone+"|"+email+"||||||||||"+salt;

        // String a=    merchantId+"|"+randomNumber+"|1||"+consumerId+"|"+consumerMobileNo+"|"+consumerEmailId+"||||||||||1178920237UGKJGI";


         //fetching hash methode

         ResponsiveInfo.ShowProgressDialog(context);

         Map<String,String> mp=new HashMap();
         mp['data']=a;

         EcommerceApiHelper apihelper1= new EcommerceApiHelper();

         var t1=EcommerceApiHelper.getTimeStamp();

         var response1= await  apihelper1.post(Apimethodes.generateHash+"?q="+t1.toString(),formDataPayload:mp );

         print(response1);

         Navigator.pop(context);

         String d1 = jsonDecode(response1);

         Map<String, dynamic> data2=  jsonDecode(d1)  ;

         String value = data2["value"];
         print(value);





         var reqJson = {
           "features": {
             "enableAbortResponse": true,
             "enableExpressPay": true,
             "enableInstrumentDeRegistration": true,
             "enableMerTxnDetails": true
           },
           "consumerData": {
             "deviceId": "AndroidSH2",
             "token":value,
             "paymentMode": "all",
             "merchantLogoUrl":
             "https://mysaveapp.com/ic_launcher.png",
             "merchantId": merchantcode,
             "currency": "INR",
             "consumerId": customerid,
             "consumerMobileNo": phone,
             "consumerEmailId": email,
             "txnId":txnid, //Unique merchant transaction ID
             "items": [
               {"itemId": "first", "amount": paidamount, "comAmt": "0"}
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
     }
     else{
     //  ResponsiveInfo.showAlertDialog(context, "Savekart", "Something went wrong");
       Navigator.of(context).pushAndRemoveUntil(
         MaterialPageRoute(builder: (context) => HomeScreen()),
             (Route<
             dynamic> route) => false, // Remove all previous routes
       );
     }





     //real one
     // if(data['status']==1) {
     //   if (_totalAmount == 0 && paymenttype==3 ) {
     //
     //     updateWalletBalance();
     //     updateWalletPoints(data['data']);
     //
     //     showOrderDialog(context, true, "Your order placed successfully!");
     //   }
     //   else{
     //
     //     String urldata=data['data'];
     //
     //     Completer c=Completer();
     //
     //
     //     NativeBridge().redirectToNative(urldata,c);
     //    var result= await c.future;
     //    if(result!=null&&result.toString().isNotEmpty && result.toString().contains("https://mysaveapp.com/ecommercepayment/paymentgateway/result.php")) {
     //      showPaymentStatus(result);
     //    }
     //    else{
     //      ResponsiveInfo.showAlertDialog(context, "Savekart", "Cannot fetch your payment details");
     //      Navigator.of(context).pushAndRemoveUntil(
     //        MaterialPageRoute(builder: (context) => HomeScreen()),
     //            (Route<
     //            dynamic> route) => false, // Remove all previous routes
     //      );
     //    }
     //
     //   }
     // }
     // else{
     //   ResponsiveInfo.showAlertDialog(context, "Savekart", "Something went wrong");
     //   Navigator.of(context).pushAndRemoveUntil(
     //     MaterialPageRoute(builder: (context) => HomeScreen()),
     //         (Route<
     //         dynamic> route) => false, // Remove all previous routes
     //   );
     // }




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
transactionId+"\n"+"Order ID : "+orderId+"Customer ID : "+customerId+"\n"+
    "Transaction Date : "+txnDateTime+"\nmessage : "+statusMessage;

    String paymentstatus="0";

    if(statusCode.compareTo("0300")==0)
      {

        if(statusMessage.compareTo("SUCCESS")==0)
          {
            updateWalletBalance();
            updateWalletPoints(orderid);
            paymentstatus="1";



updatePaymentStatus(transactiondetails,transactionId,paymentstatus);


            // For success
            // showOrderDialog(context, true, "Your order  placed successfully!");
          }
        else{

          paymentstatus="0";

          updatePaymentStatus(transactiondetails,transactionId,paymentstatus);

          // ResponsiveInfo.showAlertDialog(context, "Savekart", "Payment failed");
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute(builder: (context) => HomeScreen()),
          //       (Route<
          //       dynamic> route) => false, // Remove all previous routes
          // );
        }

      }
    else{
      paymentstatus="0";
      updatePaymentStatus(transactiondetails,transactionId,paymentstatus);

    }


  }

  updatePaymentStatus(String transactiondetails,String transactionid,String paymentstatus) async {

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t = EcommerceApiHelper.getTimeStamp();
    Map<String, String> mp = new HashMap();
    mp['orderid'] = orderid;
    mp['transactiondetails'] = transactiondetails;
    mp['transactionid'] = transactionid;
    mp['payment_status'] = paymentstatus;

    if(paymentstatus.compareTo("1")==0)
      {

        mp['description'] = "Transaction completed successfully";
      }
    else{
      mp['description'] = "Transaction failed";

    }


    var response = await apihelper.post(
        Apimethodes.updateOrderStaus + "?q=" + t.toString(),
        formDataPayload: mp);
    print(response);
    var js = jsonDecode(response);



    if(paymentstatus.compareTo("1")==0)
      {
        showOrderDialog(context, true, "Your order  placed successfully!");
      }
    else{
    //  ResponsiveInfo.showAlertDialog(context, "Savekart", "Payment failed");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<
            dynamic> route) => false, // Remove all previous routes
      );

    }
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



