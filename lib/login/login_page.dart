
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:rental_camera_admin/screens/dashboard_screen.dart';

import '../styles.dart';
import '../utils/navigator.dart';
import '../widgets/button.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _body(false),
      ),
    );
  }

  Widget _body(bool isSmall) {
    return LoadingOverlay(
      isLoading: _isLoading,
      color: kGreyBgColor,
      opacity: 0.7,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: isSmall ? null : MediaQuery.of(context).size.width / 3,
            margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
            padding:
            const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: kWhiteBgColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24.0),
                  _buildEmail(),
                  const SizedBox(height: 10.0),
                  _buildPassword(),
                  const SizedBox(height: 40.0),
                  Button(
                    textButton: "Masuk",
                    onTap: _login,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kata Sandi",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextField(
          controller: _passwordController,
          style: blackTextStyle,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Masukkan password Anda",
            hintStyle: greyTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Alamat Email",
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextField(
          controller: _emailController,
          style: blackTextStyle,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Masukkan email Anda",
            hintStyle: greyTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // TODO: Ganti jadi judul aplikasi
        Text(
          "PA Rental",
          style: blackTextStyle.copyWith(fontSize: 26, fontWeight: semiBold),
        ),
        Text(
          "Selamat Datang Admin",
          style: greyTextStyle.copyWith(fontSize: 14, fontWeight: regular),
        ),
      ],
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: Masukkan email untuk dijadikan admin di string kosong ''
      if (_formKey.currentState!.validate() &&
          (_emailController.text == 'ridhoi@gmail.com' ||
              _emailController.text == '')) {
        try {
          final email = _emailController.text;
          final password = _passwordController.text;

          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((result) {
            Navigation.intentReplacement(DashboardScreen.routeName);
          });
          setState(() {
            _isLoading = false;
          });
        }catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Gagal'),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                    child: Text('Tutup'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Gagal'),
              content: Text('Email atau password salah.'),
              actions: [
                TextButton(
                  child: Text('Tutup'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        setState(() {
          _isLoading = false;
        });
      }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}