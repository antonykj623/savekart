import 'package:flutter/material.dart';
import '../design/ResponsiveInfo.dart';

class CustomTextFormfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final Function() ontap;
  final bool isnumber;
  final bool isobscure; // Initial value

  const CustomTextFormfield({
    super.key,
    required this.labelText,
    required this.controller,
    required this.ontap,
    required this.isobscure,
    required this.isnumber,
  });

  @override
  State<CustomTextFormfield> createState() => _CustomTextFormfieldState();
}

class _CustomTextFormfieldState extends State<CustomTextFormfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isobscure;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(ResponsiveInfo.isMobile(context) ? 5 : 8),
          ),
          color: const Color.fromARGB(255, 235, 234, 234),
          border: Border.all(
            color: const Color.fromARGB(255, 246, 231, 231),
          ),
        ),
        child: TextFormField(
          obscureText: _obscureText,
          controller: widget.controller,
          keyboardType: widget.isnumber ? TextInputType.number : TextInputType.text,
          onTap: widget.ontap,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: ResponsiveInfo.isMobile(context) ? 10 : 15,
              top: ResponsiveInfo.isMobile(context) ? 10 : 15,
            ),
            border: InputBorder.none,
            hintText: widget.labelText,
            hintStyle: TextStyle(fontSize: ResponsiveInfo.isMobile(context) ? 13 : 17),
            suffixIcon: widget.isobscure
                ? IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
          ),
        ),
      ),
    );
  }
}
