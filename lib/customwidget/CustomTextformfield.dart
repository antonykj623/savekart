
import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';


class CustomTextFormfield extends StatelessWidget {
  CustomTextFormfield({
    super.key,
    required this.labelText,
    required this.controller,
    required this.ontap,
    required this.isobscure,
    required this.isnumber
  });
  TextEditingController controller = TextEditingController();
  final String labelText;
  final Function() ontap;
  final bool isobscure;
  final bool isnumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)?5:8)),
          color:Color.fromARGB(255, 235, 234, 234),
          border: Border.all(color: Color.fromARGB(255, 246, 231, 231),
          )
        ),
       
        
        child: TextFormField(
          obscureText: isobscure,
          controller: controller,
          keyboardType: (isnumber)?TextInputType.number: TextInputType.text,

          decoration: InputDecoration(
            
              contentPadding: EdgeInsets.only(left:ResponsiveInfo.isMobile(context)? 10:15, top:ResponsiveInfo.isMobile(context)? 10:15),
              
              border: InputBorder.none,
              hintText: labelText,
              hintStyle:  TextStyle(fontSize: ResponsiveInfo.isMobile(context)?13:17)

              
              ),
        ),
      ),
    );
  }
}
