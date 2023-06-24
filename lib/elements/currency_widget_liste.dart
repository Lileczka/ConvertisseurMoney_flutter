import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/currency_model.dart';
import '../service/currency_service.dart';

class CurrencyWidgetListe extends StatefulWidget {
  const CurrencyWidgetListe({Key? key}) : super(key: key);

  @override
  State<CurrencyWidgetListe> createState() => _CurrencyWidgetListeState();
}

class _CurrencyWidgetListeState extends State<CurrencyWidgetListe> {
  String? currency = 'USD';

  late Future<CurrencyData> currencyData;
  late Future<List<Map<String, String>>> cryptoNames;

  List<DropdownMenuItem<String>> getCurrenciesList() {
    List<DropdownMenuItem<String>> dropItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(
          currency,
          style: const TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        ),
      );
      dropItems.add(newItem);
    }

    return dropItems;
  }

  List<Text> getPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return pickerItems;
  }

  // ANDROID
  DropdownButton<String> getAndroidDropdownButton() {
    List<DropdownMenuItem<String>> dropItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem<String>(
        value: currency,
        child: Text(
          currency,
          style: const TextStyle(
            fontSize: 28.0,
            color: Colors.white,
          ),
        ),
      );
      dropItems.add(newItem);
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

  // IOS
  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.black,
      // hauteur de chaque élément à l'intérieur
      itemExtent: 32.0,
      //diameterRatio: 40, 
      // ce qui se passe quand on modifie la sélection en scrollant
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  // Pour choisir le style selon la plateforme
  Widget choisePicker() {
    if (Platform.isIOS) {
      return iosPicker();
    } else if (Platform.isAndroid) {
      return getAndroidDropdownButton();
    }
    throw UnimplementedError('Platform not supported');
  }

  @override
  void initState() {
    super.initState();
    currencyData = CurrencyService().fetchCurrency();
    cryptoNames = CurrencyService().fetchCryptoNames();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 30.0),

      // Pour l'apparence iOS, on peut choisir iosPicker()
      child: Platform.isIOS ? iosPicker() : getAndroidDropdownButton(),
    );
  }
}
