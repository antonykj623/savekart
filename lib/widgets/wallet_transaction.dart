import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:savekart/domain/wallet_transaction_entity.dart';

import '../design/ResponsiveInfo.dart';
import '../domain/wallet_balance_entity.dart';
import '../domain/wallet_transaction_entity.dart';
import '../web/apimethodes.dart';
import '../web/ecommerce_api_helper.dart';

class WalletTransaction extends StatefulWidget {

   WalletTransaction() ;

  @override
  _WalletTransactionState createState() => _WalletTransactionState();
}

class _WalletTransactionState extends State<WalletTransaction> {

  double walletbalance=0.0;
   List<WalletTransactionData>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculateWalletBalance();
    getWalletTransactions();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Wallet",style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:17,color: Colors.white),),
        leading: GestureDetector(

          child:Icon(Icons.arrow_back,color: Colors.white,size:ResponsiveInfo.isMobile(context)?20:25 ,) ,

          onTap: (){

            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff0B7D97),
        actions: [








        ]

        ,),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          
          Expanded(child: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

            child: Text("Wallet Balance : "+walletbalance.toString(),style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?15:17,color: Colors.black),),


          ),flex: 1,),

          Expanded(child: (data!.length>0)? ListView.builder(
              itemCount: data!.length,
              itemBuilder: (BuildContext context, int index) {

              // List<String> date=data![index]!.transactionDate.toString().split(" ");
              // String d=date[0];
              final dateTime = DateTime.parse(data![index]!.transactionDate.toString());

                return Card(

                  child:ListTile(
                      leading:  Icon(Icons.wallet,color: Colors.black54,size: ResponsiveInfo.isMobile(context)?25:30,),
                      trailing: (data![index].debit.toString().compareTo("0")==0 && data![index].credit.toString().compareTo("0")!=0) ?
                      Text(
                        "+"+data![index].credit.toString(),
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ) : Text(
                        "-"+data![index].debit.toString(),
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                      title: Text(data![index]!.description.toString()),
                    subtitle: Text(dateTime.day.toString()+"-"+dateTime.month.toString()+"-"+dateTime.year.toString()),

                  ) ,
                  elevation: 5,
                  margin: EdgeInsets.all(5),
                )


                  ;
              }) : Stack(
            children: [

              Align(
                alignment: FractionalOffset.center,
                child: Text("No data found"),
              )
            ],
          ),flex: 5,)







        ],
      )


    );
  }

  calculateWalletBalance() async
  {
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.calculateWalletBallence+"?q="+t.toString());

    var js= jsonDecode( response) ;
    print(js);

    WalletBalanceEntity entity=WalletBalanceEntity.fromJson(js);

    if(entity!=null)
    {

      setState(() {

        walletbalance=double.parse(entity.data!.balance.toString());
      });


    }

  }

  getWalletTransactions() async{
    EcommerceApiHelper apihelper = new EcommerceApiHelper();

    var t=EcommerceApiHelper.getTimeStamp();

    var response= await  apihelper.get(Apimethodes.getwalletTransactions+"?q="+t.toString());

    var js= jsonDecode( response) ;

    print(js);

    WalletTransactionEntity entity=WalletTransactionEntity.fromJson(js);

    if(entity.status==1)
      {

        if(entity.data!.length>0)
          {
            setState(() {
              data!.clear();
              data!.addAll(entity.data!);
            });
          }


      }



  }
}
