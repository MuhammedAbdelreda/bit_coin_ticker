import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String? url;

  CoinData({required this.url});

  Future getCoinData() async {
  final uri = Uri.parse(url!);
  Response response = await get(uri);
  String data = response.body;
  var js = jsonDecode(data)['rates'][176]['rate'];
  return js;
  
}
}