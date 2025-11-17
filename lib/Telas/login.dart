import 'package:flutter/material.dart';

class TelaLogin extends StatelessWidget {
  const TelaLogin({super.key});

  // Definição das cores para fácil manutenção
  static const Color darkBlue = Color(0xFF1E2A3B); // Cor de fundo aproximada
  static const Color buttonBlue = Color(0xFF3B82F6); // Cor do botão Entrar
  static const Color textFieldFill = Color(0xFFFFFFFF); // Fundo branco dos campos

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
                  obscureText: true, // Esconde o texto da senha
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
                const SizedBox(height: 24),

                // --- 5. Botão Entrar ---
                ElevatedButton(
                  onPressed: () {
                    // Lógica de login aqui
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonBlue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
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