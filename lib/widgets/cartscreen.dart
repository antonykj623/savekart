import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/widgets/placeorder.dart';
import 'package:savekart/widgets/product_details.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/cart_products_entity.dart';
import '../domain/product_details_entity.dart';
import '../domain/product_sub_category_entity.dart';
import '../web/AppStorage.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class CartScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CartScreen> {


  List<CartProductsData> cartItems = [];
  double fulltotal=0;

   _calculateSubtotal() {

    double t=0;
    fulltotal=0;

    for(int i=0;i<cartItems.length;i++)
      {
        if(cartItems[i].pointsRedeemed.toString().compareTo("1")==0)
          {
            t=t+(double.parse(cartItems[i].price.toString()) * double.parse(cartItems[i].quantity.toString())   );
          }
        else{
          t=t+(double.parse(cartItems[i].savekartprice.toString()) * double.parse(cartItems[i].quantity.toString()));
        }
      }
    print(t);

    setState(() {
      fulltotal=t;
    });




  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0B7D97),
        title: Text("Cart",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Colors.white),),
      ),
      body: Column(
        children: [
          (cartItems.length>0)?  Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Container(
                    width: double.infinity,
                    height: ResponsiveInfo.isMobile(context)?180:230,
                    color: Colors.white60,
                    child:Column(

                      children: [
                        Expanded(child: ListTile(
                          leading: GestureDetector(

                        child:Image.network(EcommerceApiHelper.productimageurl+cartItems[index].primeImage.toString(),width: ResponsiveInfo.isMobile(context)?50:60,
                          height: ResponsiveInfo.isMobile(context)?50:60,fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child; // Image loaded successfully
                            return Center(child: CircularProgressIndicator()); // Show loader while loading
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                          },

                        ),
                            onTap: () async {

                          ResponsiveInfo.showLoaderDialog(context);

                              EcommerceApiHelper apihelper = new EcommerceApiHelper();

                              var t = EcommerceApiHelper.getTimeStamp();

                              var response = await apihelper.get(
                                  Apimethodes.getProductDetails + "?id=" +
                                      item.product_id.toString() + "&q=" + t.toString());

                              Navigator.pop(context);

                              print(response);

                              var js = jsonDecode(response);

                              ProductDetailsEntity pbc1=ProductDetailsEntity.fromJson(js);

                              if(pbc1.status==1)
                                {
                                  ProductDetailsData pb=pbc1!.data![0];

                                  ProductSubCategoryDataData pbc=new ProductSubCategoryDataData();
                                  pbc.id=pb.id;
                                  pbc.productCode=pb.productCode;
                                  pbc.primeImage=pb.primeImage;
                                  pbc.productName=pb.productName;
                                  pbc.status=pb.status;
                                  pbc.productSpec=pb.productSpec;
                                  pbc.productDescription=pb.productDescription;
                                  pbc.sideImage4=pb.sideImage4;
                                  pbc.sideImage3=pb.sideImage3;
                                  pbc.sideImage2=pb.sideImage2;
                                  pbc.sideImage1=pb.sideImage1;
                                  pbc.categoryId=pb.categoryId;
                                  pbc.color=pb.color;
                                  pbc.colorEnabled=pb.colorEnabled;
                                  pbc.size=pb.size;
                                  pbc.sizeEnabled=pb.sizeEnabled;
                                  pbc.subCategoryId=pb.subCategoryId;
                                  pbc.unitId=pb.unitId;
                                  pbc.vendorId=pb.vendorId;

                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          ProductDetails(pbc)
                                      )
                                  );

                                }



                            },
                    )

                          ,
                          title: Text(item.productName.toString()+"\n"+item.size.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:16,color: Colors.black,),maxLines: 3,),
                          subtitle: Text( (item.pointsRedeemed.toString().compareTo("1")==0) ? item.price.toString()   :   item.savekartprice.toString()+"\n"
                          ),
                          trailing: QuantitySelector(
                            quantity: int.parse(item.quantity.toString()) ,
                            cartProductsData: item,
                            onQuantityChanged: (newQuantity) {



                              updateCartQuantity(item.cartid.toString(), newQuantity.toString(),index);

                              setState(() {
                                item.quantity=newQuantity.toString();
                              });





                            },
                          ),
                        ),flex: 1,),

                        Expanded(child: Stack(

                          children: [

                            Align(
                              alignment: FractionalOffset.center,
                              child:    ElevatedButton(

                                onPressed: () {
                                  // Handle checkout

                                  Widget okButton = TextButton(
                                    child: Text("Yes"),
                                    onPressed: () {

                                      Navigator.pop(context);

                                      deleteFromCart(cartItems[index].cartid.toString(), index);

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
                                    content: Text("Do you want to delete this product from cart ?"),
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


                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                                  textStyle: TextStyle(fontSize: 16),
                                ),

                                child: Text("Delete"),
                              ),
                            )
                          ],

                        ),flex: 1,)


                      ],
                    ) ,

                  )



                );
              },
            ),
            flex: 2,
          ) :

          Padding(

            padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height/2),
            child: Stack(
                children:[

                  Align(
                    alignment: FractionalOffset.center,
                    child:
                  Text("No Data Found",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),)
                  )



                ]
            ),
          )

          ,
          Expanded(child: (cartItems.length>0)?

       Container(

         child: Card(

           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                       "Total",
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                     Text(
                       fulltotal.toStringAsFixed(2),
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                     ),
                   ],
                 ),
                 SizedBox(height: 25),
                 ElevatedButton(

                   onPressed: () {
                     // Handle checkout

                     double c= double.parse(fulltotal.toStringAsFixed(2))  ;

                     Navigator.push(context,
                         MaterialPageRoute(builder:
                             (context) =>
                             PlaceOrderWidget( c )
                         )
                     );
                   },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xff0B7D97),

                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                     textStyle: TextStyle(fontSize: 16,color: Colors.white)
                     ,
                   ),
                   child: Text("Proceed to Checkout",  style: TextStyle(fontSize: 16,color: Colors.white)),
                 ),
               ],
             ),
           ),

         ),
         width: double.infinity,
         height: double.infinity,
       )



           :Container(),flex: 1,)



          ,
        ],
      ),
    );
  }


  getCartItems()async
  {

    WidgetsBinding.instance.addPostFrameCallback((_) async {

      ResponsiveInfo.showLoaderDialog(context);
    });


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getCartData+"?q="+t.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) async {

  Navigator.pop(context);
    });
    var js= jsonDecode( response) ;
    CartProductsEntity entity=CartProductsEntity.fromJson(js);
    if(entity!.status==1)
      {

        setState(() {
          cartItems.clear();
          cartItems.addAll(entity!.data!);

        });


        _calculateSubtotal();

      }


  }

  updateCartQuantity(String id,String quantity,int index)async{




    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    Map<String,String> mp=new HashMap();
    mp['id']=id;
    mp['quantity']=quantity;


    var response= await  apihelper.post(Apimethodes.updateQuantity+"?q="+t.toString(),formDataPayload: mp);

    print(response);

    var js= jsonDecode( jsonDecode(response) ) ;

    if(js['status']==1) {
      _calculateSubtotal();
    }
    else{

      setState(() {
        cartItems[index].quantity=(int.parse(quantity)-1).toString();
      });

      ResponsiveInfo.showAlertDialog(context, "SaveKart", js['message']);
    }


  }
  
  deleteFromCart(String id,int index)async
  {

    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    Map<String,String> mp=new HashMap();
    mp['id']=id;



    var response= await  apihelper.post(Apimethodes.deleteFromCart+"?q="+t.toString(),formDataPayload: mp);


    var js= jsonDecode( jsonEncode(response) ) ;

    if(cartItems[index].pointsRedeemed.toString().compareTo("1")==0)
      {

       String? current_temp_walletpoints= await AppStorage.getString(AppStorage.current_wallet_point);

       if(current_temp_walletpoints!=null)
         {

           if(current_temp_walletpoints.toString().isNotEmpty)
             {


               double d=double.parse(current_temp_walletpoints);


             }


         }



      }



    setState(() {
      cartItems.removeAt(index);
    });
_calculateSubtotal();
    getCartItems();
    
  }



}





class QuantitySelector extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final CartProductsData cartProductsData;

  QuantitySelector({required this.quantity, required this.onQuantityChanged,required this.cartProductsData});

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int _currentQuantity;
  late CartProductsData _cartProductsData;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.quantity;
    _cartProductsData=widget.cartProductsData;
  }

  void _incrementQuantity() {

    int currentstock=int.parse(_cartProductsData.current_qty.toString());




    if(currentstock>=_currentQuantity) {
      setState(() {
        _currentQuantity++;
      });
      widget.onQuantityChanged(_currentQuantity);
    }
    else{
      // setState(() {
      //   _currentQuantity--;
      // });
      widget.onQuantityChanged(_currentQuantity);
      ResponsiveInfo.showAlertDialog(context, "SaveKart", "Out of stock");
    }
  }

  void _decrementQuantity() {
    if (_currentQuantity > 1) {
      setState(() {
        _currentQuantity--;
      });
      widget.onQuantityChanged(_currentQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: _decrementQuantity,
        ),
        Text(_currentQuantity.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _incrementQuantity,
        ),
      ],
    );
  }
}
