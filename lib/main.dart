import 'package:apitest/Helper/APIservice.dart';
import 'package:apitest/Login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Splas(),
    );
  }
}

class Splas extends StatefulWidget {
  const Splas({Key key}) : super(key: key);

  @override
  State<Splas> createState() => _SplasState();
}

class _SplasState extends State<Splas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/adlogo.png",
          height: 300,
          width: 300,
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => Login()), (route) => false);
    });
  }
}

class Sing extends StatefulWidget {
  const Sing({Key key}) : super(key: key);

  @override
  State<Sing> createState() => _SingState();
}

class _SingState extends State<Sing> {
  TextEditingController Name = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController Pass = new TextEditingController();
  TextEditingController Contect = new TextEditingController();
  TextEditingController Address = new TextEditingController();
  bool Pshow = true;
  bool CPshow = true;
  String NameError, EmailError, PassEroor, ContError, AddError;
  bool NameValidate, EmailValidate, PassValidate, ContValidate, AddValidate;

  @override
  void initState() {
    super.initState();
    NameValidate =
        EmailValidate = PassValidate = ContValidate = AddValidate = false;
    NameError = EmailError = PassEroor = ContError = AddError = "";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(70)),
              Text(
                "Sing up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.all(20)),
              TextField(
                controller: Name,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: "Enter your Fullname",
                    hintText: "Enter your Fullname",
                    errorText: NameValidate ? NameError : null),
              ),
              Padding(padding: EdgeInsets.all(5)),
              TextField(
                controller: Email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: "Enter your Email",
                    hintText: "Enter your Email",
                    errorText: EmailValidate ? EmailError : null),
              ),
              Padding(padding: EdgeInsets.all(5)),
              TextField(
                obscureText: Pshow,
                controller: Pass,
                decoration: InputDecoration(
                    errorText: PassValidate ? PassEroor : null,
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
              Padding(padding: EdgeInsets.all(5)),
              TextField(
                maxLength: 10,
                controller: Contect,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: ContValidate ? ContError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: "Enter your Contect number",
                  labelText: "Enter your Contect number",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              TextField(
                controller: Address,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    labelText: "Enter your Address",
                    hintText: "Enter your Address",
                    errorText: AddValidate ? AddError : null),
              ),
              Padding(padding: EdgeInsets.all(5)),
              ElevatedButton(
                  onPressed: () {
                    if (validate() == 0) {
                      _singup();
                    }
                  },
                  child: Text("Sing up")),
              RichText(text: TextSpan(
                text: "you have already have account ? ",
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                      text: " Log in",
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap=(){
                        Navigator.pop(context,MaterialPageRoute(builder: (context)=>Login()));
                      }
                  ),
                ],
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _singup() async {
    Map<String, dynamic> map = Map();
    map['name'] = Name.text;
    map['email'] = Email.text;
    map['password'] = Pass.text;
    map['mobile'] = Contect.text;
    map['address'] = Address.text;
    print(map);
    var result = await APIService().signup(map);
    if (result.message == "success") {
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("success")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("contect to admin")));
    }
  }

  int validate() {
    int cnt = 0;
    if (Name.text.isEmpty) {
      setState(() {
        NameError = "Enter Fullname";
        NameValidate = true;
      });
      cnt++;
    } else {
      setState(() {
        NameError = "";
        NameValidate = false;
      });
    }
    if (Email.text.isEmpty) {
      setState(() {
        EmailError = "Enter Email";
        EmailValidate = true;
      });
      cnt++;
    } else {
      setState(() {
        EmailError = "";
        EmailValidate = false;
      });
    }
    if (Pass.text.isEmpty) {
      setState(() {
        PassEroor = "Enter your Password";
        PassValidate = true;
      });
      cnt++;
    } else {
      setState(() {
        PassEroor = "Enter your Password";
        PassValidate = false;
      });
    }
    if (Contect.text.isEmpty) {
      setState(() {
        ContError = "Enter your Contact";
        ContValidate = true;
      });
      cnt++;
    } else {
      setState(() {
        ContError = "Enter your Contact";
        ContValidate = false;
      });
    }
    if (Address.text.isEmpty) {
      setState(
        () {
          AddError = "Enter your Address";
          AddValidate = true;
        },
      );
      cnt++;
    } else {
      setState(() {
        AddError = "Enter your Address";
        AddValidate = false;
      });
    }
    return cnt;
  }
}

//
// body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
// itemCount: imageList.length,
// scrollDirection: Axis.vertical,
// itemBuilder:(context , index)=> dis(imageList[index],titleList[index]) ,
// ),