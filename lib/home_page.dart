import 'package:flutter/material.dart';
import 'package:login_flutter_bloc_rxdart/bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = BlocLogin();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login Bloc RxDart'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.width,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<String>(
                    stream: controller.usuario,
                    builder: (context, snapshot) {
                      String valor = snapshot.data;

                      return Expanded(
                        child: TextFormField(
                            initialValue: valor,
                            decoration: InputDecoration(
                              hintText: 'Informe o usuario!',
                              labelText: 'Usuario',
                              errorText: snapshot.error,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: controller.keypresUsuario),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<String>(
                    stream: controller.senha,
                    builder: (context, snapshot) {
                      String valor = snapshot.data;

                      return Expanded(
                        child: TextFormField(
                          initialValue: valor,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: 'Digite a senha!',
                            labelText: 'Senha',
                            errorText: snapshot.error,
                          ),
                          obscureText: true,
                          onChanged: controller.keypresSenha,
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                submitButton(controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget submitButton(BlocLogin bloc) => StreamBuilder<bool>(
        stream: bloc.submitValid,
        builder: (context, snap) {
          return Column(
            children: <Widget>[
              RaisedButton(
                onPressed: (snap.hasData)
                    ? () {
                        bloc.enviaDados();
                      }
                    : null,
                child: Text(
                  (snap.hasData)
                      ? "OK! Pode fazer o login agora"
                      : "Ainda não validou seus dados!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                color: Colors.blue,
              ),
              Text((!snap.hasError)
                  ? "Validação efetuada com sucesso!"
                  : "A validação não foi bem sucedida!")
            ],
          );
        },
      );
  @override
  void dispose() {
    super.dispose();
  }
}
