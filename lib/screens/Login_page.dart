import 'package:flutter/material.dart';
import '../screens/ProductListScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                ),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _logo(),
                    const SizedBox(height: 40),
                    _header(context),
                    const SizedBox(height: 40),
                    _inputField(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    return Column(
      children: [
        Image.asset('assets/logo.png', height: 180),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Admin Only",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 78, 122),
          ),
        ),
        Text(
          "Enter your credentials to login",
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(237, 156, 219, 255),
          ),
        ),
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromARGB(134, 0, 238, 255).withOpacity(0.3),
            filled: true,
            prefixIcon: const Icon(Icons.email, color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.white70),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Color.fromARGB(134, 0, 238, 255).withOpacity(0.3),
            filled: true,
            prefixIcon: const Icon(Icons.lock, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;

            try {
              UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductListScreen()),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed: ${e.toString()}')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 166, 176, 211),
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ).copyWith(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.purple.shade700;
                } else if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return const Color.fromARGB(250, 1, 140, 150);
              },
            ),
            textStyle: MaterialStateProperty.resolveWith<TextStyle>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return const TextStyle(fontSize: 20, color: Color.fromRGBO(219, 226, 239, 1));
                } else if (states.contains(MaterialState.disabled)) {
                  return const TextStyle(fontSize: 20, color: Colors.grey);
                }
                return const TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 255, 255));
              },
            ),
          ),
          child: const Text("Login"),
        ),
      ],
    );
  }
}
