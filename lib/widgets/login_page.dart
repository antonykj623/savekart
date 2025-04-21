import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:savekart/domain/token_data_entity.dart';
import 'package:savekart/web/AppStorage.dart';
import 'package:savekart/web/api_helper.dart';
import 'package:savekart/web/apimethodes.dart';

import '../customwidget/CustomTextformfield.dart';
import '../design/ResponsiveInfo.dart';
import '../domain/profile_data_entity.dart';
import '../sms/ServerMessage.dart';
import '../web/ecommerce_api_helper.dart';
import 'Account_Screen.dart';
import 'Home.dart';
import 'package:http/http.dart' as http;

import 'changepassword.dart';

class LoginPage extends StatefulWidget {
   LoginPage() ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController mobile=new TextEditingController();
  TextEditingController Password=new TextEditingController();
  
  String randomnum="";
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(

          children: [

            Align(
              alignment: FractionalOffset.center,
              child: Padding(padding: EdgeInsets.only(left: 0,top: ResponsiveInfo.isMobile(context)?20:30,right: 0,bottom: 0),

                  child: SingleChildScrollView(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [

                        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

                          child: Text("Hey, Hello 👋",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?28:33,color: Colors.black,fontWeight: FontWeight.bold),),
                        ),

                        Padding(padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?10:15,ResponsiveInfo.isMobile(context)?20:30,0,0),

                          child: Text("Sign in your account",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        SizedBox(height: 30,),


                        Padding(padding: EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?15:20,right: ResponsiveInfo.isMobile(context)?15:20,bottom: 0,top: 0),

                          child:
                          CustomTextFormfield(
                              labelText: "Mobile number",
                              controller:mobile,
                              isnumber: true,


                              ontap: () {},
                              isobscure: false),)

                        ,
                        SizedBox(
                          height:ResponsiveInfo.isMobile(context)? 30:50,
                        ),



                        Padding(
                          padding: EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?15:20,right: ResponsiveInfo.isMobile(context)?15:20,bottom: 0,top: 0),
                          child:

                          CustomTextFormfield(
                              labelText: "**********",
                              controller: Password,
                              isnumber: false,

                              ontap: () {},
                              isobscure: true),),
                        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:20),

                          child: Row(
                            children: [

                              Expanded(child: Container(),flex: 1,)

                            ,
                              Expanded(child: TextButton(onPressed: (){

                                showMobileDialog();

                              }, child:Text("Forgot Password ? ",style: TextStyle(color: Color(0xff0B7D97),fontSize: ResponsiveInfo.isMobile(context)?12:15),) ),flex: 1,)


                            ],
                          ),

                        ),

                        Stack(
                          children: [

                            Align(
                              alignment: FractionalOffset.center,
                              child: Padding(
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

                                      if(mobile.text.trim().isNotEmpty) {

                                        if(Password.text.trim().isNotEmpty) {
                                          ResponsiveInfo.showLoaderDialog(
                                              context);
                                          Map<String,String> m=new HashMap();
                                          m['uuid']="siuhdfid";
                                          m['mobile']=mobile.text.toString();
                                          m['password']=Password.text.toString();
                                          m['timestamp']=ApiHelper.getTimeStamp();

                                          ApiHelper apihelper = new ApiHelper();

                                       var response= await  apihelper.post(Apimethodes.login,formDataPayload: m);

                                       Navigator.pop(context);



                                       var js= jsonDecode(jsonDecode(response)) ;

                                       // TokenDataEntity tokendataety=TokenDataEntity.fromJson(js);



                                       if(js['status'].toString().compareTo("0") !=0)
                                         {



                                           AppStorage.SaveToken(AppStorage.token, js['token'].toString());

                                           Navigator.push(context,
                                               MaterialPageRoute(builder:
                                                   (context) =>
                                                   HomeScreen()
                                               )
                                           );


                                         }
                                       else{

                                         ResponsiveInfo.showAlertDialog(context, "", "Login failed");
                                       }









                                        }
                                        else{

                                          ResponsiveInfo.showAlertDialog(context, "", "Enter mobile number");
                                        }

                                      }
                                      else{

ResponsiveInfo.showAlertDialog(context, "", "Enter mobile number");
                                      }



                                    },
                                    child: Text('SIGN IN',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),
                                  ),
                                ),),
                            )
                          ],
                        )

                        ,




                        SizedBox(height: ResponsiveInfo.isMobile(context)? 10 : 15,),



                        // SizedBox(height: 10,width: 10,),


                        Row(
                          children: [
                        SizedBox(width:ResponsiveInfo.isMobile(context)? 80:100,),
                            Text("Don't Have an account?",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15)),

                            TextButton(onPressed: (){

                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      CreateAccount()
                                  )
                              );

                            }, child:Text("SIGN UP ",style: TextStyle(color: Color(0xff0B7D97),fontSize: ResponsiveInfo.isMobile(context)?12:15),) )
                          ],
                        ),



                      ],
                    ),
                  )




              ),
            )


          ],
        )




    );
  }

  showMobileDialog()
  {
    TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Registered mobile number"),
          content: TextField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Type here...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String inputText = _controller.text;

                if(inputText.length>0)
                  {

                    Navigator.of(context).pop();
                    getUserDetailsByMobile(inputText.trim());
                  }
                else{

                  ResponsiveInfo.showAlertDialog(context, "", "Enter mobile number");
                }


                 // Close dialog



              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  getUserDetailsByMobile(String mobile)async
  {
    ResponsiveInfo.ShowProgressDialog(context);
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getUserByMobile+"?q="+t.toString()+"&mobile="+mobile);
    Navigator.pop(context);

    var js= jsonDecode(response) ;

    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);

    if(entity.status==1)
    {
sendOTP(mobile);
_showOtpDialog(context,mobile);

    }
    else{

      ResponsiveInfo.showAlertDialog(context, "", "This mobile number is not exists");
    }


  }

  void _showOtpDialog(BuildContext context,String mobilenumber) {
    TextEditingController _otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter OTP"),
          content: TextField(
            controller: _otpController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 1,
            decoration: InputDecoration(
              hintText: "Enter 4-digit OTP",
              counterText: "",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String otp = _otpController.text.trim();
                if (otp.length == 4) {

                  if(randomnum.compareTo(otp.trim())==0)
                    {

                      Navigator.pop(context);

                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                                  ChangePasswordScreen(mobilenumber)
                          )
                      );
                    }
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter a OTP")),
                    );
                  }

                  // Close dialog

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please enter a valid 4-digit OTP")),
                  );
                }
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  sendOTP(String mobile)
  async {
    Random random = new Random();
    int randomNumber = random.nextInt(9999)+1000;

    randomnum =randomNumber.toString();

    print("OTP code : "+randomnum);


    String message=ServerMessage.buildServerMessage(ServerMessage.forgot_password,randomnum,"","");





    //  String message = ServerMessage.buildServerMessage(ServerMessage.registration, randomnum, usr.getName(), "");

     String u=message.replaceAll(" ","%20");



    String urldata= ServerMessage.smsbaseurl+ServerMessage.smsMethode+"?token="+ServerMessage.apikey+
        "&sender="+ServerMessage.sender+
        "&number="+mobile+
        "&route="+ServerMessage.route+
        "&type="+ServerMessage.type+
        "&sms="+u+"&templateid="+ServerMessage.forgotpasstemplateid;

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
}
