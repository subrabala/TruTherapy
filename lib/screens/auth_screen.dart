import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String errText = "";

  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLogin = false;

  InputDecoration buildInputDecoration(String labelText, IconData prefixIcon) {
    return InputDecoration(
      hintText: labelText,
      hintStyle: const TextStyle(fontSize: 12.0, color: Colors.black),
      prefixIcon: Icon(prefixIcon,
          color: const Color.fromARGB(255, 90, 156, 130), size: 18.0),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
            color: Color.fromARGB(255, 90, 156, 130),
            strokeAlign: BorderSide.strokeAlignCenter),
      ),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 90, 156, 130))),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            height: null,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/logo_bg.png'), fit: BoxFit.cover),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.all(35.0),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 224, 255, 246),
                  Color.fromARGB(255, 250, 221, 239),
                ],
                stops: [0.3, 0.9],
                transform: GradientRotation(
                    225 * 3.1415927 / 180), // Convert degrees to radians
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (!_isLogin)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: buildInputDecoration('Name', Icons.person),
                      style: const TextStyle(fontSize: 12),
                      
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: buildInputDecoration('Email', Icons.mail),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: buildInputDecoration('Password', Icons.lock),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                if (!_isLogin)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration:
                          buildInputDecoration('Confirm Password', Icons.lock),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                const SizedBox(height: 20.0),
                // ignore: sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _isLogin ? _login() : _signup();
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Color(0xFF377771)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5)))),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 18))),
                    child: Text(
                      _isLogin ? 'Login' : 'Sign Up',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin ? 'Not a user? Sign Up' : 'Already a user? Log in',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 90, 156, 130), fontSize: 12),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Divider(),
                ),
                // Sign In With Google
                // ignore:sized_box_for_whitespace
                Container(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Your onPressed logic here
                    },
                    icon: Image.asset(
                      'assets/logo_google.png',
                      width: 25,
                      height: 25,
                    ),
                    label: const Text(
                      'Sign in with Google',
                      style: TextStyle(
                        color: Color.fromARGB(255, 97, 97, 97),
                        fontSize: 14,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) {
                            // Change the color when the button is pressed
                            return const Color.fromARGB(255, 255, 255, 255);
                          }
                          // Default color
                          return const Color.fromARGB(255, 255, 255, 255);
                        },
                      ),
                      elevation:
                          MaterialStateProperty.all<double>(0), // No shadow
                      shadowColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 195, 140, 140),
                      ),
                      overlayColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(vertical: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // FutureColor.fromARGB(255, 205, 89, 89)leGoogleSignIn() async {
  //   try {
  //     GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       // Successfully signed in with Google
  //       // You can now use googleSignInAccount to get user information

  //       // For example, accessing user's display name and email:
  //       print('Google Sign In - Display Name: ${googleSignInAccount.displayName}');
  //       print('Google Sign In - Email: ${googleSignInAccount.email}');
  //     } else {
  //       // Handle sign-in cancellation
  //     }
  //   } catch (error) {
  //     // Handle sign-in errors
  //     print('Google Sign In Error: $error');
  //   }
  // }

  void _signup() {
    // Validate input fields
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      // Handle validation error
      return;
    }

    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      // Handle password mismatch error
      return;
    }

    // String apiUrl = 'https://xyz.com/signup';
    // Map<String, String> requestBody = {
    //   'name': _nameController.text,
    //   'email': _emailController.text,
    //   'password': _passwordController.text,
    // };

    // You can use a package like http or dio to make API requests
    // Example with http package:
    // http.post(apiUrl, body: requestBody).then((response) {
    //   // Handle response
    // }).catchError((error) {
    //   // Handle error
    // });
  }

  void _login() {
    // Validate input fields
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Handle validation error
      return;
    }

    // String apiUrl = 'https://xyz.com/login';
    // Map<String, String> requestBody = {
    //   'email': _emailController.text,
    //   'password': _passwordController.text,
    // };

    // You can use a package like http or dio to make API requests
    // Example with http package:
    // http.post(apiUrl, body: requestBody).then((response) {
    //   // Handle response
    // }).catchError((error) {
    //   // Handle error
    // });
  }
}
