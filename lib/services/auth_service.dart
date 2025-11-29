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

  // Método de Cadastro (bônus)
  Future<String?> cadastro(String email, String password) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return null;
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