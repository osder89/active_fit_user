import 'dart:convert';
import 'dart:io';

import 'package:active_fit_user/config/theme/app_theme.dart';
import 'package:active_fit_user/models/bd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class CrearDieta extends StatelessWidget {
  final DBProvider dbProvider; // Instancia de DBProvider
  const CrearDieta({Key? key, required this.dbProvider}) : super(key: key);
  static const name = '/agregarDieta';

  @override
  Widget build(BuildContext context) {
    TextEditingController _nombreController = TextEditingController();
    TextEditingController _descripcionController = TextEditingController();
    Future<String?> generateGeminisText(String prompt) async {
      try {
        final apiKey = String.fromEnvironment('API_KEY',
            defaultValue: 'AIzaSyBC2D_uiu7mrVXxVlgCGFFD-unPgdZFyHA');

        if (apiKey == null) {
          return 'Error: API Key not found';
        }

        final model =
            GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
        final content = [Content.text(prompt)];
        final response = await model.generateContent(content);
        return response.text;
      } catch (e) {
        return 'Error: ${e.toString()}';
      }
    }

    return Scaffold(
      backgroundColor: AppTheme.textFieldBgColor,
      appBar: AppBar(
        backgroundColor: AppTheme.scaffoldBbColor,
        elevation: 0,
        title: Text(
          'Nueva Dieta',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          //key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String nombre = _nombreController.text;
                      String descripcion = _descripcionController.text;
                      String prompt =
                          descripcion; 
                      String? generatedText = await generateGeminisText(prompt);

                      if (generatedText != null) {
                        Diet dieta =
                            Diet(id:null , titulo: nombre, text: generatedText);
                        int result = await dbProvider.insertDiet(dieta);

                        if (result != -1) {
                          print('Dieta guardada con éxito');
                          Navigator.pop(context);
                        } else {
                          print('Error al guardar la dieta');
                        }
                      } else {
                        print('Error al generar el texto con Geminis');
                      }
                    },
                    child: Text('Aceptar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); 
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
