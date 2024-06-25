import 'package:flutter/material.dart';

class CardDieta extends StatelessWidget {
  final String title;
  final String text;

  const CardDieta({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15.0, bottom: 15.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12), // Espacio entre el título y el texto
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
