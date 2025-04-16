import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:savekart/design/ResponsiveInfo.dart';

import '../domain/profile_data_entity.dart';
import '../web/AppStorage.dart';
import '../web/api_helper.dart';
import '../web/apimethodes.dart';

import 'package:http/http.dart' as http;




class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  String profileImageUrl = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with some default values
getProfile();
  }

  // Function to pick or change profile image
  void _changeProfileImage() {
    // Here you would integrate your image picker logic
    // For now, just simulate a change
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Stack(
              children: [

                Align(
                  alignment: FractionalOffset.center,
                  child:             (profileImageUrl.isNotEmpty)? GestureDetector(
                    onTap: _changeProfileImage, // Allow image change on tap
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage:  NetworkImage(profileImageUrl)
                    ),
                  ) :
                  GestureDetector(
                    onTap: _changeProfileImage, // Allow image change on tap
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage:  AssetImage('assets/profileplaceholder.png')
                    ),
                  ),
                ),

                Align(
                  alignment: FractionalOffset.topCenter,

                  child: Padding(

                    child: Container(
                      width: ResponsiveInfo.isMobile(context)?150:180,
                      height: ResponsiveInfo.isMobile(context)?50:65,
                      color: Colors.white60,
                      child:Stack(

                        children: [
                          Align(
                            alignment: FractionalOffset.center,
                            child:  TextButton(
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                XFile? image = await _picker.pickImage(source: ImageSource.gallery);

                                if (image != null) {
                                  File selectedImage = File(image.path);


                                  uploadProfilePhoto(selectedImage);
                                }


                              },
                              child: Text("Edit"),

                            ) ,
                          )
                        ],
                      )


                     ,


                    )


                   ,
                    padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  )




                )
              ],
            ),




            SizedBox(height: 16),
            // Name field
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Email field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Phone number field (non-editable)
            TextField(
              enabled: false, // Disable editing
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
              controller: TextEditingController(text: phoneNumber),
            ),
            SizedBox(height: 16),
            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

              child: Container(
                width: ResponsiveInfo.isMobile(context)?150:180,
                height: ResponsiveInfo.isMobile(context)?60:70,
                color: Colors.indigo,
                child:    TextButton(
                  onPressed: () async {

                    if(nameController.text.toString().isNotEmpty)
                      {
                        if(emailController.text.toString().isNotEmpty)
                        {

                          updateProfileDetails();

                        }
                        else
                        {

                          ResponsiveInfo.showAlertDialog(context, "", "Enter email");
                        }

                      }
                    else
                      {

                        ResponsiveInfo.showAlertDialog(context, "", "Enter name");
                      }



                  },
                  child: Text("Update",style: TextStyle(color: Colors.white,fontSize: ResponsiveInfo.isMobile(context)?14:16),),

                ) ,
              ),

            )

          ],
        ),
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
        nameController.text=entity.data!.fullName.toString();
        emailController.text=entity.data!.emailId.toString();
        usernameController.text=entity.data!.username.toString();
        phoneNumber=entity.data!.mobile.toString();
        profileImageUrl=ApiHelper().imgbaseurl+entity.data!.profileImage.toString();

      });

    }

  }

  updateProfileDetails() async
  {
    ResponsiveInfo.ShowProgressDialog(context);

    Map<String,String> m=new HashMap();
    m['name']=nameController.text;
    m['user_email']=emailController.text;
    m['timestamp']=ResponsiveInfo.getRandomNumber().toString();


    ApiHelper apihelper = new ApiHelper();

    var response= await  apihelper.post(Apimethodes.UserProfileUpdate,formDataPayload: m);

    print(response.toString());

    Navigator.pop(context);
    getProfile();


  }





  uploadProfilePhoto(File imageFile)
  async {

    ResponsiveInfo.ShowProgressDialog(context);

    var stream = new http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();

    var uri = Uri.parse('https://mysaving.in/IntegraAccount/api/'+Apimethodes.uploadUserProfile);

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: imageFile.path.split('/').last);
    //contentType: new MediaType('image', 'png'));

    String? token= await AppStorage.getString(AppStorage.token);
    request.headers.addAll({"Authorization" : token.toString()});


    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });

    Navigator.pop(context);



    getProfile();


  }



}
