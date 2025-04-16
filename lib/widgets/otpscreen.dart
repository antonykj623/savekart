import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/User.dart';

import '../sms/ServerMessage.dart';
import '../web/AppStorage.dart';
import 'package:http/http.dart' as http;

import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';
import 'Home.dart';



class OTPScreen extends StatefulWidget {

  User user;
  OTPScreen(this.user);

  @override
  _OTPScreenState createState() => _OTPScreenState(this.user);
}

class _OTPScreenState extends State<OTPScreen> {
  List<TextEditingController> controllers =
  List.generate(4, (index) => TextEditingController());
  int _secondsRemaining = 30;
  bool _isResendDisabled = true;
  Timer? _timer;
  User user;
  String randomnum="";
  _OTPScreenState(this.user);

  @override
  void initState() {
    super.initState();
    startResendTimer();
    sendOTP(user.phone);
  }

  void startResendTimer() {
    setState(() {
      _secondsRemaining = 30;
      _isResendDisabled = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendDisabled = false;
          timer.cancel();
        });
      }
    });
  }

  void verifyOTP() {
    String otp = controllers.map((controller) => controller.text).join();
    if (otp.length == 4) {

      if(otp.compareTo(randomnum)==0)
        {


          registerUser();

        }
      else{

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter a valid 4-digit OTP"),
          duration: Duration(seconds: 2),
        ));

      }





    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a valid 4-digit OTP"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter OTP")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter the 4-digit OTP sent to your mobile",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width:ResponsiveInfo.isMobile(context)? 50:60,
                  child: TextField(
                    controller: controllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            SizedBox(height: ResponsiveInfo.isMobile(context)? 20:30),

            // Verify Button
            ElevatedButton(
              onPressed: verifyOTP,
              child: Text("Verify OTP"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, ResponsiveInfo.isMobile(context)? 50:70),
              ),
            ),

            SizedBox(height: 20),

            // Resend OTP Button with Timer
            TextButton(
              onPressed: _isResendDisabled ? null : startResendTimer,
              child: Text(
                _isResendDisabled ? "Resend OTP in $_secondsRemaining s" : "Resend OTP",
                style: TextStyle(color: _isResendDisabled ? Colors.grey : Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendOTP(String mobile)
  async {
    Random random = new Random();
    int randomNumber = random.nextInt(9999)+1000;

    randomnum =randomNumber.toString();

    print("OTP code : "+randomnum);


    String message=ServerMessage.buildServerMessage(ServerMessage.registration,randomnum,user.name,user.password);





    //  String message = ServerMessage.buildServerMessage(ServerMessage.registration, randomnum, usr.getName(), "");

    String u=message.replaceAll(" ","%20");



    String urldata= ServerMessage.smsbaseurl+ServerMessage.smsMethode+"?token="+ServerMessage.apikey+
        "&sender="+ServerMessage.sender+
        "&number="+mobile+
        "&route="+ServerMessage.route+
        "&type="+ServerMessage.type+
        "&sms="+u+"&templateid="+ServerMessage.registrationtemplateid;

    print("SMS url : "+urldata);

    try {

      String? token= await AppStorage.getString(AppStorage.token);
      Map<String, String> headers = {"Authorization" : ""};

      http.Response response = await http.get(Uri.parse(urldata), headers: headers);
      print(response.body.toString());

    } on SocketException {
      // if (showLoadingDialog) AppDialogs.closeDialog();
      // if (showErrorDialog) {
      //   throw FetchDataException('No Internet connection');
      // }
    } on TimeoutException {
      // if (showLoadingDialog) AppDialogs.closeDialog();
      // if (showErrorDialog) {
      //   throw ApiNotRespondingException(sessionTimedOutMessage);
      // }
    }
  }

  registerUser()
  async {

int spregcode=0;
int spregid=0;
    if(user.sponsor!=null)
    {
      spregcode=int.parse(user.sponsor.data!.regCode.toString());
      spregid=int.parse(user.sponsor.data!.id.toString());
    }

    Map<String,String> params=new HashMap();
    params["uuid"]="6465464565451";
    params["country_id"]=user.countryid+"";
    params["sp_reg_code"]=spregcode.toString()+"";
    params["sp_reg_id"]=spregid.toString();
    params["stateid"]=user.stateid;
    params["language"]=user.language;
    params["name"]=user.name;
    params["mobile"]=user.phone;
    params["password"]=user.password;
    params["email"]=user.email;
    params["timestamp"]=ResponsiveInfo.getRandomNumber().toString();


    ResponsiveInfo.ShowProgressDialog(context);
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.post(Apimethodes.userAuthenticate+"?q="+t.toString(),formDataPayload: params);
    Navigator.pop(context);

    var js= jsonDecode(response) ;

    if(js['status'].toString().compareTo("1")==0)
      {

        Random random = new Random();
        int randomNumber = random.nextInt(9999)+1000;

        randomnum =randomNumber.toString();

        print("OTP code : "+randomnum);


        String message=ServerMessage.buildServerMessage(ServerMessage.registration_Confirm_password,randomnum,user.name,user.password);





        //  String message = ServerMessage.buildServerMessage(ServerMessage.registration, randomnum, usr.getName(), "");

        String u=message.replaceAll(" ","%20");



        String urldata= ServerMessage.smsbaseurl+ServerMessage.smsMethode+"?token="+ServerMessage.apikey+
            "&sender="+ServerMessage.sender+
            "&number="+user.phone+
            "&route="+ServerMessage.route+
            "&type="+ServerMessage.type+
            "&sms="+u+"&templateid="+ServerMessage.registration_Confirm_templateid;
        try {

          String? token= await AppStorage.getString(AppStorage.token);
          Map<String, String> headers = {"Authorization" : ""};

          http.Response response = await http.get(Uri.parse(urldata), headers: headers);
          print(response.body.toString());

        } on SocketException {
          // if (showLoadingDialog) AppDialogs.closeDialog();
          // if (showErrorDialog) {
          //   throw FetchDataException('No Internet connection');
          // }
        } on TimeoutException {
          // if (showLoadingDialog) AppDialogs.closeDialog();
          // if (showErrorDialog) {
          //   throw ApiNotRespondingException(sessionTimedOutMessage);
          // }
        }

        AppStorage.SaveToken(AppStorage.token, js['token'].toString());

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomeScreen()
            )
        );


      }
    else{

      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }


  }
}
