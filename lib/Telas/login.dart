import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  static const Color darkBlue = Color(0xFF1E2A3B); // Cor de fundo aproximada
  static const Color buttonBlue = Color(0xFF3B82F6); // Cor do botão Entrar
  static const Color textFieldFill = Color(0xFFFFFFFF); // Fundo branco dos campos

  final AuthService _authService = AuthService(); // Instancia o serviço
  bool _isLoading = false; // Controla o estado de carregamento

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<void> _fazerLogin() async {

  FocusScope.of(context).unfocus();
  
  if (_userController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Por favor, preencha email e senha.'),
        backgroundColor: Colors.orange, // Laranja para aviso
      ),
    );
    return; // Para a execução aqui
  }
  
  // 1. Ativa o loading e redesenha a tela
  setState(() => _isLoading = true);

  // 2. Chama o Supabase (através do seu serviço)
  final String? erro = await _authService.login(
    _userController.text.trim(),
    _passwordController.text.trim(),
  );

  // 3. Desativa o loading
  setState(() => _isLoading = false);

  // 4. Verifica o resultado
  if (erro == null) {
    // Sucesso! (Verifica se o widget ainda existe antes de navegar)
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  } else {
    // Erro! Mostra um aviso vermelho
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          // Garante que a tela role em dispositivos menores
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Estica os botões
              children: [
                const SizedBox(height: 60),

                // --- 1. Logo ---
                CircleAvatar(
                  radius: 40,
                  backgroundColor: buttonBlue,
                  child: const Icon(
                    Icons.school, // Ícone de formatura
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                const SizedBox(height: 24),

                // --- 2. Títulos ---
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
                  'Acesse sua conta',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                // --- 3. Campo de Usuário ---
                TextField(
                  controller: _userController,
                  decoration: InputDecoration(
                    hintText: 'Nome de usuário, email ou celular',
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(Icons.email_outlined, color: Colors.black54),
                    filled: true,
                    fillColor: textFieldFill,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none, // Sem borda
                    ),
                  ),
                  style: const TextStyle(color: Colors.black), // Cor do texto digitado
                ),
                const SizedBox(height: 16),

                // --- 4. Campo de Senha ---
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword, // Esconde/mostra o texto da senha
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    hintStyle: const TextStyle(color: Colors.black54),
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.black54,
                      ),
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
                const SizedBox(height: 24),

                // --- 5. Botão Entrar ---
                ElevatedButton(
                  // Se estiver carregando, o botão fica desabilitado (null)
                  onPressed: _isLoading ? null : _fazerLogin, 
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Cor do spinner quando desabilitado
                    disabledBackgroundColor: buttonBlue.withOpacity(0.6), 
                  ),
                  
                  // Aqui está a mágica visual:
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text( // O texto original que você tinha
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                const SizedBox(height: 16),

                // --- 6. Esqueceu a senha ---
                TextButton(
                  onPressed: () {
                    // Lógica de "Esqueci minha senha"
                  },
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 24),

                // --- 7. Divisor "OU" ---
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white30)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('OU', style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Colors.white30)),
                  ],
                ),
                const SizedBox(height: 24),

                // --- 8. Botão Google ---
                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica de login com Google
                  },
                  icon: Image.asset(
                    'assets/google_logo.png', // <-- VOCÊ PRECISA ADICIONAR ESSA IMAGEM
                    height: 24.0,
                    // Para este exemplo, usei um placeholder.
                    // Substitua por um ícone real ou imagem.
                    // Se não tiver a imagem, use um placeholder:
                    // icon: const Icon(Icons.g_mobiledata, color: Colors.black),
                  ),
                  label: const Text(
                    'Continuar com o Google',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // --- 9. Link de Cadastro ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Não possui uma conta? ',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cadastro');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // Remove padding extra
                        minimumSize: Size.zero, // Remove tamanho mínimo
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Ajusta área de clique
                      ),
                      child: const Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: buttonBlue, // Usa a cor de destaque
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}