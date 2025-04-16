

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../design/ResponsiveInfo.dart';
import 'fragments/Dashboard.dart';
import 'fragments/categories.dart';
import 'fragments/orders.dart';
import 'fragments/profile.dart';

class HomeScreen extends StatefulWidget {





  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _Widgetoptions = <Widget>[
    Dashboard(),
    CategoryProductScreen(),
    Orders(),
   Profile(),
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Expanded(child:  Center(
            child:_Widgetoptions.elementAt(_selectedIndex),
          ),flex: 6,),

          Expanded(child: Container(
    width: double.infinity,
    height: ResponsiveInfo.isMobile(context)?60:75,
    child: BottomNavigationBar(
        unselectedItemColor: Colors.black26,

        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ColorFiltered(
        colorFilter:
        ColorFilter.mode((_selectedIndex==0)?Color(0xff0B7D97): Colors.black26, BlendMode.srcIn),
            child:

            Image.asset("assets/icons/home.png",width: ResponsiveInfo.isMobile(context)?30:40,height: ResponsiveInfo.isMobile(context)?30:40,),

            ),
            label: 'Home',

          ),

          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter:
              ColorFilter.mode((_selectedIndex==1)?Color(0xff0B7D97): Colors.black26, BlendMode.srcIn),
              child:

              Image.asset("assets/icons/category.png",width: ResponsiveInfo.isMobile(context)?30:40,height: ResponsiveInfo.isMobile(context)?30:40,),

            ),
            label: 'Categories',


          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter:
              ColorFilter.mode((_selectedIndex==2)?Color(0xff0B7D97): Colors.black26, BlendMode.srcIn),
              child:

              Image.asset("assets/icons/box.png",width: ResponsiveInfo.isMobile(context)?30:40,height: ResponsiveInfo.isMobile(context)?30:40,),

            ),
            label: 'Orders',

          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter:
              ColorFilter.mode((_selectedIndex==3)?Color(0xff0B7D97): Colors.black26, BlendMode.srcIn),
              child:

              Image.asset("assets/icons/profile.png",width: ResponsiveInfo.isMobile(context)?30:40,height: ResponsiveInfo.isMobile(context)?30:40,),

            ),
            label: 'Profile',

          )

        ],
        selectedLabelStyle: TextStyle(decoration: TextDecoration.none),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff0B7D97),
        iconSize: ResponsiveInfo.isMobile(context)? 30:40,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        elevation: 5
    ),
    )

          ,flex: 1,)

        ],
      )




    );
  }
}