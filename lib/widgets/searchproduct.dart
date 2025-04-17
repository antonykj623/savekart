import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/domain/searched_products_entity.dart';
import 'package:savekart/widgets/product_details.dart';

import '../domain/product_by_category_entity.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController searchController = TextEditingController();


  List<SearchedProductsData>? data = [];

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Search")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search Products",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged:(txt){
                filterProducts(txt.toString());
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: data!.length==0
                  ? Center(child: Text("No products found"))
                  : ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

                  child: Card(

                    child:  ListTile(
                      title: Text(data![index].productName.toString(),style: TextStyle(fontSize: 14),),
                      leading: Padding(




                     padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),
                     child: Image.network(EcommerceApiHelper.productimageurl+data![index].primeImage.toString(),width: ResponsiveInfo.isMobile(context)?70:100,height: ResponsiveInfo.isMobile(context)?90:120,fit: BoxFit.fill,),
                  ), onTap: () {

                      ProductByCategoryDataData pbc=new ProductByCategoryDataData();
                      pbc.id=data![index]!.id;
                      pbc.primeImage=data![index].primeImage;
                      pbc.productName=data![index].productName;
                      pbc.status=data![index].status;
                      pbc.productSpec=data![index].productSpec;
                      pbc.productDescription=data![index].productDescription;
                      pbc.sideImage4=data![index].sideImage4;
                      pbc.sideImage3=data![index].sideImage3;
                      pbc.sideImage2=data![index].sideImage2;
                      pbc.sideImage1=data![index].sideImage1;
                      pbc.categoryId=data![index].categoryId;
                      pbc.color=data![index].color;
                      pbc.colorEnabled=data![index].colorEnabled;
                      pbc.size=data![index].size;
                      pbc.sizeEnabled=data![index].sizeEnabled;
                      pbc.subCategoryId=data![index].subCategoryId;
                      pbc.unitId=data![index].unitId;
                      pbc.vendorId=data![index].vendorId;


                      Navigator.push(context,
                          MaterialPageRoute(builder:
                              (context) =>
                              ProductDetails(pbc)
                          )
                      );

                      },
                    ),
                  ),
                  )

                   ;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  filterProducts(String query) async {


    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getSearchedProducts+"?q="+t.toString()+"&word="+query);

    var js= jsonDecode( response);

    SearchedProductsEntity entity=SearchedProductsEntity.fromJson(js);

    if(entity.status==1)
    {

      setState(() {
        data!.clear();
        data!.addAll(entity.data!);
      });
    }

  }
}
