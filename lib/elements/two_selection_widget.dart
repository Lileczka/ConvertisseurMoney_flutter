import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/currency_model.dart';
import '../service/currency_service.dart';

class MyWidget extends StatefulWidget {
  final void Function(int selectedIndex)? onUpdateSelectedCurrencyData;

  const MyWidget({Key? key, required this.onUpdateSelectedCurrencyData}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<List<CurrencyData>> cryptoNames;
  List<Map<String, String>> currencyMapList = [];

  String getSelectedCryptoName() {
    return selectedCryptoName;
  }

  late String selectedCurrency = '';
  int selectedCryptoIndex = 0;
  int selectedCurrencyIndex = 0;
  int selectedIndexCurrency = 0;
  String selectedCryptoName = 'Bitcoin';
  String selectedCryptoSymbol = 'BTC';
  double price = 0;

  // iOS-Crypto
  Widget iosCryptoPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.black,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCryptoIndex = selectedIndex;
          selectedCryptoName = currencyMapList[selectedIndex]['name'] ?? '';
          selectedCryptoSymbol = currencyMapList[selectedIndex]['symbol'] ?? '';

          price = double.parse(currencyMapList[selectedIndex]['price'] ?? '0');

          print(
              'Selected Crypto: Index $selectedIndex, $selectedCryptoName, $selectedCryptoSymbol');
        });
      },
      children: currencyMapList.map((currency) {
        final cryptoName = currency['name'] ?? '';
        final cryptoSymbol = currency['symbol'] ?? '';
        return Text('$cryptoName ($cryptoSymbol)');
      }).toList(),
    );
  }

  // IOS Currency
  CupertinoPicker iosCurrencyPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.black,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndexCurrency) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndexCurrency];
          selectedCurrencyIndex = selectedIndexCurrency;
          widget.onUpdateSelectedCurrencyData!(selectedCurrencyIndex);

          print('Selected Currency: Index $selectedIndexCurrency, $selectedCurrency');
          CurrencyService().fetchCurrency(toto: selectedCurrency).then((List<CurrencyData> data) {
            setState(() {
              currencyMapList = data
                  .map((currency) => {
                        'name': currency.crypto,
                        'symbol': currency.symbol,
                        'price': currency.price.toString(),
                      })
                  .toList();
              selectedCryptoName = currencyMapList[selectedCryptoIndex]['name'] ?? '';
              selectedCryptoSymbol = currencyMapList[selectedCryptoIndex]['symbol'] ?? '';
              price = double.parse(currencyMapList[selectedCryptoIndex]['price'] ?? '0');
            });
          });
        });
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
    cryptoNames = CurrencyService().fetchCurrency();
    cryptoNames.then((List<CurrencyData> data) {
      setState(() {
        currencyMapList = data
            .map((currency) => {
                  'name': currency.crypto,
                  'symbol': currency.symbol,
                  'price': currency.price.toString(),
                })
            .toList();
        selectedCurrency = currenciesList[selectedCurrencyIndex];
      });
    });

    // Récupérer le prix de USD
    CurrencyService().fetchCurrency(toto: 'USD').then((List<CurrencyData> usdData) {
      if (usdData.isNotEmpty) {
        setState(() {
          price = double.parse(usdData.first.price.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      alignment: Alignment.center,
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: iosCryptoPicker(),
          ),
          SizedBox(
            height: 200.0,
            child: iosCurrencyPicker(),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  width: 550,
                  height: 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 12, 12, 12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Selected Crypto:\n$selectedCryptoName, $selectedCryptoSymbol',
                        style: const TextStyle(
                          fontSize: 28,
                          fontFamily: 'Carlito',
                          color: Color.fromARGB(255, 86, 193, 246),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Valeur de 1 $selectedCurrency :\n $price',
                        style: const TextStyle(
                          fontSize: 28,
                          fontFamily: 'Carlito',
                          color: Color.fromARGB(255, 86, 193, 246),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
