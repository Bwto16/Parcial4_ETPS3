import 'package:parcial4etps3/principal.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parcial4etps3/principal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Parcial4());
}

class Parcial4 extends StatelessWidget {
  const Parcial4({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usuarios',
      home: Principal(),
    );
  }
}
