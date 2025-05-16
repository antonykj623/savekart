import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/widgets/product_details.dart';
import '../../web/apimethodes.dart';
import '../../web/ecommerce_api_helper.dart';
import '../../domain/products_entity.dart';
import '../domain/product_by_category_entity.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String categoryname;

  const ProductsByCategoryScreen({Key? key, required this.categoryId,required this.categoryname}) : super(key: key);

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  List<ProductsData> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts(widget.categoryId);
  }

  Future<void> fetchProducts(String categoryId) async {
    setState(() => isLoading = true);

    EcommerceApiHelper apiHelper = EcommerceApiHelper();
    var response = await apiHelper.get("${Apimethodes.getProductsByCategory}?id=$categoryId"+"&q="+EcommerceApiHelper.getTimeStamp());
    var js = jsonDecode(response);
    ProductsEntity productEntity = ProductsEntity.fromJson(js);

    if (productEntity.status == 1) {
      setState(() {
        products = productEntity.data!.where((p) => p.status.toString() == "0").toList();
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryname,style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17,color: Color(0xff0B7D97)),),


      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())  // Show loading indicator
          : products.isEmpty
          ? Center(child: Text("No products available"))
          : Column(

        children: [

          Expanded(
flex: 5,
            child: GridView.builder(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Two products per row
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                    onTap: (){
                      ProductsData pb=product;
                      ProductByCategoryDataData pbc=new ProductByCategoryDataData();
                      pbc.id=pb.id;
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
                    },




                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              EcommerceApiHelper.productimageurl+  product.primeImage.toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child; // Image loaded successfully
                                return Center(child: CircularProgressIndicator()); // Show loader while loading
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  product.productName.toString(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 4),
                                // Text(
                                //   "₹${product.price}",
                                //   style: TextStyle(color: Colors.green, fontSize: 16),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ) );
              },
            ),
          ),
          Expanded(child: Container(),flex: 1,)
        ],
      )




    );
  }
}
