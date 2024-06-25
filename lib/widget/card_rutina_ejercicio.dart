import 'package:flutter/material.dart';

class CardRutinaUsuario extends StatelessWidget {
  final String imagePath;
  final String titulo;
  final VoidCallback onTap;
  final String series;
  final String repeticiones;

  const CardRutinaUsuario({
    Key? key,
    required this.imagePath,
    required this.titulo,
    required this.onTap,
    required this.series,
    required this.repeticiones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: 
         Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: 100, // Ancho de la imagen
                height: 100, // Alto de la imagen
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12), 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      height: 20),
                  Row(
                    children: [
                      Text(
                        'Series:  $series',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 15), 
                      Text(
                        'Repeticiones:  $repeticiones',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ), // Espacio entre el nombre y la descripción
                  
                ],
              ),
            ),
          ],
        ),
    );
  }
}
