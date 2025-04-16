import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/order_details_entity.dart';
import '../web/AppStorage.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class ReturnProductImagePickerWidget extends StatefulWidget {

  String productid;
  String returnpolicyid;
  OrderDetailsData ordata;
  ReturnProductImagePickerWidget(this.productid,this.returnpolicyid,this.ordata);


  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState(this.productid,this.returnpolicyid,this.ordata);
}

class _ImagePickerWidgetState extends State<ReturnProductImagePickerWidget> {



  String productid;
  String returnpolicyid;
  OrderDetailsData ordata;
  _ImagePickerWidgetState(this.productid,this.returnpolicyid,this.ordata);


  List<File> _selectedImages = []; // Stores selected images

  final ImagePicker _picker = ImagePicker();
  bool isShowresponse=false;

  String Showresponse="";
  TextEditingController promoController=new TextEditingController();

  // Function to pick an image
  Future<void> _pickImage(ImageSource source) async {


      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImages.add(File(pickedFile.path));
        });
      }

  }

  // Function to upload images to the server
  Future<void> _uploadImages() async {

    if(promoController.text.isNotEmpty) {
      setState(() {
        Showresponse = "Uploading Return Requests .....";
      });

      var uri = Uri.parse(EcommerceApiHelper.baseUrldata +
          Apimethodes.uploadReturnProductData); // Replace with your API
      var request = http.MultipartRequest('POST', uri);
      String? token = await AppStorage.getString(AppStorage.token);
      request.headers['Authorization'] = token.toString();

      for (int i = 0; i < _selectedImages.length && i < 3; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'images[]', // Backend expects an array of files
            _selectedImages[i].path,
            filename: basename(_selectedImages[i].path),
          ),
        );
      }

      request.fields['product_id'] = productid;
      request.fields['policy_id'] = returnpolicyid;
      request.fields['order_id'] = ordata.cartOrder!.id.toString();
      request.fields['reason']=promoController.text;

      var response = await request.send();
      if (response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Images uploaded successfully!"),
        // ));
        // ResponsiveInfo.showAlertDialog(context, "", "Return request submitted successfully");

        String a = await response.stream.bytesToString();

        setState(() {
          Showresponse = "Return request submitted successfully";
        });

        // Future.delayed(Duration(seconds: 2),() {
        //  // Navigator.pop(context);
        // },);
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text("Failed to upload images."),
        // ));
        //
        // ResponsiveInfo.showAlertDialog(context, "", "Return request submission failed");
        setState(() {
          Showresponse = "Return request submission failed";
        });
      }
    }
    else{
      setState(() {
        Showresponse = "Please mention your reason for to return the product";
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  AppBar(title: Text("Upload product images ",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?13:15),),
      actions: [
        (_selectedImages.isNotEmpty)?
        ElevatedButton(
          onPressed: _uploadImages,
          child: Text("Upload"),
        ):Container(),
      ],

      ),
      body: Column(
        children: [
          // Buttons for picking images

          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),
            child:  ListTile(
              leading: Image.network(EcommerceApiHelper.productimageurl+ordata.cartProduct!.primeImage.toString(), width:ResponsiveInfo.isMobile(context)? 60:75, height: ResponsiveInfo.isMobile(context)? 60:75, fit: BoxFit.cover),
              title: Text(ordata.cartProduct!.productName.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(ordata.cartStock!.priceSales.toString()+"\n Qty : "+ordata.cartOrder!.quantity.toString()+"", style: TextStyle(color: Colors.green)),

            ),
          ),


          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

              child:  TextField(
                controller: promoController,
                decoration: InputDecoration(
                  hintText: "Enter the reason...",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.card_giftcard),
                ),
              )


          ),


              Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Camera"),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                icon: Icon(Icons.image),
                label: Text("Gallery"),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
            ],
          ),

          // Display selected images in GridView
          SizedBox(
            width: double.infinity,
            height: 300,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _selectedImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Image.file(_selectedImages[index], fit: BoxFit.cover),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _selectedImages.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

            child: Text(Showresponse, style: TextStyle(fontWeight: FontWeight.bold,fontSize: ResponsiveInfo.isMobile(context)?15:19)),

          ),

          // Upload Button

        ],
      ),
    );
  }
}
