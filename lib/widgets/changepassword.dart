import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';



class ChangePasswordScreen extends StatefulWidget {

  String mobile;

  ChangePasswordScreen(this.mobile);



  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState(this.mobile);
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {





  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  String mobile;

  _ChangePasswordScreenState(this.mobile);

  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {

      ResponsiveInfo.ShowProgressDialog(context);


      Map<String,String> params=new HashMap();
      params["mobile"]=mobile;
      params["password"]=_confirmPasswordController.text;
      params["timestamp"]=EcommerceApiHelper.getTimeStamp();

      EcommerceApiHelper apihelper = new EcommerceApiHelper();

      var t=EcommerceApiHelper.getTimeStamp();

      var response= await  apihelper.post(Apimethodes.changePassword+"?q="+t.toString()+"&mobile="+mobile,formDataPayload: params);
      Navigator.pop(context);

      var js= jsonDecode(response) ;

      if(js['status']==1)
        {

Navigator.pop(context);
        }






      // Handle password update logic (e.g., API call)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change Password")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPasswordField("New Password", _newPasswordController, _obscureNew, () {
                setState(() => _obscureNew = !_obscureNew);
              }),
              SizedBox(height: 10),
              _buildPasswordField("Confirm Password", _confirmPasswordController, _obscureConfirm, () {
                setState(() => _obscureConfirm = !_obscureConfirm);
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text("Change Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool obscureText, VoidCallback toggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
          onPressed: toggleVisibility,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (label == "Confirm Password" && value != _newPasswordController.text) {
          return "Passwords do not match";
        }
        if (label == "New Password" && value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }
}
