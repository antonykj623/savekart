import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
   OrderInfo() ;

   @override
   Widget build(BuildContext context) {
     return Card(
       elevation: 4,
       child: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Order Id: 12347576585AF'),
                 Text("sub Total:\$ 5.00",style: TextStyle(fontWeight: FontWeight.bold),),
               ],
             ),
             SizedBox(height: 8),
             Row(
               children: [
                 Image.asset(
                   'assets/homecategory/cementbag.png',
                   width: 60,
                   height: 60,
                 ),
                 SizedBox(width: 16),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'Cement Bags',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                     Text('25 KG'),
                     Text('Quantity - 2'),
                     Text(
                       '\$2.50',
                       style: TextStyle(
                           fontWeight: FontWeight.bold, fontSize: 16),
                     ),
                   ],
                 ),
               ],
             ),
             SizedBox(height: 16),
             Row(
               children: [
                 Text('Expected Delivery:',style: TextStyle(fontWeight: FontWeight.bold),),
                 SizedBox(width: 10,),
                 Text("14th April 2024")
               ],
             ),
             SizedBox(height: 8),
             Text(
               'Adam Johns\nHouse Name\nPlace, District, State\n682352\n9876543210',
               style: TextStyle(height: 1.5),
             ),
             Divider(),
             SizedBox(height: 8),
             Text('Mode of Payment: COD',style: TextStyle(fontWeight: FontWeight.bold),),
             Divider(),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 ElevatedButton.icon(
                   icon: Icon(Icons.contact_support,color: Colors.blue,),
                   label: Text('Contact Us',style:TextStyle(color: Colors.blue),),
                   onPressed: () {
                     // Handle contact us button press
                   },
                 ),
                 ElevatedButton(
                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                   child: Text('Cancel',style: TextStyle(color: Colors.white),),
                   onPressed: () {
                     // Handle cancel button press
                   },
                 ),
               ],
             )
           ],
         ),
       ),
     );
   }
}
