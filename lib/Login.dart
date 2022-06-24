import 'package:apitest/Home.dart';
import 'package:apitest/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'Helper/APIservice.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  TextEditingController mo = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  String emailError, passError;
  bool emailValidate, passValidate;
  bool Pshow = true;

  @override
  void iniState() {
    super.initState();
    emailValidate = passValidate = false;
    emailError = passError = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(90)),
              Text(
                "Log In",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                maxLength: 10,
                controller: mo,
                  keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: " Contect number",
                  labelText: " Contect number",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              TextField(
                obscureText: Pshow,
                controller: pass,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "Enter your password",
                    labelText: "Enter your password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                      icon:
                          Icon(Pshow ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          Pshow = !Pshow;
                        });
                      },
                    )),
              ),
              Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text(
                    "Log In",
                  )),
              RichText(
                text: TextSpan(
                  text: "Don't have an account ? ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: " Sing up",
                        style: TextStyle(color: Colors.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Sing()));
                          }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    Map<String, dynamic> map = Map();
    map['password'] = pass.text;
    map['mobile'] = mo.text;

    print(map);
    var result = await APIService().login(map);
    if (result.message == "success") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("success")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("contect to admin")));
    }
  }

  int validate() {
    int cnt = 0;
    if (mo.text.isEmpty) {
      setState(() {
        emailError = "";
        emailValidate = true;
      });
    } else {
      setState(() {
        emailError = "";
        emailValidate = false;
      });
    }
    return cnt;
  }
}
