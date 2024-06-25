

import 'package:active_fit_user/views/Usuario/CrearDieta.dart';
import 'package:active_fit_user/views/Usuario/HomeScreenUsuario.dart';
import 'package:active_fit_user/views/Usuario/PerfilScreen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
 
  
  GoRoute(
    path: '/',
    name: HomeScreenUsuario.name,
    builder: (context, state) =>  HomeScreenUsuario(),
  ),
  GoRoute(
    path: '/perfil',
    name: PerfilScreen.name,
    builder: (context, state) =>  PerfilScreen(),
  ),
 
]);
