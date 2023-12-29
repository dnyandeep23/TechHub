import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = "";
  // String pass = "";

  final _formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  void signup() async {
    String e = name.toString();
    String p = pass.toString();
    print("this$e");
    print(p);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: name.toString(),
        password: pass.toString(),
      );

 
      List<String> emailParts = e.split('@');
      if (emailParts.length == 2) {
        String emailKey = emailParts[0];
         // Use the part before "@" as the key
        emailKey = emailKey.replaceAll('.', ''); // Remove dots from the key
        FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(emailKey)
            .update({'email': e});
            Navigator.pushNamed(context, MyRoutes.loginRoute);
      } else {
        print('Invalid email format');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  String sanitizePath(String path) {
    // Replace invalid characters with a valid substitute
    return path.replaceAll('.', '_dot_').replaceAll('@', '_at_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/register_image.png",
                  fit: BoxFit.cover,
                  height: 300,
                ),
              ],
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
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
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
                        setState(() {
                          name = value;
                        });
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
                      onChanged: (value) {
                        // pass = value;
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
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          signup();
                        },
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Register",
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
