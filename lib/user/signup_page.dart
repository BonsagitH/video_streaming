// ignore_for_file: unnecessary_this
import 'package:flutter/material.dart';
import 'package:video_streaming/main.dart';
import 'package:video_streaming/videos/main_videos_page.dart';
import 'package:video_streaming/videos/video_stream_page.dart';

void main() => runApp(const Signup_page());

// ignore: camel_case_types
class Signup_page extends StatelessWidget {
  const Signup_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Streaming',
      theme: ThemeData(cardColor: Color.fromARGB(255, 85, 37, 5)),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType { login, register }

class _LoginPageState extends State<RegisterPage> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          // this part is used to gradient the toolbar
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromARGB(255, 4, 64, 184),
                  Color.fromARGB(255, 209, 73, 148),
                  Color.fromARGB(255, 241, 210, 31)
                ]),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
        ),

        title: const Text("Create Account"),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Color.fromARGB(255, 168, 85, 92),

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.dark_mode),
            tooltip: 'Comment Icon',
            onPressed: () {},
          ), //IconButton

          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Setting Icon',
            onPressed: () {},
          ), //IconButton
        ], //<Widget>[]

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'bacck to login page',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const MainPage(), //this is take the page to login page/main.dart
                ));
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTextFields(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  bool showpass = false;
  Widget _buildTextFields() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'First Name:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            const Divider(height: 10, thickness: 4, color: Colors.white),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Middle Name:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            const Divider(height: 10, thickness: 4, color: Colors.white),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Last Name:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            const Divider(height: 10, thickness: 4, color: Colors.white),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter an Email:',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                prefixIcon: Icon(Icons.email, color: Colors.blue),
              ),
            ),
            const Divider(height: 10, thickness: 4, color: Colors.white),
            TextField(
              obscureText: !this.showpass,
              decoration: InputDecoration(
                labelText: 'password',
                prefixIcon: const Icon(Icons.security),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this.showpass ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => this.showpass = !this.showpass);
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            ),
            const Divider(height: 10, thickness: 4, color: Colors.white),
            TextField(
              obscureText: !this.showpass,
              decoration: InputDecoration(
                labelText: 'Re-Type Password',
                prefixIcon: const Icon(Icons.security),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: this.showpass ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => this.showpass = !this.showpass);
                  },
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 106, 50, 114),
              disabledForegroundColor:
                  Color.fromARGB(255, 197, 13, 127).withOpacity(0.38),
              disabledBackgroundColor:
                  Color.fromARGB(255, 209, 223, 12).withOpacity(0.12),
              elevation: 20, // Elevation
              shadowColor: Color.fromARGB(255, 212, 113, 73), // Shadow Color
              side: BorderSide(color: Colors.blue.shade100, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(200, 40), //////// HERE
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MainVideosPage(), //this is take the page to login page/main.dart
                  ));
            },
            child: const Text('Sign up'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        YoutubePlayerDemoApp(), //this is take the page to login page/main.dart//today i used it to check video player
                  ));
            },
            child: const Text('Do you have an account? Tap here to signin.'),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: _createAccountPressed,
            child: const Text('Create an Account'),
          ),
          ElevatedButton(
            onPressed: _formChange,
            child: const Text('Have an account? Click here to login.'),
          )
        ],
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password

  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
  }

  void _createAccountPressed() {
    print('The user wants to create an accoutn with $_email and $_password');
  }

  void _passwordReset() {
    print("The user wants a password reset request sent to $_email");
  }
}
