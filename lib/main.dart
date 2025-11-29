import 'package:flutter/material.dart';
import 'Telas/login.dart';
import 'Telas/cadastro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Telas/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://exemplo-falso.supabase.co',
    anonKey: 'SUA_ANON_KEY_DO_SUPABASE',
  );

  runApp(const EHSMobileApp());
}
class EHSMobileApp extends StatelessWidget {
  const EHSMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EHS Mobile',
      // Você pode definir um tema padrão aqui se quiser, 
      // mas a TelaHome já tem as cores definidas nela mesma.
      theme: ThemeData(
        brightness: Brightness.light, // Mudei para Light para bater com o design azul/branco
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => const TelaLogin(),
        '/cadastro': (ctx) => const TelaCadastro(),
        '/home': (ctx) => const TelaHome(), // A rota já estava certa, agora ela encontra a classe
      },
    );
  }
}