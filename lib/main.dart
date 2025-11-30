import 'package:flutter/material.dart';
import 'Telas/login.dart';
import 'Telas/cadastro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Telas/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pqlpyxpgrrzuovgldrgw.supabase.co/',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBxbHB5eHBncnJ6dW92Z2xkcmd3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk4NDIwNjksImV4cCI6MjA3NTQxODA2OX0.mfuaZ6JAIBBKrCkM2PmxwW7qSOkaZ-sgyzHRv2wmQNE',
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
        brightness: Brightness
            .light, // Mudei para Light para bater com o design azul/branco
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => const TelaLogin(),
        '/cadastro': (ctx) => const TelaCadastro(),
        '/home': (ctx) =>
            const TelaHome(), // A rota já estava certa, agora ela encontra a classe
      },
    );
  }
}
