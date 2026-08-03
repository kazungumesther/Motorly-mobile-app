import 'package:flutter/material.dart';
// import 'package:flutter/widget_previews.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;

  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24),

                Image.asset(
                  "assets/images/logo.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 16),
                Text(
                  "Login",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.purple),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' please enter an email address';
                    }
                    if (!value.contains('@')) {
                      return 'enter valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'password',
                    prefixIcon: Icon(Icons.password_outlined),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: Icon(
                        _hidePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),

                  obscureText: _hidePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter a password';
                    }
                    return null;
                  },
                  
                ),
                const SizedBox(height: 24),

                
                ElevatedButton(
                    onPressed: () {
                      if (_loginFormKey.currentState!.validate()) {
                        // Perform login action
                        //Navigate to home screen 
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple, 
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Login", style: TextStyle(color: Colors.white)),  
                  ),

                SizedBox(height: 16),

               
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Sign Up", style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

@override
    void dispose(){
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();  
    }

}



