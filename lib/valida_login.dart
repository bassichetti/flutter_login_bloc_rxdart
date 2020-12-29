import 'dart:async';

class ValidaLogin {
  final validaUsuario = StreamTransformer<String, String>.fromHandlers(
      handleData: (String usuario, EventSink<String> sink) {
    if (usuario.contains('@')) {
      sink.add(usuario);
    } else {
      sink.addError('Digite um email com @');
    }
  });

  final validaSenha = StreamTransformer<String, String>.fromHandlers(
      handleData: (String senha, EventSink<String> sink) {
    if (senha.length > 3) {
      sink.add(senha);
    } else {
      sink.addError('Digite ao menos 4 caracteres');
    }
  });
}
