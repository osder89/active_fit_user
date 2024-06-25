
import 'package:active_fit_user/views/Ejercicio/EjercicioScreen.dart';
import 'package:active_fit_user/views/Usuario/Dieta.dart';
import 'package:active_fit_user/views/Usuario/HomeScreenUsuario.dart';
import 'package:active_fit_user/views/Usuario/PerfilScreen.dart';
import 'package:flutter/material.dart';

class MenuDeNavegacion extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const MenuDeNavegacion(
      {super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  State<MenuDeNavegacion> createState() => _MenuDeNavegacionState();
}

class _MenuDeNavegacionState extends State<MenuDeNavegacion> {
  
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreenUsuario(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DietaScreen(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EjercicioScreen(),
          ),
        );
        break;
         case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerfilScreen(),
          ),
        );
        break;
      default:
        break;
    }

    widget.onItemTapped(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomNavigationBar(
          
          elevation: 0,
           type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.white,
          selectedFontSize: 14,
          unselectedFontSize: 12,
          currentIndex: widget.selectedIndex,
          onTap: _onItemTapped,
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.food_bank_outlined),
              label: 'Dieta',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined),
              label: 'Ejercicios',
            ),
           
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBarItem(IconData iconData, String label, int index) {
    return GestureDetector(
      onTap: () {
        widget.onItemTapped(index);
      },
      child: Container(
        padding: EdgeInsets.all(8), // Ajuste de relleno dentro del ítem
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: widget.selectedIndex == index
                  ? Colors.grey
                  : Colors
                      .white, // Cambia el color del ícono según el ítem seleccionado
            ),
            Text(
              label,
              style: TextStyle(
                color: widget.selectedIndex == index
                    ? Colors.grey
                    : Colors
                        .white, // Cambia el color del texto según el ítem seleccionado
              ),
            ),
          ],
        ),
      ),
    );
  }
}
