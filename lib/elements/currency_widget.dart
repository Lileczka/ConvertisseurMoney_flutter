import 'package:flutter/material.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({
    required this.name,
    required this.price,
    Key? key,
  }) : super(key: key);
  
  final String name;
  final double price;

 @override
  Widget build(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 450,
        height: 150,
        color: Colors.lightBlue,
        child: Column(
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
            const SizedBox(
              height: 5,
            ),
            Text('valeur de USD = ${price.toString()}',
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