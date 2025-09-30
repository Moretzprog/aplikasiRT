import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_security/main_navigation.dart';
import 'package:app_security/screens/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _verificationId;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserData();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _otpController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // -------------------- SHARED PREFS --------------------
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email') ?? '';
    final savedPassword = prefs.getString('password') ?? '';
    final remember = prefs.getBool('rememberMe') ?? false;

    if (remember) {
      setState(() {
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
        _rememberMe = true;
      });
    }
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _emailController.text.trim());
      await prefs.setString('password', _passwordController.text.trim());
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  // -------------------- EMAIL LOGIN --------------------
  Future<void> _loginWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Email dan password harus diisi.");
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserData();
      _goToMain();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showMessage(e.message ?? "Login gagal.");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // -------------------- PHONE LOGIN --------------------
  String _formatPhone(String phone) {
    if (phone.startsWith('0')) {
      return '+62${phone.substring(1)}';
    }
    return phone;
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) {
      _showMessage("Nomor telepon harus diisi.");
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _formatPhone(phone),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        _goToMain();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (!mounted) return;
        _showMessage("Verifikasi gagal: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        if (!mounted) return;
        setState(() => _verificationId = verificationId);
        _showOtpDialog();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _verifyOtp() async {
    if (_verificationId == null) return;
    final smsCode = _otpController.text.trim();
    if (smsCode.isEmpty) {
      _showMessage("Masukkan kode OTP");
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _goToMain();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      _showMessage("OTP salah: ${e.message}");
    }
  }

  void _showOtpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // supaya tidak bisa ditutup sembarangan
      builder: (_) => AlertDialog(
        title: const Text("Masukkan OTP"),
        content: TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "6-digit OTP"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _verifyOtp();
            },
            child: const Text("Verifikasi"),
          ),
        ],
      ),
    );
  }

  // -------------------- HELPER --------------------
  void _goToMain() {
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainNavigation()),
      (route) => false, // hapus semua halaman sebelumnya
    );
  }

  void _showMessage(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint ?? label,
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      prefixIcon: Icon(icon, color:Color.fromARGB(255, 93, 115, 123)),
      suffixIcon: suffixIcon,
    );
  }

  Widget _buildRememberMeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Switch(
              value: _rememberMe,
              onChanged: (val) {
                setState(() => _rememberMe = val);
                _saveUserData(); // langsung simpan
              },
              activeThumbColor: Colors.white,
              activeTrackColor: Color(0xFFA4CCD9),
            ),
            const Text(
              "Ingat saya",
              style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 100, 123, 131)),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            _showMessage("Fitur lupa password belum tersedia 😅");
          },
          child: const Text(
            "Lupa Password?",
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 99, 121, 129),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // -------------------- UI --------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFA4CCD9),
                  Color.fromARGB(200, 225, 235, 242),
                  Color.fromARGB(255, 249, 249, 249),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withOpacity(0.1)),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Silakan masuk dengan akun Anda',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40.0),

                  // ----------- TAB LOGIN -----------
                  TabBar(
                    controller: _tabController,
                    labelColor: Color.fromARGB(255, 100, 123, 131),
                    unselectedLabelColor: Colors.black54,
                    indicatorColor: Color.fromARGB(255, 100, 123, 131),
                    tabs: const [
                      Tab(text: "Email"),
                      Tab(text: "Telepon"),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    height: 320.0,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // ---- EMAIL LOGIN ----
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            TextField(
                              controller: _emailController,
                              decoration: _inputDecoration(
                                label: 'Email',
                                icon: Icons.email,
                                hint: 'Masukkan alamat email Anda',
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              "Password",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            TextField(
                              controller: _passwordController,
                              obscureText: !_isPasswordVisible,
                              decoration: _inputDecoration(
                                label: 'Password',
                                icon: Icons.lock,
                                hint: 'Masukkan password Anda',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible = !_isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            _buildRememberMeRow(),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: _isLoading ? null : _loginWithEmail,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 99, 124, 132),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48.0),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    )
                                  : const Text("Login"),
                            ),
                          ],
                        ),

                        // ---- PHONE LOGIN ----
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nomor Telepon",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 6.0),
                            TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: _inputDecoration(
                                label: 'Nomor Telepon',
                                icon: Icons.phone,
                                hint: 'Masukkan nomor telepon Anda',
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _phoneController.clear();
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 50.0),
                            ElevatedButton(
                              onPressed: _sendOtp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 97, 121, 129),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                              ),
                              child: const Text("Kirim OTP"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            color: Color.fromARGB(255, 98, 123, 131),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
