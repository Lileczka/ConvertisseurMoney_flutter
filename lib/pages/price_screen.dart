import 'package:crypto_tracker_flutter/elements/currency_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io' show Platform;

import '../elements/crypto_widget_liste.dart.dart';
import '../models/currency_model.dart';
import '../service/currency_service.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
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

  //ANDROID
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
//IOS
  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
        backgroundColor: const Color.fromARGB(255, 62, 62, 62),
        //hauteur de chacun element à l'interieur
        itemExtent: 32.0,
        //ce qui se passe quand on modiefie la selection en scrollant
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: pickerItems);
  }

  //pour choisir le style selon model:
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
  return Scaffold(
    appBar: AppBar(
      title: const Text("Mon Convertisseur: 💵"),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: CryptoWidgetList(),
            ),
            Expanded(
              child: Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 30.0),
                color: const Color.fromARGB(255, 62, 62, 62),
                // Pour l'apparence iOS, on peut choisir iosPicker()
                child: Platform.isIOS ? iosPicker() : getAndroidDropdownButton(),
              ),
            ),
          ],
        ),
        FutureBuilder<CurrencyData>(
          future: currencyData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Si les données ont été récupérées avec succès
              return CurrencyWidget(
                name: snapshot.data?.name ?? '',
                symbol: snapshot.data?.symbol ?? '',
                price: snapshot.data?.price ?? 0.0,
              );
            } else if (snapshot.hasError) {
              // Si une erreur s'est produite lors de la récupération des données
              return const Text("Désolé, erreur"); // Affiche un message d'erreur
            }
            return const Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 180.0,
              ),
            );
          },
        ),
      ],
    ),
  );
}
}