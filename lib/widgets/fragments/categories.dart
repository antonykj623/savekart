import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/app_version_entity.dart';
import '../../domain/category_entity.dart';

import '../../domain/product_by_category_entity.dart';
import '../../domain/product_sub_category_entity.dart';
import '../../domain/products_entity.dart';
import '../../web/apimethodes.dart';
import '../../web/ecommerce_api_helper.dart';
import '../product_details.dart';

class CategoryProductScreen extends StatefulWidget {
  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreenState();
}

class _CategoryProductScreenState extends State<CategoryProductScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CategoryData> categories = [];
  List<ProductsData> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    getAppUpdates();
  }

  getAppUpdates()async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();


    String version = packageInfo.version;


    EcommerceApiHelper apihelper=new EcommerceApiHelper();
    var t=EcommerceApiHelper.getTimeStamp();
    var response1= await  apihelper.get(Apimethodes.getCartUpdate+"?q="+t.toString());
    AppVersionEntity appversion=AppVersionEntity.fromJson(jsonDecode(response1));
    if(appversion.status==1) {

      double currentversion=double.parse(version);
      String versionfromserver=appversion.data!.version.toString();
      double appversionfromserver=double.parse(versionfromserver);

      if (appversionfromserver>currentversion) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              AlertDialog(
                title: Text("App Version"),

                content: Text("New version: $versionfromserver is available"),
                actions: [
                  (appversionfromserver > currentversion) ? TextButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.integra.savekart"); // Change URL based on platform

                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                            url, mode: LaunchMode.externalApplication);
                      } else {
                        throw "Could not launch $url";
                      }
                    },
                    child: Text("Update"),
                  ) : Container(),

                ],
              ),
        );
      }
    }

  }

  fetchCategories() async {
    EcommerceApiHelper apiHelper = EcommerceApiHelper();
    var response = await apiHelper.get(Apimethodes.getCategories);
    var js = jsonDecode(response);
    CategoryEntity categoryEntity = CategoryEntity.fromJson(js);

    if (categoryEntity.status == 1) {
      setState(() {

        for(int i=0;i<categoryEntity.data!.length;i++)
        {
          if(categoryEntity.data![i].status.toString().compareTo("0")==0)
          {
            categories.add(categoryEntity.data![i]);
          }

        }
        // categories = categoryEntity.data!;
        _tabController = TabController(length: categories.length, vsync: this);
      });

      // Fetch products for the first category by default
      fetchProducts(categories.first.id.toString());
    }
  }

  fetchProducts(String categoryId) async {
    setState(() => isLoading = true);
    EcommerceApiHelper apiHelper = EcommerceApiHelper();
    var t=EcommerceApiHelper.getTimeStamp();
    var response = await apiHelper.get("${Apimethodes.getProductsByCategory}?id=$categoryId"+"&q="+t);
    var js = jsonDecode(response);
    ProductsEntity productEntity = ProductsEntity.fromJson(js);

    if (productEntity.status == 1) {
      setState(() {

        products.clear();

        for(int i=0;i<productEntity.data!.length;i++)
          {
            if(productEntity.data![i].status.toString().compareTo("0")==0)
              {

                products.add(productEntity.data![i]);
              }
          }


        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17),),),
      body: categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          // Dynamic Category Tabs
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: Color(0xff0B7D97),
              labelColor: Color(0xff0B7D97),
              unselectedLabelColor: Colors.grey,
              tabs: categories.map((category) => Tab(text: category.categoryName)).toList(),
              onTap: (index) => fetchProducts(categories[index].id.toString()),
            ),
          ),

          // Product List
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : products.isEmpty
                ? Center(child: Text("No products found"))
                : GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.9,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductsData product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        ProductsData pb=product;
        ProductSubCategoryDataData pbc=new ProductSubCategoryDataData();
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

      child:
      Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(EcommerceApiHelper.productimageurl + product.primeImage.toString(), height: 100, fit: BoxFit.cover,loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child; // Image loaded successfully
            return Center(child: CircularProgressIndicator()); // Show loader while loading
          },
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
            },),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.productName.toString(), maxLines: 2, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          // Text("\$${product.price}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    ) );
  }
}
