import 'package:flutter/material.dart';
import 'package:number_otp/datahelper/databasehelper.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _numbercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number OTP'),centerTitle: true,
      ),
      body: Center(child:
      Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _numbercontroller,

            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()=>
              NumberAuth().phoneAuth(_numbercontroller.text, context),

                child: Text('Code Send')),
          ],
        ),
      ),),
    );
  }
}
