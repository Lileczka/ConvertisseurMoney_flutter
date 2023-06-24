import 'dart:io';

import 'package:crypto_tracker_flutter/service/currency_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class CryptoWidgetList extends StatefulWidget {
 const CryptoWidgetList({Key? key}) : super(key: key);

  @override
  State<CryptoWidgetList> createState() => _CryptoWidgetListState();
}

class _CryptoWidgetListState extends State<CryptoWidgetList> {
  String? currency = 'BTC';
  
 
  late Future<List<Map<String, String>>> cryptoNames;
  
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
//ANDROID
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
//IOS
Widget iosPicker() {
  return  CupertinoPicker(
        backgroundColor: const Color.fromARGB(255, 62, 62, 62),
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: [
          FutureBuilder<List<Map<String, String>>>(
            future: cryptoNames,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Column(
                  children: [
                    for (Map<String, String> crypto in snapshot.data!) 
                      Text(
                        crypto['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                  ],
                );
              }  return const SizedBox();
            },
          ),
        ],
      );
    

}



//pour choisir le style selon model:
  Widget choisePicker() {
  if (Platform.isIOS) {
    return iosPicker();
  } else if (Platform.isAndroid) {
    return FutureBuilder<List<Map<String, String>>>(
      future: cryptoNames,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return getAndroidDropdownButton(snapshot.data!);
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
   
    cryptoNames = CurrencyService().fetchCryptoNames();
  }

@override
Widget build(BuildContext context) {
  return Container(
    height: 250.0,
    alignment: Alignment.center,
    padding: const EdgeInsets.all(50.0),
    color: const Color.fromARGB(255, 62, 62, 62),
    child: /*Platform.isIOS
        ? iosPicker()
        : */FutureBuilder<List<Map<String, String>>>(
            future: cryptoNames,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return getAndroidDropdownButton(snapshot.data!);
              } else {
                return const CircularProgressIndicator();
        }
            },
          ),
        
    );
  }

}
  
  

