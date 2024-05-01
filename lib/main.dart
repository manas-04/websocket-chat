import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat_app/utils/app_route_contants.dart';

import '../injectors/bloc_injector.dart';
import '../services/web_socket_service.dart';
import '../utils/app_routes.dart';
import '../services/database_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService.init();
  runApp(const WebSocketChatApp());
}

class WebSocketChatApp extends StatelessWidget {
  const WebSocketChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WebSocketService(),
      child: BlocInjector(
        child: MaterialApp(
          title: 'Web Socket Chat App',
          routes: AppRoutes.routesMap,
          initialRoute: AppRouteConstants.home,
        ),
      ),
    );
  }
}
