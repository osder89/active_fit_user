import 'package:flutter/material.dart';

class CardInicioUsuario extends StatelessWidget {
  final String imagePath;
  final String titulo;
  final VoidCallback onTap;
  final String descripcion;

  const CardInicioUsuario({
    Key? key,
    required this.imagePath,
    required this.titulo,
    required this.onTap,
    required this.descripcion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150, // Ancho de la tarjeta
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imagePath),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              stops: [0.1, 0.9],
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalCardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        scrollDirection: Axis.horizontal, // Scroll horizontal
        children: List.generate(10, (index) {
          // Generar 10 tarjetas de ejemplo
          return CardInicioUsuario(
            imagePath: 'assets/categoria_$index.jpg',
            titulo: 'Título $index',
            descripcion: 'Descripción $index',
            onTap: () {
              // Lógica al hacer clic en la tarjeta
            },
          );
        }),
      ),
    );
  }
}
