import 'package:bit_coin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'dart:convert';


String url='https://rest.coinapi.io/v1/exchangerate/BTC?apikey=D1ADA4F6-5E60-46AC-B930-CEC2C63F4D81';
String bitCoinValue ='?';
CoinData cd = CoinData(url: url);

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}
class _PriceScreenState extends State<PriceScreen> {
  String selectedItem = 'USD';
  // List<DropdownMenuItem> getDropDownItem() {
  //   List<DropdownMenuItem<String>> dropDown = [];
  //   for (String currency in currenciesList) {
  //     var item = DropdownMenuItem(
  //       child: Text(currency),
  //       value: currency,
  //     );
  //     dropDown.add(item);
  //   }
  //   return dropDown;
  // }

  DropdownButton<dynamic> androidPicker() {  //for android
    List<DropdownMenuItem<String>> dropDown = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDown.add(item);
    }

    return DropdownButton(
      value: selectedItem,
      items: dropDown,
      onChanged: (value) {
        setState(() {
          selectedItem = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker IOSPicker() { //for IOS
    List<Text> pickerItems = [];
    for (String picker in currenciesList) {
      pickerItems.add(Text(picker));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  void getData() async{
    double data = await cd.getCoinData();
    setState(() {
      bitCoinValue = data.toString();
    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  // List<Text> getPickerItem(){
  //   List<Text> pickerItems=[];
  //   for(String picker in currenciesList){
  //     pickerItems.add(Text(picker));
  //   }
  //   return pickerItems;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          crypto(cryptoList[0]),
          crypto(cryptoList[1]),
          crypto(cryptoList[2]),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: androidPicker(),
          ),
        ],
      ),
    );
  }

  Padding crypto(String coin) {
    return Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: Card(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $coin = $bitCoinValue $selectedItem',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
  }
}
