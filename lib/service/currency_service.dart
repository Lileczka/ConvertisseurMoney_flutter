import 'package:dio/dio.dart';

import '../models/currency_model.dart';
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

const List<String> cryptoList = ['BTC', 'ETH', 'LTC'];



//-----recuperer json depuis Api
class CurrencyService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.alternative.me/v2/ticker/1/';
  

 Future<CurrencyData>fetchCurrency() async {
  final response = await _dio.get(_baseUrl);
    
final data = response.data['data']['1'];
final name = data ['name'];
final price = data['quotes']['USD']['price'];

 print('Name: ${name}');
 print('USD Price: ${price}');

  

return CurrencyData(
  // null-aware coalescing opérateur de coalescence nulle
  //fournie valeur de substitution si la valeur à gauche de l'opérateur est nulle 
      name: name ?? '',
      price: price,
    );
    
  }
}
 

