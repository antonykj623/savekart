
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/domain/app_version_entity.dart';
import 'package:savekart/web/ecommerce_api_helper.dart';
import 'package:savekart/widgets/address_list.dart';
import 'package:savekart/widgets/edit_profile.dart';
import 'package:savekart/widgets/returnrequests.dart';
import 'package:savekart/widgets/wallet_transaction.dart';
import 'package:savekart/widgets/wishlist_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../design/ResponsiveInfo.dart';
import '../../domain/profile_data_entity.dart';
import '../../web/AppStorage.dart';
import '../../web/api_helper.dart';
import '../../web/apimethodes.dart';
import '../login_page.dart';



class Profile extends StatefulWidget {
   Profile() ;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  List<String>arricons=['assets/icons/editprofile.png','assets/icons/house-location.png','assets/icons/wallet.png','assets/icons/product-return.png','assets/icons/update.png','assets/icons/logout.png','assets/icons/user.png'];

  List<String>arrmenus=['Edit Profile','My Address','Savekart Wallet','Return Requests','App update','Logout','Delete Account'];

  String name="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // bottomNavigationBar: BottomNavigationBar(
      //   selectedItemColor: Colors.orange,
      //
      //
      //   currentIndex: 0,
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.grey,), label: 'Home',),
      //     BottomNavigationBarItem(icon: Icon(Icons.category,color: Colors.grey,), label: 'Categories'),
      //     BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,color: Colors.grey,), label: 'Orders'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.grey,), label: 'Profile'),
      //   ],
      // ),
      appBar: AppBar(

        title: const Text('Profile',style: TextStyle(fontWeight: FontWeight.w600),),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // handle back button press
            Navigator.pop(context);
          },

        ),

      ),
      body:


      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Padding(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?15:20,),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Hey ",
                  style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?17:20),
                  children: <TextSpan>[
                    TextSpan(text: '\n'+name, style: TextStyle(color: Colors.red,fontSize: ResponsiveInfo.isMobile(context)?17:20,),),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, ResponsiveInfo.isMobile(context)?10:15, 0, 0),

              child: Row(

                children: [

                  Expanded(child: GestureDetector(

    child: Padding(

      padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:8),
      child:Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          width: double.infinity,
          height: ResponsiveInfo.isMobile(context)?50:60,
          child: Row(
            children: [
              Expanded(child: Icon(Icons.favorite_border,color: Colors.redAccent,size: ResponsiveInfo.isMobile(context)?18:24,),flex: 1,),
              Expanded(child:     Text( "Wishlist",
                style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Colors.redAccent),




              ),flex: 2,)


            ],
          )




      ) ,
    ) ,
                    onTap: (){

                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              WishlistPage()
                          )
                      );

                    },
    )




                   ,flex: 1,),
                  Expanded(child: Padding(

                    padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:8),
                    child:Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.transparent,
                        ),
                        width: double.infinity,
                        height: ResponsiveInfo.isMobile(context)?50:60,
                        child: Row(
                          children: [
                            Expanded(child: Icon(Icons.help_sharp,color: Colors.blueAccent,size: ResponsiveInfo.isMobile(context)?18:24,),flex: 1,),
                            Expanded(child:     Text( "Help Desk",
                              style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Colors.blueAccent),




                            ),flex: 2,)


                          ],
                        )




                    ) ,
                  )

                    ,flex: 1,)
                ],
              ),

              )
            ],
            )



          ),flex: 1,)
          ,
          Expanded(child:    Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),
            child:
                SingleChildScrollView(

    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text( "Account Settings",
            style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?17:20,color: Colors.black87,fontWeight: FontWeight.bold)
        ),
        ListView.builder(
            itemCount: arrmenus.length,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(

                child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:8),

                  child:      ListTile(
                    leading: Image.asset(arricons[index],width: ResponsiveInfo.isMobile(context)?25:30,height: ResponsiveInfo.isMobile(context)?25:30,),

                    title: Text(arrmenus[index],style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:17,color: Colors.black),),

                  ),
                ),
                onTap: ()
                async {
                  if(index==0)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            ProfilePage()
                        )
                    );
                  }

                  else  if(index==1)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            AddressList()
                        )
                    );
                  }

                  else if(index==2)
                  {

                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            WalletTransaction()
                        )
                    );
                  }
                  else if(index==3)
                  {

                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            ReturnRequestsScreen()
                        )
                    );
                  }

                  else if(index==4)
                    {
                      PackageInfo packageInfo = await PackageInfo.fromPlatform();

                      String appName = packageInfo.appName;
                      String packageName = packageInfo.packageName;
                      String version = packageInfo.version;
                      String buildNumber = packageInfo.buildNumber;

                      ResponsiveInfo.showLoaderDialog(context);

                      EcommerceApiHelper apihelper=new EcommerceApiHelper();

                      var response1= await  apihelper.get(Apimethodes.getCartUpdate);

                      Navigator.pop(context);
                      AppVersionEntity appversion=AppVersionEntity.fromJson(jsonDecode(response1));


                      // var js1= jsonDecode(jsonDecode(response1)) ;
                      if(appversion.status==1) {

                        double currentversion=double.parse(version);
                        String versionfromserver=appversion.data!.version.toString();
                        double appversionfromserver=double.parse(versionfromserver);


                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                title: Text("App Version"),
                                content: Text("Current Version: $version"),
                                actions: [
                                  (appversionfromserver>currentversion)?  TextButton(
                                    onPressed: () async {
                                      final Uri url = Uri.parse("https://play.google.com/store/apps/details?id=com.integra.savekart"); // Change URL based on platform

                                      if (await canLaunchUrl(url)) {
                                      await launchUrl(url, mode: LaunchMode.externalApplication);
                                      } else {
                                      throw "Could not launch $url";
                                      }
                                    },
                                    child: Text("Update"),
                                  ):Container(),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Close"),
                                  ),
                                ],
                              ),
                        );
                      }


                    }


                  else if(index==5)
                  {
                    Widget okButton = TextButton(
                      child: Text("Yes"),
                      onPressed: () {

                        Navigator.pop(context);

                        AppStorage.SaveToken(AppStorage.token, "");

                        Navigator.push(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                LoginPage()
                            )
                        );

                      },
                    );

                    Widget noButton = TextButton(
                      child: Text("No"),
                      onPressed: () {

                        Navigator.pop(context);

                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Savekart"),
                      content: Text("Do you want to logout from Savekart ?"),
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
                  else if(index==6)
                  {
                    Widget okButton = TextButton(
                      child: Text("Yes"),
                      onPressed: () {



                        _showDeleteAccountDialog(context);


                      },
                    );

                    Widget noButton = TextButton(
                      child: Text("No"),
                      onPressed: () {

                        Navigator.pop(context);

                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Savekart"),
                      content: Text("Do you want to delete your account from Savekart ?"),
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


                },
              )







              ;
            }),





      ],
    ),
    )






          ),flex: 3,)





        ],
      ),
    );
  }

  getProfile()async{

    Map<String,String> m=new HashMap();


    ApiHelper apihelper = new ApiHelper();

    var response= await  apihelper.post(Apimethodes.getUserDetails,formDataPayload: m);



    var js= jsonDecode(jsonDecode(response)) ;

    print(js);

    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);

    if(entity.status==1)
      {

        setState(() {

          String cleanedText = entity.data!.fullName.toString().replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');
        print(cleanedText);
          name=cleanedText.trim();
        });

      }



  }

  void _showDeleteAccountDialog(BuildContext context) {
    final TextEditingController mobileController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Delete Account"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Enter Mobile Number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile number is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                if (mobileController.text.isNotEmpty) {
                  if (passwordController.text.isNotEmpty) {

    ResponsiveInfo.showLoaderDialog(
    context);
    Map<String,String> m=new HashMap();
    m['uuid']="siuhdfid";
    m['mobile']=mobileController.text.toString();
    m['password']=passwordController.text.toString();
    m['timestamp']=ApiHelper.getTimeStamp();
    ApiHelper apihelper = new ApiHelper();
    var response= await  apihelper.post(Apimethodes.login,formDataPayload: m);
    Navigator.pop(context);
    var js= jsonDecode(jsonDecode(response)) ;

    if(js['status'].toString().compareTo("0") !=0)
    {


      ResponsiveInfo.showLoaderDialog(context);

      var response1= await  apihelper.get(Apimethodes.deleteAccount);
      Navigator.pop(context);

      var js1= jsonDecode(jsonDecode(response1)) ;

    if(js1['status'].toString().compareTo("0") !=0)
    {

      AppStorage.SaveToken(AppStorage.token, "");

      Navigator.push(context,
          MaterialPageRoute(builder:
              (context) =>
              LoginPage()
          )
      );

    }
    else{
      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }


    }
    else{

      ResponsiveInfo.showAlertDialog(context, "", "This user account is not exist");
    }








                  }
                  else{

                    ResponsiveInfo.showAlertDialog(context, "", "Please enter your account password");
                  }


                }
                else{

                  ResponsiveInfo.showAlertDialog(context, "", "Please enter your registered mobile number");
                }
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }





}
