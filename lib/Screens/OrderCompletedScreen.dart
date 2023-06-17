import 'package:flutter/material.dart';
import 'package:checkmark/checkmark.dart';

class OrderCompletedScreen extends StatefulWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

  @override
  State<OrderCompletedScreen> createState() => _OrderCompletedScreenState();
}

class _OrderCompletedScreenState extends State<OrderCompletedScreen> {
  bool checked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200)).then((value){
      setState(() {
        checked = true;
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: SizedBox(
                height: 50,
                width: 50,
                child: CheckMark(
                  active: checked,
                  curve: Curves.decelerate,
                  duration: const Duration(milliseconds: 500),
                ),
              ),
            ),
            SizedBox(height: 25,),
            Center(
              child: Column(
                  children:[
                    Text("Siparişiniz Tamamlandı",
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 30,),
                    ElevatedButton(
                        style : ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                        },
                        child:
                        Text("Anasayfaya Dön"))
                  ]
              ),
            ),

          ],
        ),
      ),
    );
  }
}


