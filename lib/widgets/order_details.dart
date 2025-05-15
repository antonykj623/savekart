import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/order_details_entity.dart';
import '../web/ecommerce_api_helper.dart';

class OrderItemDetailsScreen extends StatefulWidget {

  OrderDetailsData orderDetailsData;

  OrderItemDetailsScreen(this.orderDetailsData);

  @override
  _OrderItemDetailsScreenState createState() => _OrderItemDetailsScreenState(this.orderDetailsData);
}

class _OrderItemDetailsScreenState extends State<OrderItemDetailsScreen> {
  int _statusValue = 0;

  final List<String> _statuses = [
    "Order Created",
    "Packing",
    "Out for Delivery",
    "Delivered",
    "Returned"
    "Cancelled",

  ];

  OrderDetailsData orderDetailsData;

  _OrderItemDetailsScreenState(this.orderDetailsData);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {

    if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("0")==0)
      {
        _statusValue=0;
      }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("1")==0)
      {

        _statusValue=1;
      }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("2")==0)
    {

      _statusValue=2;
    }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("5")==0)
    {

      _statusValue=5;
    }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("4")==0)
    {

      _statusValue=4;
    }
    else if(orderDetailsData!.cartOrder!.orderItemStatus.toString().compareTo("3")==0)
    {

      _statusValue=3;
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(

                  children: [
                    Expanded(child: Image.network(EcommerceApiHelper.productimageurl+orderDetailsData.cartProduct!.primeImage.toString(), width:ResponsiveInfo.isMobile(context)? 60:75, height: ResponsiveInfo.isMobile(context)? 60:75, fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child; // Image loaded successfully
                        return Center(child: CircularProgressIndicator()); // Show loader while loading
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image,size: 50,color: Colors.black26,); // Show a local placeholder on error
                      },),flex: 1,),

                    Expanded(child: Padding(

                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Item Name : "+orderDetailsData.cartProduct!.productName.toString()+"\n"+
                            "Pice : "+orderDetailsData.cartOrder!.price.toString()+"\n"
                            "Quantity : "+orderDetailsData.cartOrder!.quantity.toString()+"\n",



                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    )


                      ,flex: 3,)


                  ],
                )



                ,
              ),
              SizedBox(height: 20),
              Text(
                "Order Status",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              IgnorePointer(
                child: create_appropriateStepper()
                ,
                ignoring: true,
              )
              ,
              SizedBox(height: 20),

            ],
          ),
        ),
      )


      ,
    );
  }

   getFormatedDate(String dateString) {
    // String dateString = "2025-03-26 21:39:05"; // Input date string

    // Parse the string into DateTime
    DateTime dateTime = DateTime.parse(dateString);

    // Format DateTime into 12-hour format with AM/PM
    String formattedDate = DateFormat('dd-MM-yyyy hh:mm:ss a').format(dateTime);

    return formattedDate; // Output: 2025-03-26 09:39:05 PM
  }




  Widget create_appropriateStepper()
  {
    Widget w=Container();

    if(orderDetailsData.paymentDetails?.paymentStatus?.compareTo("2")==0  )
      {
        w=Stepper(steps: [
          Step(
            title: Text("Order Initiated"),
            subtitle: Text("You have initiated to create an order"),
            content: SizedBox.shrink(),
            isActive: true,
          ),
          Step(
            title: Text("Payment Not Completed"),
            subtitle: Text("You have not completed your payment",style: TextStyle(color: Colors.redAccent),),
            content: SizedBox.shrink(),
            isActive: true,
          )
        ], controlsBuilder: (context,controller){
          return const SizedBox.shrink();
        });
      }
   else if(orderDetailsData.paymentDetails?.paymentStatus?.compareTo("0")==0  )
    {
      w=Stepper(steps: [
        Step(
          title: Text("Order Initiated"),
          subtitle: Text("You have initiated to create an order"),
          content: SizedBox.shrink(),
          isActive: true,
        ),
        Step(
          title: Text("Payment Failed"),
          subtitle: Text("Your transaction failed",style: TextStyle(color: Colors.redAccent),),
          content: SizedBox.shrink(),
          isActive: true,
        )
      ], controlsBuilder: (context,controller){
        return const SizedBox.shrink();
      });
    }

   else {

     if(_statusValue==0 || _statusValue==1 || _statusValue==2 || _statusValue==3)
    {
    w= (orderDetailsData.cartReturnRequests!=null&&!orderDetailsData.cartReturnRequests!.id.toString().isEmpty) ? Stepper(
    controlsBuilder: (context,controller){
    return const SizedBox.shrink();
    },
    currentStep: _statusValue,
    steps: [
    Step(
    title: Text("Order Created"),
    subtitle: Text(
    "You have created an order. \nDate :" +
    ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
        : " No date available")
    ),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 0,
    ),

    Step(
    title: Text("Packing"),
    subtitle: Text("Order Packing is on progress.\nDate : "+((orderDetailsData!.cartOrder!.packedAt != null && orderDetailsData!.cartOrder!.packedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.packedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 1,
    ),
    Step(
    title: Text("Shipped"),
    subtitle: Text("Shipped.You will get your product soon."+((orderDetailsData!.cartOrder!.podNumber != null && orderDetailsData!.cartOrder!.podNumber!.isNotEmpty) ? "\nTracking Number : "+orderDetailsData!.cartOrder!.podNumber:"")+"\nDate : "+((orderDetailsData!.cartOrder!.shippedAt != null && orderDetailsData!.cartOrder!.shippedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.shippedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 2,
    ),

    Step(
    title: Text("Delivered"),
    subtitle: Text("Order Delivered successfully.\nDate : "+((orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency != null && orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 3,
    ),


    Step(
    title:(orderDetailsData!.cartReturnRequests!.status.toString().compareTo("1")==0)?
    Text("Return request accepted") :
    (orderDetailsData!.cartReturnRequests!.status.toString().compareTo("2")==0 ?
    Text("Return request Rejected") :
    Text("Return request submitted on "+getFormatedDate(orderDetailsData!.cartReturnRequests!.createdAt.toString()))) ,
    subtitle: (orderDetailsData!.cartReturnRequests!.status.toString().compareTo("1")==0)?
    Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:10),

    child:Text("Your return request accepted" + (orderDetailsData!.cartReturnRequests!.refundStatus.toString().compareTo("1")==0 ? "\n Refunded on "+((orderDetailsData!.cartReturnRequests!.refundedDate!=null)? getFormatedDate(orderDetailsData!.cartReturnRequests!.refundedDate.toString()) : "") : "\nNot Refunded")


    ,style: TextStyle(color: Colors.green),) ,

    ) : Container(),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 3,
    ) ,


    ],
    )
        :Stepper(
    controlsBuilder: (context,controller){
    return const SizedBox.shrink();
    },
    currentStep: _statusValue,
    steps: [
    Step(
    title: Text("Order Created"),
    subtitle: Text(
    "You have created an order. \nDate :" +
    ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
        : " No date available")
    ),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 0,
    ),

    Step(
    title: Text("Packing"),
    subtitle: Text("Order Packing is on progress.\nDate : "+((orderDetailsData!.cartOrder!.packedAt != null && orderDetailsData!.cartOrder!.packedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.packedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 1,
    ),
    Step(
    title: Text("Shipped"),
    subtitle: Text("Shipped.You will get your product soon."+((orderDetailsData!.cartOrder!.podNumber != null && orderDetailsData!.cartOrder!.podNumber!.isNotEmpty) ? "\nTracking Number : "+orderDetailsData!.cartOrder!.podNumber:"")+"\nDate : "+((orderDetailsData!.cartOrder!.shippedAt != null && orderDetailsData!.cartOrder!.shippedAt!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.shippedAt!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 2,
    ),

    Step(
    title: Text("Delivered"),
    subtitle: Text("Order Delivered successfully.\nDate : "+((orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency != null && orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!.isNotEmpty)
    ? getFormatedDate(orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!)
        : " No date available")),
    content: SizedBox.shrink(),
    isActive: _statusValue >= 3,
    ),


    ],
    );
    }
    else if(_statusValue==4){
  w= Stepper(
  controlsBuilder: (context,controller){
  return const SizedBox.shrink();
  },
  currentStep: _statusValue,
  steps: [
  Step(
  title: Text("Order Created"),
  subtitle: Text(
  "You have created an order. \nDate :" +
  ((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
      : " No date available")
  ),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 0,
  ),

  Step(
  title: Text("Packing"),
  subtitle: Text("Order Packing is on progress.\nDate : "+((orderDetailsData!.cartOrder!.packedAt != null && orderDetailsData!.cartOrder!.packedAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.packedAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 1,
  ),
  Step(
  title: Text("Out for delivery"),
  subtitle: Text("Out for delivery.You will get your product soon.\nDate : "+((orderDetailsData!.cartOrder!.shippedAt != null && orderDetailsData!.cartOrder!.shippedAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.shippedAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 2,
  ),

  Step(
  title: Text("Delivered"),
  subtitle: Text("Order Delivered successfully.\nDate : "+((orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency != null && orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.deliveryRecvedDateFromAgency!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 3,
  ),
  Step(
  title: Text("Returned"),
  subtitle: Text("Order returned successfully. Your return request accepted" + (orderDetailsData!.cartReturnRequests!.refundStatus.toString().compareTo("1")==0 ? "\n Refunded on "+((orderDetailsData!.cartReturnRequests!.refundedDate!=null)? getFormatedDate(orderDetailsData!.cartReturnRequests!.refundedDate.toString()) : "") : "\nNot Refunded")


  ,style: TextStyle(color: Colors.redAccent),),
  content: SizedBox.shrink(),
  isActive: _statusValue == 4,
  ),


  ],
  );
  }
    else if(_statusValue==5){

  w=Stepper(steps: [
  Step(
  title: Text("Order Created"),
  subtitle: Text("You have created an order.\n Date : "+((orderDetailsData!.cartOrder!.createdAt != null && orderDetailsData!.cartOrder!.createdAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.createdAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 0,
  ),
  Step(
  title: Text("Cancelled"),
  subtitle: Text("Order cancelled on  \n Date : "+((orderDetailsData!.cartOrder!.cancelledAt != null && orderDetailsData!.cartOrder!.cancelledAt!.isNotEmpty)
  ? getFormatedDate(orderDetailsData!.cartOrder!.cancelledAt!)
      : " No date available")),
  content: SizedBox.shrink(),
  isActive: _statusValue >= 5,
  )
  ], controlsBuilder: (context,controller){
  return const SizedBox.shrink();
  });
  }
  }
    return w;
  }



}
