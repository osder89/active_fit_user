import 'package:active_fit_user/config/theme/app_theme.dart';
import 'package:active_fit_user/models/bd.dart';
import 'package:active_fit_user/views/Usuario/CrearDieta.dart';
import 'package:active_fit_user/widget/card_dieta.dart';
import 'package:active_fit_user/widget/menu_de_navegacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DietaScreen extends StatefulWidget {
  static const name = '/DietaScreen';

  @override
  _DietaScreenState createState() => _DietaScreenState();
}

class _DietaScreenState extends State<DietaScreen> {
  late List<Diet> diets = [];
  late DBProvider dbProvider;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // Inicializar DBProvider.db antes de usarlo
    dbProvider = DBProvider.db;
    _scrollController = ScrollController();
    _getAllDiets();
  }

  Future<void> _getAllDiets() async {
    final List<Diet> allDiets = await DBProvider.db.getAllDiets();
    setState(() {
      diets = allDiets;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: AppTheme.textFieldBgColor,
      bottomNavigationBar: MenuDeNavegacion(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBbColor,
        elevation: 0,
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
              backgroundColor: AppTheme.scaffoldBbColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CrearDieta(
                    dbProvider: DBProvider.db, // Pasar la instancia de DBProvider
                  ),
                ),
              );
            },
          ),
        ],
        title: Text(
          'Mis dietas',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    // Mostrar las dietas obtenidas en cards dinámicas
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: diets.length,
                      itemBuilder: (context, index) {
                        print(diets[index].id);
                        return CardDieta(
                          title: diets[index].titulo,
                          text: diets[index].text,
                        );
                      },
                    ),
                    SizedBox(height: 10),
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
