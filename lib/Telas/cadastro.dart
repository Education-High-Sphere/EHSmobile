import 'package:flutter/material.dart';

class TelaCadastro extends StatelessWidget {
	const TelaCadastro({super.key});

	// Cores 
	static const Color darkBlue = Color(0xFF1E2A3B);
	static const Color buttonBlue = Color(0xFF3B82F6);
	static const Color textFieldFill = Color(0xFFFFFFFF);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: darkBlue,
			body: SafeArea(
				child: SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(32.0),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.stretch,
							children: [
								const SizedBox(height: 40),

								// Logo
								CircleAvatar(
									radius: 40,
									backgroundColor: buttonBlue,
									child: const Icon(
										Icons.school,
										color: Colors.white,
										size: 50,
									),
								),
								const SizedBox(height: 24),

								// Títulos
								const Text(
									'Education High Sphere',
									textAlign: TextAlign.center,
									style: TextStyle(
										color: Colors.white,
										fontSize: 24,
										fontWeight: FontWeight.bold,
									),
								),
								const SizedBox(height: 8),
								const Text(
									'Crie sua conta',
									textAlign: TextAlign.center,
									style: TextStyle(
										color: Colors.white70,
										fontSize: 16,
									),
								),
								const SizedBox(height: 32),

								// Campo: Usuário
								TextField(
									decoration: InputDecoration(
										hintText: 'Nome de usuário',
										hintStyle: const TextStyle(color: Colors.black54),
										prefixIcon: const Icon(Icons.person_outline, color: Colors.black54),
										filled: true,
										fillColor: textFieldFill,
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(8),
											borderSide: BorderSide.none,
										),
									),
									style: const TextStyle(color: Colors.black),
								),
								const SizedBox(height: 12),

								// Campo: Email
								TextField(
									keyboardType: TextInputType.emailAddress,
									decoration: InputDecoration(
										hintText: 'Email',
										hintStyle: const TextStyle(color: Colors.black54),
										prefixIcon: const Icon(Icons.email_outlined, color: Colors.black54),
										filled: true,
										fillColor: textFieldFill,
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(8),
											borderSide: BorderSide.none,
										),
									),
									style: const TextStyle(color: Colors.black),
								),
								const SizedBox(height: 12),

								// Campo: Senha
								TextField(
									obscureText: true,
									decoration: InputDecoration(
										hintText: 'Senha',
										hintStyle: const TextStyle(color: Colors.black54),
										prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
										suffixIcon: const Icon(Icons.visibility_outlined, color: Colors.black54),
										filled: true,
										fillColor: textFieldFill,
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(8),
											borderSide: BorderSide.none,
										),
									),
									style: const TextStyle(color: Colors.black),
								),
								const SizedBox(height: 12),

								// Campo: Confirmar Senha
								TextField(
									obscureText: true,
									decoration: InputDecoration(
										hintText: 'Confirmar senha',
										hintStyle: const TextStyle(color: Colors.black54),
										prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
										filled: true,
										fillColor: textFieldFill,
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(8),
											borderSide: BorderSide.none,
										),
									),
									style: const TextStyle(color: Colors.black),
								),
								const SizedBox(height: 12),

								// Campo: Celular
								TextField(
									keyboardType: TextInputType.phone,
									decoration: InputDecoration(
										hintText: 'Celular (opcional)',
										hintStyle: const TextStyle(color: Colors.black54),
										prefixIcon: const Icon(Icons.phone_outlined, color: Colors.black54),
										filled: true,
										fillColor: textFieldFill,
										border: OutlineInputBorder(
											borderRadius: BorderRadius.circular(8),
											borderSide: BorderSide.none,
										),
									),
									style: const TextStyle(color: Colors.black),
								),

								const SizedBox(height: 24),

								ElevatedButton(
									onPressed: () {
										// Lógica de cadastro implementar aqui
										Navigator.pop(context);
									},
									style: ElevatedButton.styleFrom(
										backgroundColor: buttonBlue,
										padding: const EdgeInsets.symmetric(vertical: 16),
										shape: RoundedRectangleBorder(
											borderRadius: BorderRadius.circular(8),
										),
									),
									child: const Text(
										'Cadastrar',
										style: TextStyle(
											color: Colors.white,
											fontSize: 16,
											fontWeight: FontWeight.bold,
										),
									),
								),

								const SizedBox(height: 16),

								// Link para voltar ao login 
								Row(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										const Text('Já possui uma conta? ', style: TextStyle(color: Colors.white70)),
										TextButton(
											onPressed: () => Navigator.pushNamed(context, '/login'),
											style: TextButton.styleFrom(
												padding: EdgeInsets.zero,
												minimumSize: Size.zero,
												tapTargetSize: MaterialTapTargetSize.shrinkWrap,
											),
											child: const Text('Entrar', style: TextStyle(color: buttonBlue, fontWeight: FontWeight.bold)),
										),
									],
								),
								const SizedBox(height: 24),
							],
						),
					),
				),
			),
		);
	}
}

