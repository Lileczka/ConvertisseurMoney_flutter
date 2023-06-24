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
  late Future<CurrencyData> currencyData;

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
                return const Text(
                    "Désolé, erreur"); // Affiche un message d'erreur
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
