import 'dart:convert';
import 'package:active_fit_user/config/theme/app_theme.dart';
import 'package:active_fit_user/views/Ejercicio/DetalleEjercicio.dart';
import 'package:active_fit_user/views/Usuario/RutinaUsuarioScreen.dart';
import 'package:active_fit_user/widget/card_inicio_usuario.dart';
import 'package:active_fit_user/widget/menu_de_navegacion.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class HomeScreenUsuario extends StatefulWidget {
  static const name = '/homeScreenUsuario';
  @override
  _HomeScreenUsuarioState createState() => _HomeScreenUsuarioState();
}

class _HomeScreenUsuarioState extends State<HomeScreenUsuario> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.textFieldBgColor,
      bottomNavigationBar: MenuDeNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    const Text(
                      'Recomendado para ti',
                      style: TextStyle(
                        color: AppTheme.whiteTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CardInicioUsuario(
                            imagePath: 'assets/montaun.png',
                            titulo: 'Mantener peso ideal',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RutinaUsuarioScreen(),
                                ),
                              );
                            },
                            descripcion: "",
                          ),
                          CardInicioUsuario(
                            imagePath: 'assets/saltosTijera.png',
                            titulo: 'Bajar de peso',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RutinaUsuarioScreen(),
                                ),
                              );
                            },
                            descripcion: "",
                          ),
                          CardInicioUsuario(
                            imagePath: 'assets/plancha.png',
                            titulo: 'Aumentar masa muscular',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RutinaUsuarioScreen(),
                                ),
                              );
                            },
                            descripcion: "",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Tus programaciones',
                      style: TextStyle(
                        color: AppTheme.whiteTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomImageCard(
                      imagePath: 'assets/gym_programacion.jpg',
                      title: 'Programacion mixta',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RutinaUsuarioScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 15),
                    const Text(
                      'Ejercicios',
                      style: TextStyle(
                        color: AppTheme.whiteTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CardInicioUsuario(
                            imagePath: 'assets/sentadillas.png',
                            titulo: 'Sentadillas ',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetalleEjercicioScreen(
                                      videoUrl:
                                          'https://www.youtube.com/watch?v=BjixzWEw4EY&ab_channel=FisioOnline',
                                      nombre: 'Sentadillas',
                                      descripcion:
                                          'Las sentadillas son un ejercicio fundamental para fortalecer los músculos de las piernas, glúteos y la zona lumbar. Consisten en flexionar las rodillas y las caderas mientras se baja el cuerpo hacia el suelo, manteniendo la espalda recta y el peso distribuido de manera uniforme en los pies. Este ejercicio ayuda a mejorar la fuerza y la resistencia de las piernas, aumentar la estabilidad y la coordinación,'),
                                ),
                              );
                            },
                            descripcion: "",
                          ),
                          CardInicioUsuario(
                            imagePath: 'assets/flexiones.png',
                            titulo: 'Flexiones',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalleEjercicioScreen(
                                      videoUrl:
                                          'https://www.youtube.com/watch?v=wLGn8XmLeEM&ab_channel=ATHLEAN-XEspa%C3%B1ol',
                                      nombre: 'Flexiones',
                                      descripcion:
                                          'Consisten en flexionar las rodillas y las caderas mientras se baja el cuerpo hacia el suelo, manteniendo la espalda recta y el peso distribuido de manera uniforme en los pies. Este ejercicio ayuda a mejorar la fuerza y la resistencia de las piernas, aumentar la estabilidad y la coordinación,'),
                                ),
                              );
                            },
                            descripcion: "",
                          ),
                          CardInicioUsuario(
                            imagePath: 'assets/plancha.png',
                            titulo: 'Plancha ',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalleEjercicioScreen(
                                      videoUrl:
                                          'https://www.youtube.com/watch?v=d0atctiI7Vw&ab_channel=DeportesUncomo',
                                      nombre: 'Plancha ',
                                      descripcion:
                                          'Las planchas son un ejercicio de fortalecimiento del core que se centra en los músculos abdominales, la zona lumbar, los hombros y los brazos. Este ejercicio implica mantener el cuerpo en una posición de tabla, con los antebrazos apoyados en el suelo y los codos alineados debajo de los hombros, formando una línea recta desde la cabeza hasta los pies.'),
                                ),
                              );
                            },
                            descripcion: "",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomImageCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const CustomImageCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Container(
          margin: const EdgeInsets.only(right: 15.0),
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
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
