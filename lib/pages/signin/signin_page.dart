import 'dart:ui';
import 'package:flutter/material.dart';

// IMPORT HALAMAN MENU SESUAI ROLE
import '../TU/menu/menuTu.dart';
import '../kepsek/menuukepsek.dart';
import '../other/menuother.dart';
import '../signup/signup_page.dart';
import '../Home/home_page.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignIn> {
  bool _obscurePass = true;
  bool _showError = false;

  // 🔥 Controller untuk backend
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  String selectedRole = "TU";

  // Dummy password sementara untuk cek login
  final String _dummyPassword = "12345";

  // =======================
  // 🔥 BACKEND FUNCTION
  // =======================
  Future<void> loginUser() async {
    final email = emailC.text.trim();
    final password = passwordC.text.trim();
    final role = selectedRole;

    // DEBUG — lihat data apa yang dikirim
    print("=== DATA LOGIN DIKIRIM KE BACKEND ===");
    print("Email: $email");
    print("Password: $password");
    print("Role: $role");
    print("=====================================");

    // kalau mau sambungkan ke backend:
    /*
    final response = await http.post(
      Uri.parse("https://domainmu.com/api/login"),
      body: {
        "email": email,
        "password": password,
        "role": role,
      },
    );

    // setelah login berhasil → arahkan halaman sesuai role
    */

    // sementara tetap pakai dummy:
    if (password == _dummyPassword) {
      _showError = false;

      if (role == "TU") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TUHomePage()),
        );
      } else if (role == "Kepsek") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const KepsekMenu()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      }
    } else {
      setState(() => _showError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomePage()),
        );
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFE3F2FD), Color.fromARGB(255, 255, 98, 50)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.04),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.10,
                          ),
                          child: Transform.translate(
                            offset: Offset(0, height * 0.03),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image.asset(
                                "assets/images/ino1 (1).png",
                                height: height * 0.50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),

                        // GLASSMORPHISM CARD
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: width * 0.06,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.03,
                                horizontal: width * 0.06,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                        fontSize: width * 0.07,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.02),

                                  // EMAIL
                                  _buildTextField(
                                    controller: emailC,
                                    label: "Email",
                                    icon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  SizedBox(height: height * 0.02),

                                  // PASSWORD
                                  _buildPasswordField(
                                    controller: passwordC,
                                    label: "Kata Sandi",
                                    obscure: _obscurePass,
                                    onTap: () {
                                      setState(() {
                                        _obscurePass = !_obscurePass;
                                      });
                                    },
                                  ),
                                  if (_showError)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        "Kata sandi salah",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: width * 0.035,
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: height * 0.02),

                                  _buildDropdown(width),
                                  SizedBox(height: height * 0.03),

                                  // BUTTON LOGIN
                                  SizedBox(
                                    width: double.infinity,
                                    height: height * 0.065,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFF56642,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => loginUser(),
                                      child: Text(
                                        "Masuk",
                                        style: TextStyle(
                                          fontSize: width * 0.050,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: height * 0.03),

                                  // LINK REGISTER
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Belum memiliki akun? ",
                                        style: TextStyle(
                                          fontSize: width * 0.035,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => const SignUp(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Daftar",
                                          style: TextStyle(
                                            color: const Color(0xFFF56642),
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.038,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                      ],
                    ),
                  ),
                ),

                // FOOTER
                Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: height * 0.02),
                      child: Text(
                        "© 2025 SMKN 2 Singosari. All Rights Reserved",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: width * 0.033,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================
  // TEXT FIELD EMAIL
  // ==========================
  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      cursorColor: Colors.blue,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.black),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
      ),
    );
  }

  // ==========================
  // TEXT FIELD PASSWORD
  // ==========================
  Widget _buildPasswordField({
    required String label,
    required bool obscure,
    required VoidCallback onTap,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.black,
          ),
          onPressed: onTap,
        ),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
      ),
    );
  }

  // ==========================
  // DROPDOWN ROLE USER
  // ==========================
  Widget _buildDropdown(double width) {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person_2_outlined,
          color: Colors.black,
          size: width * 0.06,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Colors.grey, width: 1.3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: const [
        DropdownMenuItem(value: "TU", child: Text("Tata Usaha")),
        DropdownMenuItem(value: "Kepsek", child: Text("Kepala Sekolah")),
        DropdownMenuItem(value: "Other", child: Text("Pegawai / Guru")),
      ],
      onChanged: (value) => setState(() => selectedRole = value!),
    );
  }
}
