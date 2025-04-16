
import 'package:flutter/material.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/Product.dart';



class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback toggleWishlist;

  ProductCard({required this.product, required this.toggleWishlist});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:Container(
        width: double.infinity,
        height: ResponsiveInfo.isMobile(context)?180:220,
        child: Card(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(product.image, fit: BoxFit.fill, height: ResponsiveInfo.isMobile(context)?120:140),
                  Padding(
                    padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?5.0:  8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            Text('${product.rating}'),
                            Text('(${product.reviews} reviews)'),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    product.isWishlisted
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color:
                    product.isWishlisted ? Colors.red : Colors.grey,
                  ),
                  onPressed: toggleWishlist,
                ),
              ),
            ],
          ),
        ),

      ) ,
      onTap: (){

        // Navigator.push(context,
        //     MaterialPageRoute(builder:
        //         (context) =>
        //         ProductDetailsPage()
        //     )
        // );
      },
    )



      ;
  }
}
