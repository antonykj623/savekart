


import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/country_list_entity.dart';
import 'package:savekart/domain/state_list_entity.dart';
import 'package:savekart/widgets/Home.dart';
import 'package:savekart/widgets/login_page.dart';
import 'package:savekart/widgets/otpscreen.dart';

import '../customwidget/CustomTextformfield.dart';
import '../domain/User.dart';
import '../domain/profile_data_entity.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class CreateAccount extends StatefulWidget {

  CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  bool is_checked = false;
  TextEditingController name = TextEditingController();
   TextEditingController email = TextEditingController();
    TextEditingController Password = TextEditingController();
     TextEditingController confirmpassword = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  final PasswordController = TextEditingController();

  CountryListData? selectedCountry;
  String selected_countryid="0";
  StateListData? selectedState;
  String selectedstateid="0";

   List<CountryListData> countries = [];
    List<StateListData> states = [];
  String? selectedOption="Yes"; // Stores the selected radio button value
  TextEditingController promoController = TextEditingController();
 bool isvalidatecoupon=false;
  ProfileDataEntity profileDataEntity=new ProfileDataEntity();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountry();

  }


  @override
  Widget build(BuildContext context) {
    
  
    var controller;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff0B7D97),
        title: Text(
          "Create Your account",
          style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 15:18, fontWeight: FontWeight.normal,color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                   height: ResponsiveInfo.isMobile(context)? 8:12,
              ),

              Padding(
                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),
                child: Text("Name",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15),),
              ),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              CustomTextFormfield(
                labelText: 'Enter your name',


                ontap: () {},
                isobscure: false, controller: name, isnumber: false,),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              SizedBox(  height: ResponsiveInfo.isMobile(context)? 8:12,),
              Padding(
                padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 8:12,),
                child: Text("Email",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15),),
              ),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              CustomTextFormfield(
                labelText: "xxxxx@gmail.com",
                controller:email,

                ontap: () {},
                isobscure: true, isnumber: false,),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              Padding(
                padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 8:12,),
                child: Text("Mobile number",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15),),
              ),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              CustomTextFormfield(
                labelText: "Enter your mobile number",
                controller: mobilenumber,

                ontap: () {},
                isobscure: false, isnumber: true,),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              Padding(
                padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 8:12),
                child: Text("Country",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15)),
              ),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),

              (countries.length>0)?  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
              child:    SizedBox(
                height:ResponsiveInfo.isMobile(context)? 60 :80, // Specific height
                child: DropdownButtonFormField<CountryListData>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Country",
                    contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  ),
                  value: selectedCountry,
                  items: countries.map((CountryListData country) {
                    return DropdownMenuItem<CountryListData>(
                      value: country,
                      child: Text(country.countryName.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?13:17)),
                    );
                  }).toList(),
                  onChanged: (CountryListData? value) {
                    setState(() {
                      selectedCountry = value;
                      selected_countryid=value!.id.toString();
                      selectedState = null; // Reset state selection
                    });
                  },
                ),
              ),) : Container(),

              Padding(
                padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 8:12),
                child: Text("State",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15)),
              ),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),

              (states.length>0)?  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                child:
                SizedBox(
                  height:ResponsiveInfo.isMobile(context)? 60 :80, // Specific height
                  child: DropdownButtonFormField<StateListData>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Select State",

                    ),
                    value: selectedState,
                    items: selectedCountry != null
                        ? states!.map((StateListData state) {
                      return DropdownMenuItem<StateListData>(
                        value: state,
                        child: Text(state.stateName.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?13:17),),
                      );
                    }).toList()
                        : [],
                    onChanged: (StateListData? value) {
                      setState(() {
                        selectedState = value;
                        selectedstateid=value!.id.toString();
                      });
                    },
                  ),
                ),
              ) : Container(),
              Text(
                "Do you have a promotional code?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Radio buttons
              Row(
                children: [
                  Radio<String>(
                    value: "Yes",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  Text("Yes"),
                  SizedBox(width: 20),
                  Radio<String>(
                    value: "No",
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),
                  Text("No"),
                ],
              ),

              SizedBox(height: ResponsiveInfo.isMobile(context)?8:12),

              // Show TextField & Button only if "Yes" is selected
              if (selectedOption == "Yes") ...[
                TextField(
                  controller: promoController,
                  decoration: InputDecoration(
                    hintText: "Enter promo code",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.card_giftcard),
                  ),
                ),
                       SizedBox(height: ResponsiveInfo.isMobile(context)?8:12),

                ElevatedButton(
                  onPressed: () {
                 validateCoupon();
                  },
                  child: Text("Validate Code",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full-width button
                  ),
                ),
              ],

              Padding(
                padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 8:12),
                child: Text("Password",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15)),
              ),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              CustomTextFormfield(
                labelText: "**********",
                controller: Password,

                ontap: () {},
                isobscure: true, isnumber: false,),
              SizedBox(
                height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              Padding(
                padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 8:12,),
                child: Text("Confirmpassword",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:15)),
              ),
              SizedBox(
               height: ResponsiveInfo.isMobile(context)? 8:12,
              ),
              CustomTextFormfield(
                labelText: "*********",
                controller: confirmpassword,

                ontap: () {},
                isobscure: true, isnumber: false,),



              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Checkbox(

                        value: is_checked,
                        onChanged: (val){
                          setState(() {
                            is_checked=val!;
                          });
                        }),
                    Text(" I understand the "),
                    Text("terms&policy",style: TextStyle(color: Color(0xff0B7D97)),)
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0B7D97), // background
                    foregroundColor: Colors.white, // foreground
                  ),
                  onPressed: () {

                    if(name.text.isNotEmpty)
                      {
                        if(email.text.isNotEmpty)
                        {

                          if(mobilenumber.text.isNotEmpty)
                          {

                            bool iscountrycheckmobile=true;

                            if(selectedCountry!.id==1)
                            {
                              if(mobilenumber.text.length==10)
                              {

                                iscountrycheckmobile=true;
                              }
                              else{

                                iscountrycheckmobile=false;
                              }


                            }
                            else{

                              iscountrycheckmobile=true;

                            }


                              bool isvalid_couponcode=false;

                              if(selectedOption.toString().compareTo("Yes")==0)
                              {
                                if(isvalidatecoupon)
                                {

                                  isvalid_couponcode=true;
                                }
                                else{

                                  isvalid_couponcode=false;

                                }




                              }
                              else{

                                isvalid_couponcode=true;

                              }


                              if(iscountrycheckmobile)
                                {

                                  if(isvalid_couponcode)
                                    {

                                      if (!Password.text.toString().isEmpty) {

                                        if (Password.text.toString().length >= 8) {

                                          if (Password.text.toString().compareTo(confirmpassword.text.toString())==0) {





                                              if (is_checked) {




                                                User user = new User();
                                                user.email=email.text.toString().trim();
                                                user.name=name.text.toString().trim();
                                                user.password=Password.text.toString().trim();
                                                user.phone=mobilenumber.text.toString().trim();


                                                  user.stateid=selectedstateid;

                                                user.countryid=selected_countryid;
                                                user.language="en";
//                                                            if (sponsor_exist != null) {

                                                user.sponsor=profileDataEntity;
                                                //   }


                                                getUserDetailsByMobile(user);

                                              } else {

                                                // Toast.makeText(RegistrationActivity.this, "Please agree the terms and conditions", Toast.LENGTH_SHORT).show();
                                                ResponsiveInfo.showAlertDialog(context, "", "Please check our terms and conditions");
                                              }





                                          } else {

                                            //   Toast.makeText(RegistrationActivity.this, "password confirmation failed", Toast.LENGTH_SHORT).show();


                                            ResponsiveInfo.showAlertDialog(context, "", "Password Confirmation failed");
                                          }


                                        } else {

                                          //    Toast.makeText(RegistrationActivity.this, "Password must have atleast 8 characters", Toast.LENGTH_SHORT).show();
                                          ResponsiveInfo.showAlertDialog(context, "", "Password must have atlease 8 characters");
                                        }


                                      } else {

                                        //  Toast.makeText(RegistrationActivity.this, "Enter a password", Toast.LENGTH_SHORT).show();
                                        ResponsiveInfo.showAlertDialog(context, "", "Enter Password");
                                      }


                                    }
                                  else{

                                    ResponsiveInfo.showAlertDialog(context, "", "Click validate button to check if coupon code is valid , or click 'No' if you do not have coupon code");

                                  }



                                }
                              else{

                                ResponsiveInfo.showAlertDialog(context, "", "Enter 10 digit mobile number for country india");


                              }





                          }
                          else{

                            ResponsiveInfo.showAlertDialog(context, "", "Enter mobile number");
                          }

                        }
                        else{

                          ResponsiveInfo.showAlertDialog(context, "", "Enter email");
                        }


                      }
                    else{

                      ResponsiveInfo.showAlertDialog(context, "", "Enter name");
                    }



                  },
                  child: Text('SIGN UP',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:18),),
                ),
              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text("Do you have an account?",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:18)),

                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder:
                            (context) =>
                            LoginPage()
                        )
                    );

                  }, child:Text("SIGN IN ",style: TextStyle(color: Color(0xff0B7D97)),) )
                ],
              ),

            ],
          ) ,
          padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),
        )


       ,
      ),
    );
  }

  getCountry()
  async {

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getCountry+"?q="+t.toString());


    var js= jsonDecode(response);

    CountryListEntity entity=CountryListEntity.fromJson(js);
    if(entity.status==1)
      {
        setState(() {
          countries.clear();
          countries.addAll(entity.data!);
          if(countries.length>0) {
            selectedCountry = countries[0];
            selected_countryid=countries[0].id.toString();
            getState();
          }
        });
      }


  }


  getState()
  async {

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getState+"?q="+t.toString()+"&countryid="+selected_countryid.toString());


    var js= jsonDecode(response);

    StateListEntity entity=StateListEntity.fromJson(js);

    if(entity.status==1)
      {

        if(entity.data!.length>0)
          {

            setState(() {

              states.clear();
              states.addAll(entity.data!);

              if(states.length>0)
                {

                  selectedState=states[0];
                  selectedstateid=selectedState!.id.toString();
                }

            });

          }


      }


  }

  validateCoupon()async
  {
    if(promoController.text.isNotEmpty) {
      ResponsiveInfo.ShowProgressDialog(context);
      EcommerceApiHelper apihelper = new EcommerceApiHelper();

      var t = EcommerceApiHelper.getTimeStamp();

      var response = await apihelper.get(
          Apimethodes.getCouponcodeData + "?q=" + t.toString() + "&coupon=" +
              promoController.text.toString());

      Navigator.pop(context);

      var js = jsonDecode(response);

      ProfileDataEntity p = ProfileDataEntity.fromJson(js);

      if (p.status == 1) {
        isvalidatecoupon = true;
        profileDataEntity = p;
      }
      else {
        isvalidatecoupon = false;
      }
    }
    else{

      ResponsiveInfo.showAlertDialog(context, "", "Enter valid promo code");

    }


  }

  getUserDetailsByMobile(User user)async
  {
    ResponsiveInfo.ShowProgressDialog(context);
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getUserByMobile+"?q="+t.toString()+"&mobile="+user.phone);
    Navigator.pop(context);

    var js= jsonDecode(response) ;

    ProfileDataEntity entity=ProfileDataEntity.fromJson(js);

    if(entity.status==0)
    {

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder:
              (context) =>
              OTPScreen(user)
          )
      );
    }
    else{

      ResponsiveInfo.showAlertDialog(context, "", "This mobile number is  exists");
    }


  }





}
