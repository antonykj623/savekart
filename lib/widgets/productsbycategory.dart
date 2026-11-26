import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:savekart/design/ResponsiveInfo.dart';
import 'package:savekart/widgets/product_details.dart';

import '../../domain/products_entity.dart';
import '../../web/apimethodes.dart';
import '../../web/ecommerce_api_helper.dart';
import '../domain/product_sub_category_entity.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String categoryId;
  final String categoryname;

  const ProductsByCategoryScreen({
    super.key,
    required this.categoryId,
    required this.categoryname,
  });

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  static const Color primaryTeal = Color(0xFF0B7D97);
  static const Color surfaceBg = Color(0xFFF6F8FA);

  List<ProductsData> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts(widget.categoryId);
  }

  Future<void> fetchProducts(String categoryId) async {
    if (mounted) {
      setState(() => isLoading = true);
    }
    try {
      final apiHelper = EcommerceApiHelper();
      final response = await apiHelper.get(
        "${Apimethodes.getProductListBySubcategory}?id=$categoryId&q=${EcommerceApiHelper.getTimeStamp()}",
      );
      final js = jsonDecode(response);
      final productEntity = ProductsEntity.fromJson(js);

      if (!mounted) return;

      if (productEntity.status == 1 && productEntity.data != null) {
        setState(() {
          products = productEntity.data!
              .where((p) => p.status.toString() == "0")
              .toList();
          isLoading = false;
        });
      } else {
        setState(() {
          products = [];
          isLoading = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() => isLoading = false);
    }
  }

  ProductSubCategoryDataData _toSubCategoryProduct(ProductsData pb) {
    final pbc = ProductSubCategoryDataData();
    pbc.id = pb.id;
    pbc.productCode = pb.productCode;
    pbc.primeImage = pb.primeImage;
    pbc.productName = pb.productName;
    pbc.status = pb.status;
    pbc.productSpec = pb.productSpec;
    pbc.productDescription = pb.productDescription;
    pbc.sideImage4 = pb.sideImage4;
    pbc.sideImage3 = pb.sideImage3;
    pbc.sideImage2 = pb.sideImage2;
    pbc.sideImage1 = pb.sideImage1;
    pbc.categoryId = pb.categoryId;
    pbc.color = pb.color;
    pbc.colorEnabled = pb.colorEnabled;
    pbc.size = pb.size;
    pbc.sizeEnabled = pb.sizeEnabled;
    pbc.subCategoryId = pb.subCategoryId;
    pbc.unitId = pb.unitId;
    pbc.vendorId = pb.vendorId;
    return pbc;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveInfo.isMobile(context);

    return Scaffold(
      backgroundColor: surfaceBg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        surfaceTintColor: Colors.white,
        iconTheme: const IconThemeData(color: primaryTeal),
        title: Text(
          widget.categoryname,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isMobile ? 16 : 19,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1D1F),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: primaryTeal))
          : products.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 46,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8),
            const Text(
              "No products available",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        color: primaryTeal,
        onRefresh: () => fetchProducts(widget.categoryId),
        child: GridView.builder(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
            MediaQuery.of(context).size.width < 600 ? 2 : 3,
            childAspectRatio: 0.78,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) =>
              _buildProductCard(products[index], isMobile),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductsData product, bool isMobile) {
    final isOutOfStock = product.currentQty.toString() == "0";

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetails(_toSubCategoryProduct(product)),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: surfaceBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          EcommerceApiHelper.productimageurl +
                              product.primeImage.toString(),
                          fit: BoxFit.contain,
                          loadingBuilder: (_, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: primaryTeal,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (_, __, ___) => const Center(
                            child: Icon(
                              Icons.image_outlined,
                              size: 44,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.productName.toString(),
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 14.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1D1F),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (isOutOfStock)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.shade600,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "Out of stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}