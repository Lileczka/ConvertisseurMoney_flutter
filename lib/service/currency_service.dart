import 'package:dio/dio.dart';
import 'package:crypto_tracker_flutter/models/currency_model.dart';



/*
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
 */ 
 





const List<String> currenciesList = [
       
      'USD',
      'EUR',
      'GBP',
      'RUB',
      'JPY',
      'CAD',
      'KRW',
      'PLN',
      
    ];




class CurrencyService {
  Future<List<CurrencyData>> fetchCurrency({List<String>? currenciesList, String? toto="USD"}) async {
    const List<String> currenciesList = [
      'USD',
      'EUR',
      'GBP',
      'RUB',
      'JPY',
      'CAD',
      'KRW',
      'PLN',
    
        
    ];

    final Dio dio = Dio();
    final String baseUrl ='https://api.alternative.me/v1/ticker/?limit=10&convert=';
    print(baseUrl);
    
    currenciesList.join(',');
    final String url = '$baseUrl$toto';

    final Response response = await dio.get(url);

    final List<CurrencyData> cryptoNames = [];

    final List<dynamic> responseData = response.data;

    print(responseData);

    for (final currencyData in responseData) {
      final String name = currencyData['name'];
      final String symbol = currencyData['symbol'];
     final double priceEUR = double.parse(currencyData['price_${toto?.toLowerCase()}'] ?? '0');
     //final double priceUSD = double.parse(currencyData['price_usd']);

      final CurrencyData currency = CurrencyData(
        name: name,
        symbol: symbol,
        priceEUR: priceEUR,
        //priceUSD: priceUSD,
      );
      cryptoNames.add(currency);

      print('Name: $name, Symbol: $symbol, Price in $toto: $priceEUR');
    }

    return cryptoNames;
  }
}
