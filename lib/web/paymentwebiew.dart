import 'dart:math';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../domain/profile_data_entity.dart';

class PaymentWebview extends StatefulWidget {


  String url;
  PaymentWebview(this.url);


  @override
  _WebViewExampleState createState() => _WebViewExampleState(this.url);
}

class _WebViewExampleState extends State<PaymentWebview> {
  late final WebViewController _controller;
  // ProfileDataEntity entity;

int a=ResponsiveInfo.getRandomNumber();
  String url;

  _WebViewExampleState(this.url);





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // ShowAlertDialog();
     // String   url="https://mysaveapp.com/ecommercepayment/paymentgateway/df.php?id_transaction="+a.toString()+"&name="+entity.data!.fullName.toString()+"&email="+entity.data!.emailId.toString()+"&phone="+entity.data!.mobile.toString()+"&amount="+total+"&timestamp="+ ResponsiveInfo.getRandomNumber().toString()+"&userid="+entity.data!.id.toString();

// String url="upi://pay";

   _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
..setBackgroundColor(Colors.transparent)

      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print("Page started loading: $url");

            if(url.contains("https://mysaveapp.com/ecommercepayment/paymentgateway/result.php"))
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

                        Navigator.of(context).pop({
                          'added': "1",
                          'id':transactionid
                        });

                      }
                    else{
                      Navigator.of(context).pop({
                        'added': "1",
                        'id':0
                      });

                    }




                  }


              }


          },
          onPageFinished: (String url) {
            print("Page finished loading: $url");
          },
          onNavigationRequest: (NavigationRequest request) {
            print("Navigating to: ${request.url}");
            if (request.url.startsWith("upi://")) {
              launchUPI(request.url);
              // Prevent WebView from attempting to load the UPI URL
               return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));



  }
  void launchUPI( String upiUrl) async {
//String upiUrl = "upi://pay?pa=yourupi@upi&pn=Your Name&mc=1234&tid=123456789&tr=987654321&tn=Test Payment&am=10.00&cu=INR";

    if (await canLaunchUrl(Uri.parse(upiUrl))) {
      await launchUrl(Uri.parse(upiUrl), mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch UPI app");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Container( width: MediaQuery.of(context).size.width,
    height:MediaQuery.of(context).size.height ,


    child:   WebViewWidget(
     controller: _controller,
      ) ),
    );
  }


  // ShowAlertDialog()
  // {
  //   ResponsiveInfo.showAlertDialog(context, "", "Please do not press back button under payment process");
  // }


}
