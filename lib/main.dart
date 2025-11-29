import 'package:flutter/material.dart';
import 'Telas/login.dart';
import 'Telas/cadastro.dart';

void main() => runApp(const EHSMobileApp());

class EHSMobileApp extends StatelessWidget {
	const EHSMobileApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'EHS Mobile',
			theme: ThemeData(
				brightness: Brightness.dark,
				primarySwatch: Colors.blue,
			),
			initialRoute: '/login',
			routes: {
				'/login': (ctx) => const TelaLogin(),
				'/cadastro': (ctx) => const TelaCadastro(),
        '/home': (ctx) => const TelaHome(),
			},
		);
	}
}
