import 'package:flutter/material.dart';
import 'package:notificationsapp/screens/screens.dart';
import 'package:notificationsapp/services/push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    // Context
    PushNotificationService.messageStream.listen((product) {
      // print('MyApp: $message');
      _navigatorKey.currentState
          ?.pushNamed(MessageScreen.routeName, arguments: product);

      final snackBar = SnackBar(content: Text(product));
      _scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notifications App',
      navigatorKey: _navigatorKey, // Navegar
      scaffoldMessengerKey: _scaffoldMessengerKey, // Snacks
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        MessageScreen.routeName: (_) => const MessageScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
