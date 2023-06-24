import 'package:flutter/material.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
  
    required this.name,
    required this.symbol,
    required this.price,
    Key? key,
  }) : super(key: key);
  
  final String name;
  final String symbol;
  final double price;

  @override
Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: const EdgeInsets.all(20),
        width: 450,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name, 
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Carlito',
                    color: Color.fromARGB(255, 3, 99, 150),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  symbol, 
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Carlito',
                    color: Color.fromARGB(255, 3, 99, 150),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'valeur de USD = ${price.toString()}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Carlito',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
}
