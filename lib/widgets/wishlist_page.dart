import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';

import '../domain/wish_list_product_entity.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  // Sample wishlist data
  List<WishListProductData> wishlistItems = [];

  // Remove item from wishlist
  void removeItem(int index) {
    setState(() {
      wishlistItems.removeAt(index);
    });
  }


  deleteProductFromWishlist(String wishlist_id,int index)async
  {
    ResponsiveInfo.ShowProgressDialog(context);

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();
    Map<String,String>mp=new HashMap();
    mp['id']=wishlist_id;


    var response= await  apihelper.post(Apimethodes.deleteFromWishlist+"?q="+t.toString(),formDataPayload: mp);

    String fullString=response.toString();
    if (fullString.startsWith("\"") && fullString.endsWith("\"")) {
      fullString = fullString.substring(1, fullString.length - 1)
          .replaceAll("\\\"", "\"");
    }
    var js= jsonDecode( fullString) ;
    Navigator.pop(context);

    if(js['status']==1)
    {

removeItem(index);
    }
    else{
      ResponsiveInfo.showAlertDialog(context, "", "Something went wrong");
    }




  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:16),),
        backgroundColor: Color(0xff0B7D97),
      ),
      body: wishlistItems.isEmpty
          ? Center(child: Text('Your wishlist is empty!'))
          : ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];

          return




            Card(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 3,
            child: ListTile(
              leading: Image.network(EcommerceApiHelper.productimageurl+item.primeImage.toString(), width:ResponsiveInfo.isMobile(context)? 60:75, height: ResponsiveInfo.isMobile(context)? 60:75, fit: BoxFit.cover),
              title: Text(item.productName.toString(), style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.price.toString(), style: TextStyle(color: Colors.green)),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: (){
                  deleteProductFromWishlist(item.wishlistid.toString(), index);
                }
              ),
            ),
          );
        },
      ),
    );
  }

  getWishList()async{

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getWishlistdata+"?q="+t.toString());

    var js= jsonDecode( response) ;
    WishListProductEntity entity=WishListProductEntity.fromJson(js);

    if(entity.status==1)
      {

        setState(() {
          wishlistItems.addAll(entity.data!);
        });


      }


  }





}


