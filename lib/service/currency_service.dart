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






//-----recuperer json depuis Api
class CurrencyService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.alternative.me/v2/ticker/1/';
  final String _baseUrlCryptos = 'https://api.alternative.me/v2/listings/';

 Future<CurrencyData>fetchCurrency() async {
  final response = await _dio.get(_baseUrl);
    
final data = response.data['data']['1'];
final name = data ['name'];
final symbol = data  ['symbol'];
final price = data['quotes']['USD']['price'];

 print('Name: $name');
 print('Symbol: $symbol');
 print('USD Price: $price');

return CurrencyData(
  // null-aware coalescing opérateur de coalescence nulle
  //fournie valeur de substitution si la valeur à gauche de l'opérateur est nulle 
      name: name ?? '',
      symbol: symbol ?? '',
      price: price,
    );
  }
  
  Future<List<Map<String, String>>> fetchCryptoNames() async {
  final response = await _dio.get(_baseUrlCryptos);

  List<Map<String, String>> cryptoNames = [];

  if (response.statusCode == 200) {
    final data = response.data['data'];
    int count = 0;
    data.forEach((currency) {
      if (count < 25) {
        final name = currency['name'];
        final symbol = currency['symbol'];
        print('Name: $name, Symbol: $symbol');
        cryptoNames.add({'name': name, 'symbol': symbol});
        count++;
      }
    });
  }

  return cryptoNames;
}


}
  
 

