import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import '../elements/two_selection_widget.dart';
import '../models/currency_model.dart';
import '../service/currency_service.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
 
 late Future<List<CurrencyData>> currencyData;
  int selectedCryptoIndex = 0; 
  String selectedCurrency = '';
  
  void updateSelectedCryptoData(int selectedIndex) {
    setState(() {
      selectedCryptoIndex = selectedIndex;
    });
  }

  
  @override
  void initState() {
    super.initState();
    currencyData = CurrencyService().fetchCurrency();
    
  }

 
@override
  Widget build(BuildContext context) {
    MyWidget myWidget = MyWidget(
      onUpdateSelectedCurrencyData: updateSelectedCryptoData,
    );

   

    return Scaffold(
      appBar: AppBar(
        title: const Text("Convertisseur crypto-monnaies 💵 ฿"),
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: myWidget,
          ),
          
          
          
        ],
      ),
    );
  }
}