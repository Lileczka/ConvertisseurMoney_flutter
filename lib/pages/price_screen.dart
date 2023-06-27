import 'package:crypto_tracker_flutter/elements/currency_widget.dart';
import 'package:crypto_tracker_flutter/elements/currency_widget_liste.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io' show Platform;

import '../elements/crypto_widget_liste.dart.dart';
import '../models/currency_model.dart';
import '../service/currency_service.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  
 late Future<List<CurrencyData>> currencyData;

  @override
  void initState() {
    super.initState();
    currencyData = CurrencyService().fetchCurrency();
    
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
          const Row(
            children: <Widget>[
              Expanded(
                child: CryptoWidgetList(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: CurrencyWidgetListe(),
                ),
              ),
            ],
          ),
          FutureBuilder<List<CurrencyData>>(
          future: currencyData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
             
              return CurrencyWidget(
                name: snapshot.data![0].name,
                symbol: snapshot.data![0].symbol,
                priceEUR: snapshot.data![0].priceEUR,
              );
            } else if (snapshot.hasError) {
             
              return const Text(
                  "Désolé, erreur"); 
            }
            return const Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 180.0,
              ),
            );
          },
        ),
        SizedBox(
          height: 40.0,
          child: Container(
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
}