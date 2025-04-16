import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Sliderp extends StatefulWidget {
  const Sliderp({super.key});

  @override
  State<Sliderp> createState() => _SliderpState();
}

class _SliderpState extends State<Sliderp> {
  final List<String>imagepath =[
     'assets/bricksnmixlogo.jpg',
    ' assets/bricksnmixlogo-removebg-preview.png',
    ' assets/bricksnmixlogo.jpg',

  ];
  late List<Widget>_Pages;
  int _activepages = 0;
 @override
 void initState(){
  super.initState();
  _Pages = List.generate( 
    imagepath.length,(index)=>
    ImagePlaceorder(
      imagepath: imagepath[index],
    ));
 }
  
  
  @override
  
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
         SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: PageView.builder(
          itemCount: imagepath.length,
          itemBuilder:(context,index){
            //return image widget
            return _Pages[index];
          },
          
          
           ),
         ),
         Positioned(
          bottom: 10,
          left: 0,
          right: 0,
           child: Container(
            color: Color.fromARGB(0, 172, 38, 38),
            child:Row(children: List<Widget>.generate(
              _Pages.length,
              (index)=>Padding(
                padding: const EdgeInsets.only(left:100),
                child: CircleAvatar(
                  radius:4 ,
                  backgroundColor:Colors.amber,
                ),
              )
            
            ),) ,
           ),
         ),
      ],
    );
  }
} 

class ImagePlaceorder extends StatelessWidget {
   
   ImagePlaceorder({super.key, this.imagepath});
   final String?  imagepath;
 

  @override
  Widget build(BuildContext context) {
    return Image.asset(
     imagepath!,
      fit: BoxFit.cover,
    
    );
  }
}