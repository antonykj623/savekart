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
import 'package:upi_india/upi_india.dart';
import 'package:upi_india/upi_response.dart';

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
  }

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

  void _placeOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Confirmation'),
        content: Text(
            'Your order has been placed!\n\nDelivery to: $_selectedAddress\nTotal Amount: '+_totalAmount.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Place Order',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Colors.white)),
        backgroundColor: Color(0xff0B7D97),

        ),
    body: SingleChildScrollView(

      child:  Padding(
        padding: const EdgeInsets.all(16.0),
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

            ) : Container(),


            Divider(),

            // Order Summary Section
            (_cartItems.length>0)? Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)): Container() ,
            ..._cartItems.map((item) {
              return ListTile(
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
                      iswalletused=false;
                      _totalAmount = EcommerceApiHelper.totalamount;
                      ResponsiveInfo.showAlertDialog(context, "", "Entered amount is greater than wallet amount");
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(_totalAmount.toString(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),



            // Place Order Button
            Center(
              child: ElevatedButton(
                onPressed: () async {
                   // PlaceOrder(_totalAmount.toString());

                  if(_totalAmount==0)
                    {

                      // if( iswalletused)
                      // {
                      //
                      // }
                     //need to call in placeorder api.php   updateWalletBalance();
                        PlaceOrder(totalamount_to_paid.toString(),iswalletused,_totalAmount.toString(),3,usedwalletamount.toString());


                      // }
                      // else{
                      //   PlaceOrder(_totalAmount.toString(),"0",1,"Order Initiated");
                      // }


                    }
                  else {
                    showSingleSelectionDialog();
                  }

                  // initiateTransaction();
                },
                child: Text('Place Order'),
              ),
            ),
          ],
        ),
      ),
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
                        // PlaceOrder(_totalAmount.toString());
                         Navigator.pop(context);

                        ResponsiveInfo.showAlertDialog(context, "", "Sorry , this option is not applicable right now ");
                       // PlaceOrder(_totalAmount.toString(),"0",1,"Successfully placed order");
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
              _selectedAddress = _addresses[0].name.toString() + "\n" +
                  _addresses[0].housename.toString() + "\n" +
                  _addresses[0].landmark.toString()+"\n"+
                  _addresses[0].district.toString()+"\n"+
                  _addresses[0].phone.toString();
            }
            else{
              for(int i=0;i<_addresses.length;i++)
                {

                  if(_addresses[i].id.toString().compareTo(selected.toString())==0)
                    {

                      setState(() {
                        selected_addressid = _addresses[i].id.toString();
                        _selectedAddress = _addresses[i].name.toString() + "\n" +
                            _addresses[i].housename.toString() + "\n" +
                            _addresses[i].landmark.toString()+"\n"+
                            _addresses[i].district.toString()+"\n"+
                            _addresses[i].phone.toString();

                      });

                    }


                }


            }
          }
        });
      }



  }

  PlaceOrder(String total,bool iswalletsused,String paidamount,int paymenttype,String walletamountused)async{


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
    // mp['transactionid']=transactionid;
    // mp['status']=status.toString();
    // mp['description']=description;


    var response= await  apihelper.post(Apimethodes.createOrder+"?q="+t.toString(),formDataPayload: mp);
 Navigator.pop(context);

 print(response);

     String d = jsonDecode(response);

     Map<String, dynamic> data=  jsonDecode(d)  ;

    //print(js['data']);

     if(data['status']==1) {
       if (_totalAmount == 0) {
         // showDialog(
         //   context: context,
         //   builder: (context) =>
         //       AlertDialog(
         //         title: Text('Order Details'),
         //         content: Text(
         //             'Your order has been placed!\n\nDelivery to: $_selectedAddress\nPaid Amount: ' +
         //                 total.toString()),
         //         actions: [
         //           TextButton(
         //             onPressed: () {
         //               Navigator.of(context).pushAndRemoveUntil(
         //                 MaterialPageRoute(builder: (context) => HomeScreen()),
         //                     (Route<
         //                     dynamic> route) => false, // Remove all previous routes
         //               );
         //             },
         //             child: Text('OK'),
         //           ),
         //         ],
         //       ),
         // );
         updateWalletBalance();

         showOrderDialog(context, true, "Your order was placed successfully!");
       }
       else{

         String urldata=data['data'];

         Completer c=new Completer();


         NativeBridge().redirectToNative(urldata,c);
        var result= await c.future;
        showPaymentStatus(result);

       }
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




    if(message!=null)
    {
      String a=message;

      if(a.contains("Your transaction is successful"))
      {

        updateWalletBalance();

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



