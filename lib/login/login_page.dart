import 'package:Notepad/page/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/google_signin_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  // final _formKey = GlobalKey<FormState>();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      // key: _formKey,       
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity, 50)
          ),
          icon: Icon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
          label: Text("Login com o Google"),
          onPressed: signIn,
        ),
      ),
    ),
  );

  Future signIn() async {

    final user = await GoogleSignInApi.login();

    if(user == null){
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Login Failed!')));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: 
      (context) => NotesPage(user: user),
      ));
    }
  }
}





/*
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if(email == null || email.isEmpty){
                      return "Por favor insira o email";
                    }
                    return null;
                  }
                  
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  validator: (password) {
                    if(password == null || password.isEmpty){
                      return "Por favor insira a senha";
                    }
                    return null;
                  }
                ),

*/