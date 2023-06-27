import 'dart:io';
import 'package:crypto_tracker_flutter/service/currency_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/currency_model.dart';

class CryptoWidgetList extends StatefulWidget {
  const CryptoWidgetList({Key? key}) : super(key: key);

  @override
  State<CryptoWidgetList> createState() => _CryptoWidgetListState();
}

class _CryptoWidgetListState extends State<CryptoWidgetList> {
  String? currency = 'BTC';

 late Future<List<CurrencyData>> cryptoNames;
  List<DropdownMenuItem<String>> getCryptoList(List<Map<String, String>> cryptoNames) {
    List<DropdownMenuItem<String>> cryptoItems = [];

    for (Map<String, String> crypto in cryptoNames) {
      String cryptoName = crypto['name'] ?? '';
      var newItem = DropdownMenuItem<String>(
        value: cryptoName,
        child: Text(
          cryptoName,
          style: const TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        ),
      );

      cryptoItems.add(newItem);
    }

    return cryptoItems;
  }

  List<Text> getPicker(List<Map<String, String>> cryptoNames) {
    List<Text> pickerItems = [];
    for (Map<String, String> crypto in cryptoNames) {
      String cryptoName = crypto['name'] ?? '';
      pickerItems.add(Text(cryptoName));
    }
    return pickerItems;
  }

  // Android
  DropdownButton<String> getAndroidDropdownButton(List<Map<String, String>> cryptoNames) {
    List<DropdownMenuItem<String>> dropItems = [];

    for (Map<String, String> crypto in cryptoNames) {
      var newItem = DropdownMenuItem<String>(
        value: crypto['name'],
        child: Text(
          crypto['name'] ?? '',
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      );
      dropItems.add(newItem);
    }

    // Vérification de la valeur actuelle
    if (!dropItems.any((item) => item.value == currency)) {
      currency = dropItems.isNotEmpty ? dropItems[0].value : null;
    }

    return DropdownButton<String>(
      value: currency,
      items: dropItems,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            currency = newValue;
          });
        }
      },
    );
  }

  // iOS
  Widget iosPicker() {
  return FutureBuilder<List<CurrencyData>>(
    future: cryptoNames,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
        List<Map<String, String>> currencyMapList = snapshot.data!.map((currencyData) {
          return {
            'name': currencyData.name,
            // add more key-value pairs as needed
          };
        }).toList();

        return CupertinoPicker(
          itemExtent: 32.0,
          onSelectedItemChanged: (selectedIndex) {
            setState(() {
              print('Selected Currency: Index $selectedIndex, ${currencyMapList[selectedIndex]["name"]}');
            });
          },
          children: getPicker(currencyMapList),
        );
      } else {
        return CupertinoActivityIndicator();
      }
    },
  );
}



  // Choose the picker based on the platform
  Widget choicePicker() {
  if (Platform.isIOS) {
    return iosPicker();
  } else if (Platform.isAndroid) {
    return FutureBuilder<List<CurrencyData>>(
      future: cryptoNames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          List<Map<String, String>> currencyMapList = snapshot.data!.map((currencyData) {
            return {
              'name': currencyData.name,
              
            };
          }).toList();
          return getAndroidDropdownButton(currencyMapList);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
  throw UnimplementedError('Platform not supported');
}

  @override
  void initState() {
    super.initState();
    cryptoNames = CurrencyService().fetchCurrency();
  }

  @override
Widget build(BuildContext context) {
  return Container(
    height: 200.0,
    alignment: Alignment.center,
    color: Colors.black,
    child: FutureBuilder<List<CurrencyData>>(
      future: cryptoNames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          List<Map<String, String>> currencyMapList = snapshot.data!.map((currencyData) {
            return {
              'name': currencyData.name,
              // add more key-value pairs as needed
            };
          }).toList();
          return Platform.isIOS ? iosPicker() : getAndroidDropdownButton(currencyMapList);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    ),
  );
}
}