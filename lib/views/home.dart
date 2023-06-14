import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:usb_thermal_printer_web/usb_thermal_printer_web.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
  body: Column(
    children: [
      Expanded(
        flex: 90,
        child: Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
          children: [
            Container(
                width: MediaQuery.of(context).size.width/3,
                child: Column(
                  children: [
                    Expanded(
                      flex:30,
                      child: _receiptSummary()),
                    Expanded(
                      flex:70,
                    child:Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border:Border.all(color:Colors.black)
                      ),
                      child:_receiptOutcome()
                    ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child:const TextField(

                      ),
                    ),
                    ),
                  ],
                ),
            ),
            Expanded(
              child:Container(
              margin: EdgeInsets.only(left:10),  
              child: 
              Column(
                  children: [
                     _topMenu(
                      title: 'ARMS POS',
                      subTitle: '20 October 2022',
                      action: _search(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex:6,
                          child: Column(children:[
                            Container(
                              height: 600,
                              decoration: BoxDecoration(border: Border.all(width: 1)),
                          ),
                          ]),),
                        Expanded(
                          child: Container(
                            height: 600,
                            decoration: BoxDecoration(color: Colors.blue,border: Border.all(width: 1)),
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RotatedBox(quarterTurns: 4, child: Text('Overview')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RotatedBox(quarterTurns: 3, child: Text('Profile')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: RotatedBox(quarterTurns: 3, child: Text('Bio')),
                                ),
                              ],
                            )
                          ),
                        )
                      ],
                    )
                  ],

              ),),)
          ],
        ),
      ),
      ),
      Expanded(
        flex: 2,
        child: Row(children: [
        ],)
      )
    ],
  ),
);
}

  Widget _keypad(text){
    return Container(
      margin: EdgeInsets.all(5),
      width: 100,
      height: 85,
      decoration: BoxDecoration(color: Colors.grey,),
      child: Text(text,textAlign: TextAlign.center,style: TextStyle(color: Colors.black),),
    );
  }


  Widget _topMenu({required String title, required String subTitle, required Widget action}) {
    return Container(
      color: Colors.blue,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.menu, color: Colors.white),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // action,
        ],
      ),
    );
  }

  Widget _receiptOutcome(){
    return FutureBuilder(
    future: _read(),
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      if (snapshot.hasData) {
        return 
        SingleChildScrollView(
        reverse: true,
        child:
        RichText(
          text: TextSpan(
            text: snapshot.data,
            style: TextStyle(fontFamily: "Consolas",color: Colors.black,fontSize: 18),
          ),
        ));
      } else if (snapshot.hasError) {
            return RichText(
                        text: const TextSpan(
                          text: "No Transaction",
                          style: TextStyle(color: Colors.black,fontSize: 18),
                        ),
                        textAlign:TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        textScaleFactor: 1,
              );
      }
      return const CircularProgressIndicator();
    },
  );


  }

  Widget _receiptSummary(){
    return Column(children: [
      Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(color: Colors.blue), 
        child:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          alignment: Alignment.centerLeft,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total",style: TextStyle(color:Colors.white,fontSize: 18),),
              Text("RM",style: TextStyle(color: Colors.white, fontSize: 20),)
          ],)
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text("34.50",style:  TextStyle(color: Colors.white, fontSize: 50,fontWeight: FontWeight.bold),),
        )
      ],),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child:
            Container(
            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
            padding: EdgeInsets.all(10), 
            color: Colors.blue, 
            child:
            Column(
              children: [
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Total Quantity",style: TextStyle(color:Colors.white,fontSize: 18)),
                  Text("4",style: TextStyle(color:Colors.white,fontSize: 18))
                ],),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Rounding",style: TextStyle(color:Colors.white,fontSize: 18)),
                  Text("+0.04",style: TextStyle(color:Colors.white,fontSize: 18))
                ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Sub Total",style: TextStyle(color:Colors.white,fontSize: 18)),
                  Text("0.00",style: TextStyle(color:Colors.white,fontSize: 18))
                ],)
              ],
            ),
            ),
          ),
          Expanded(
            child:
            Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            padding: EdgeInsets.all(10), 
            color: Colors.blue, 
            child:
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Discount",style: TextStyle(color:Colors.white,fontSize: 18)),
                Text("0.00",style: TextStyle(color:Colors.white,fontSize: 18))
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Tax",style: TextStyle(color:Colors.white,fontSize: 18)),
                Text("0.00",style: TextStyle(color:Colors.white,fontSize: 18))
              ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("S.Charges",style: TextStyle(color:Colors.white,fontSize: 18)),
                Text("0.00",style: TextStyle(color:Colors.white,fontSize: 18))
              ],)
            ],)),
          ),
        ],
      ),)
    ]);
  }

  Widget _search() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Row(
        children: [
          Icon(Icons.search),
          SizedBox(width: 8),
          Text('Search...'),
        ],
      ),
    );
  }

  Future<String> _read() async {
    String text="";
    try {
      final File file = File('assets/data/receipt.txt');
      text = await file.readAsString();
    } catch (e) { 
      print("Couldn't read file");
      return Future.error(e);
    }
    return text;
  }
}