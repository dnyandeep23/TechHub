import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:first_app/utils/routes.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  moveToHome(BuildContext context) async {
    String e = email.toString();
    String p = pass.toString();
    if (_formkey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: e, password: p);
        final user = credential.user;
        print(user?.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
      List<String> emailParts = name.split('@');
      // await Future.delayed(Duration(milliseconds: 1200));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(value1: emailParts[0]),
        ),
      );

      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var column = Column(
      children: [
        Image.asset(
          "assets/images/log.png",
          fit: BoxFit.cover,
          height: 300,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "Welcome $name",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Enter user-name",
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username cannot be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value;
                    setState(() {});
                  },
                ),
                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password cannot be empty";
                    } else if (value!.length < 6) {
                      return "password length should be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                // ElevatedButton(onPressed: (){
                // Navigator.pushNamed(context, MyRoutes.homeRoute);
                //
                // }, child: Text("Login"), style: TextButton.styleFrom(minimumSize: Size(150,50))),

                Material(
                  color: context.theme.highlightColor,
                  borderRadius: BorderRadius.circular(changeButton ? 50 : 8),
                  child: InkWell(
                    onTap: () => moveToHome(context),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: changeButton ? 50 : 150,
                      height: 50,
                      alignment: Alignment.center,
                      child: changeButton
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.registerRoute);
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                    ))
              ],
            ),
          ),
        )
      ],
    );
    return Material(
        color: context.canvasColor,
        child: SingleChildScrollView(child: column));
  }
}
