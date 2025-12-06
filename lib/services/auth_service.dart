import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // Pegamos a instância do cliente Supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  // Método de Login
  Future<String?> login(String email, String password) async {
    try {
      await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null; // Null significa sucesso (sem erro)
    } on AuthException catch (e) {
      return e.message; // Retorna a mensagem de erro da API
    } catch (e) {
      return 'Erro desconhecido: $e';
    }
  }

  Future<String?> cadastro({
    required String email, 
    required String password, 
    required String nome
  }) async {
    try {
      // 1. Cria o usuário na Autenticação (Auth)
      final AuthResponse res = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      // 2. Se criou com sucesso, salva o nome na tabela 'profiles' (Database)
if (res.user != null) {
  await _supabase.from('users').insert({
    // ❌ APAGUE OU COMENTE ESTA LINHA:
    // 'id': res.user!.id,  <-- É ISSO QUE ESTÁ QUEBRANDO O APP!
    
    // ✅ MANTENHA SÓ O RESTO:
    'name': nome,
    'email': email,
    'roles': ['student'] 
    
    // O QUE VAI ACONTECER:
    // O banco vai gerar o ID numérico sozinho (ex: 8, 9, 10...)
    // O cadastro vai funcionar e você vai conseguir entrar no app.
  });
}
      return null; // Sucesso, sem erro
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Erro desconhecido: $e';
    }
  }

  // Método de Logout
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // Verifica se já tem usuário logado
  User? get usuarioAtual => _supabase.auth.currentUser;
}