

import 'package:active_fit_user/config/theme/app_theme.dart';
import 'package:active_fit_user/views/Ejercicio/DetalleEjercicio.dart';
import 'package:active_fit_user/widget/card_ejercicios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class EjercicioScreen extends StatefulWidget {
  static const name = '/ejercicio';
  @override
  _EjercicioScreenState createState() => _EjercicioScreenState();
}

class _EjercicioScreenState extends State<EjercicioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.textFieldBgColor,
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBbColor,
        elevation: 0,
        title: Text(
          'Ejercicios',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        actions: [
          ElevatedButton(
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: AppTheme.primaryColor,
                ),
                Text(
                  'Agregar',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            style: ElevatedButton.styleFrom(
              primary: AppTheme.scaffoldBbColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              
            },
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CardEjercicio(
                      imagePath: 'assets/sentadillas.png',
                      titulo: 'Sentadillas ',
                      descripcion: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetalleEjercicioScreen(
                                videoUrl:'https://www.youtube.com/watch?v=BjixzWEw4EY&ab_channel=FisioOnline',
                                nombre: 'Sentadillas',
                                descripcion:
                                    'Las sentadillas son un ejercicio fundamental para fortalecer los músculos de las piernas, glúteos y la zona lumbar. Consisten en flexionar las rodillas y las caderas mientras se baja el cuerpo hacia el suelo, manteniendo la espalda recta y el peso distribuido de manera uniforme en los pies. Este ejercicio ayuda a mejorar la fuerza y la resistencia de las piernas, aumentar la estabilidad y la coordinación,'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CardEjercicio(
                      imagePath: 'assets/flexiones.png',
                      titulo: 'Flexiones',
                      descripcion: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleEjercicioScreen(
                                videoUrl:
                                    'https://www.youtube.com/watch?v=wLGn8XmLeEM&ab_channel=ATHLEAN-XEspa%C3%B1ol',
                                nombre: 'Flexiones',
                                descripcion: 'Consisten en flexionar las rodillas y las caderas mientras se baja el cuerpo hacia el suelo, manteniendo la espalda recta y el peso distribuido de manera uniforme en los pies. Este ejercicio ayuda a mejorar la fuerza y la resistencia de las piernas, aumentar la estabilidad y la coordinación,'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CardEjercicio(
                      imagePath: 'assets/plancha.png',
                      titulo: 'Plancha ',
                      descripcion: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleEjercicioScreen(
                                videoUrl:'https://www.youtube.com/watch?v=d0atctiI7Vw&ab_channel=DeportesUncomo',
                                nombre: 'Plancha ',
                                descripcion: 'Las planchas son un ejercicio de fortalecimiento del core que se centra en los músculos abdominales, la zona lumbar, los hombros y los brazos. Este ejercicio implica mantener el cuerpo en una posición de tabla, con los antebrazos apoyados en el suelo y los codos alineados debajo de los hombros, formando una línea recta desde la cabeza hasta los pies.'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CardEjercicio(
                      imagePath: 'assets/zancadas.png',
                      titulo: 'Zancadas ',
                      descripcion: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleEjercicioScreen(
                                videoUrl:'https://www.youtube.com/watch?v=Xcfs_3DMKlc&ab_channel=Bestcycling',
                                nombre: 'Zancadas ',
                                descripcion: 'Las zancadas, también conocidas como lunges en inglés, son un ejercicio efectivo para fortalecer y tonificar los músculos de las piernas, incluyendo los cuádriceps, los glúteos, los isquiotibiales y los músculos de la pantorrilla.'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CardEjercicio(
                      imagePath: 'assets/burpes.jpg',
                      titulo: 'Burpees',
                      descripcion: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalleEjercicioScreen(
                                videoUrl:'https://www.youtube.com/watch?v=ojiK-zPu09I&ab_channel=Bestcycling',
                                nombre: 'Burpees',
                                descripcion: 'Los burpees son un ejercicio compuesto de alta intensidad que combina movimientos como la sentadilla, la flexión de brazos y el salto. Son conocidos por su efectividad para mejorar la resistencia cardiovascular, fortalecer los músculos de todo el cuerpo y quemar calorías de manera eficiente.'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget promoCard(
      BuildContext context, String image, Widget destinationScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: const EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
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
          ),
        ),
      ),
    );
  }
}
