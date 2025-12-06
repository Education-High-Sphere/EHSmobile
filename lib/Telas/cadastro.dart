import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaCadastro extends StatefulWidget {
	const TelaCadastro({super.key});

	@override
	State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
	static const Color darkBlue = Color(0xFF1E2A3B);
	static const Color buttonBlue = Color(0xFF3B82F6);
	static const Color textFieldFill = Color(0xFFFFFFFF);

	final _formKey = GlobalKey<FormState>();
	final TextEditingController _usernameController = TextEditingController();
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();
	final TextEditingController _confirmPasswordController = TextEditingController();
	final TextEditingController _phoneController = TextEditingController();

	bool _obscurePassword = true;
	bool _obscureConfirmPassword = true;

	@override
	void dispose() {
		_usernameController.dispose();
		_emailController.dispose();
		_passwordController.dispose();
		_confirmPasswordController.dispose();
		_phoneController.dispose();
		super.dispose();
	}

	String? _validateEmail(String? value) {
		if (value == null || value.trim().isEmpty) return 'Por favor, insira o email';
		final emailReg = RegExp(r'^([\w\-\.]+)@((?:[\w\-]+\.)+)([a-zA-Z]{2,4})$');
		if (!emailReg.hasMatch(value.trim())) return 'Email inválido';
		return null;
	}

	String? _validatePassword(String? value) {
		if (value == null || value.isEmpty) return 'Por favor, insira a senha';
		if (value.length < 6) return 'A senha deve ter ao menos 6 caracteres';
		return null;
	}

	String? _validateConfirmPassword(String? value) {
		if (value == null || value.isEmpty) return 'Por favor, confirme a senha';
		if (value != _passwordController.text) return 'As senhas não coincidem';
		return null;
	}

	String? _validatePhone(String? value) {
		if (value == null || value.trim().isEmpty) return null; // opcional
		// Aceita dígitos, espaços, parênteses, sinais + e -; entre 8 e 20 caracteres
		final phoneReg = RegExp(r'^[0-9\+\-\s\(\)]{8,20}');
		final trimmed = value.trim();
		if (phoneReg.stringMatch(trimmed) != trimmed) return 'Telefone inválido';
		return null;
	}

	Future<void> _registerUser() async {
		final email = _emailController.text.trim();
		final password = _passwordController.text;

		try {
			final response = await Supabase.instance.client.auth.signUp(
				email: email,
				password: password,
			);

			if (response.user != null) {
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Cadastro realizado com sucesso!')),
				);
				Navigator.pop(context);
			} else {
				// Quando a API não retorna um usuário, tratamos como falha genérica.
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('Não foi possível concluir o cadastro. Verifique os dados.')),
				);
			}
		} on AuthException catch (error) {
			// Mensagem específica quando o email já existe no Supabase
			final msg = error.message.toLowerCase();
			if (msg.contains('already registered') || msg.contains('user already registered') || msg.contains('duplicate') || msg.contains('already exists')) {
				ScaffoldMessenger.of(context).showSnackBar(
					const SnackBar(content: Text('O email já está cadastrado.')),
				);
			} else {
				ScaffoldMessenger.of(context).showSnackBar(
					SnackBar(content: Text('Erro ao cadastrar: ${error.message}')),
				);
			}
		} catch (e) {
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text('Erro ao cadastrar: $e')),
			);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: darkBlue,
			body: SafeArea(
				child: SingleChildScrollView(
					child: Padding(
						padding: const EdgeInsets.all(32.0),
						child: Form(
							key: _formKey,
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
									TextFormField(
										controller: _usernameController,
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
									TextFormField(
										controller: _emailController,
										keyboardType: TextInputType.emailAddress,
										validator: _validateEmail,
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
									TextFormField(
										controller: _passwordController,
										obscureText: _obscurePassword,
										validator: _validatePassword,
										decoration: InputDecoration(
											hintText: 'Senha',
											hintStyle: const TextStyle(color: Colors.black54),
											prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
											suffixIcon: IconButton(
												icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
														color: Colors.black54),
												onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
											),
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
									TextFormField(
										controller: _confirmPasswordController,
										obscureText: _obscureConfirmPassword,
										validator: _validateConfirmPassword,
										decoration: InputDecoration(
											hintText: 'Confirmar senha',
											hintStyle: const TextStyle(color: Colors.black54),
											prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
											suffixIcon: IconButton(
												icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
														color: Colors.black54),
												onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
											),
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
									TextFormField(
										controller: _phoneController,
										keyboardType: TextInputType.phone,
										validator: _validatePhone,
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
											if (_formKey.currentState?.validate() ?? false) {
												_registerUser();
											}
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
			),
		);
	}
}

