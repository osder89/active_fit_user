import 'package:active_fit_user/models/bd.dart';
import 'package:active_fit_user/models/exercise_model.dart';
import 'package:active_fit_user/models/push_up_model.dart';
import 'package:active_fit_user/views/Usuario/HomeScreenUsuario.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'views/pose_detection_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBProvider.db.initDB();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseCounter(),
      child: MaterialApp(
        title: 'Material App',
        home: HomeScreenUsuario(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google ML Kit Demo App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ExpansionTile(
                    title: const Text('Vision APIs'),
                    children: [
                      CustomCard('Pose Detection', PoseDetectorView(exerciseName: "pushUp")),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    
  }
}

class CustomCard extends StatelessWidget {
  final String _label;
  final Widget _viewPage;
  final bool featureCompleted;

  const CustomCard(this._label, this._viewPage, {this.featureCompleted = true});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(
          _label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (!featureCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    const Text('This feature has not been implemented yet')));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => _viewPage));
          }
        },
      ),
    );
  }
}