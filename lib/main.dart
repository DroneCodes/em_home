import 'package:em_home/firebase_options.dart';
import 'package:em_home/providers/user_provider.dart';
import 'package:em_home/screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: const MaterialApp(
        title: 'EMHome',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

