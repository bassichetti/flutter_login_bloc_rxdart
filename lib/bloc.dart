import 'package:login_flutter_bloc_rxdart/valida_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart' show BehaviorSubject;

class BlocLogin extends ValidaLogin {
  final _usuario = BehaviorSubject<String>();
  final _senha = BehaviorSubject<String>();

  //adicionando dados a stream
  Stream<String> get usuario => _usuario.stream.transform(validaUsuario);
  Stream<String> get senha => _senha.stream.transform(validaSenha);
  //validando valores logicos retornados nos getters, para saber se podemos prosseguir ou nao
  Stream<bool> get submitValid =>
      Rx.combineLatest2(usuario, senha, (valorusuario, valorsenha) => true);

  //estas funcoes receberam os valores digitados e informaram no enventeo de erro do widget, se esta correto o nao
  Function(String) get keypresUsuario => _usuario.sink.add;
  Function(String) get keypresSenha => _senha.sink.add;

  submit() {
    print('your email is :' + _usuario.value);
    print('your password is :' + _senha.value);
    // result = http request
    // show the error to the user if there are
  }

  //destruindo os stream, equivalente ao onDestroi do android
  dispose() {
    _usuario.close();
    _senha.close();
  }
}
