
import 'package:active_fit_user/config/theme/app_theme.dart';
import 'package:active_fit_user/widget/menu_de_navegacion.dart';
import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  static const String name = 'PerfilScreen';
  const PerfilScreen({Key? key}) : super(key: key);

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double halfScreenHeight = screenHeight / 2;
    final double photoHeight =
        halfScreenHeight - kToolbarHeight; // Altura de la foto

    return Scaffold(
      backgroundColor: AppTheme.textFieldBgColor,
      bottomNavigationBar: MenuDeNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: photoHeight,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/perfil.png'),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          // Contenedor para los datos de perfil
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            bottom: 0,
            left: 0,
            right: 0,
            height: halfScreenHeight,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: Carlos',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Apellido: Perez',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Peso: 60 kg',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Altura: 170 cm',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'IMC: 22.9',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Correo electrónico: carlosperez74@gmail.com',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Lógica para salir
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.red, // Cambiar color del texto del botón
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text('Salir', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
