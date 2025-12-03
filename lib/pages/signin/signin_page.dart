import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import halaman tujuan setelah user login berdasarkan role/jabatan
import '../TU/menuTU.dart';
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
  // DUMMY DATA LOGIN (untuk testing tanpa backend)
  final List<Map<String, String>> dummyUsers = [
    {"email": "deta002@gmail.com", "password": "deta002", "role": "Tata Usaha"},
    {
      "email": "kepsek@smk.com",
      "password": "kepsek123",
      "role": "Kepala Sekolah",
    },
    {"email": "user@smk.com", "password": "user123", "role": "Lainnya"},
  ];

  /*BAGIAN STATE & CONTROLLER
    digunakan untuk menyimpan input, status UI seperti sembunyikan password,
    dan error validasi. */

  bool _obscurePass = true; // Mengatur icon tampil/sembunyi password
  bool _showError = false; // Error ketika password salah
  bool _showEmptyPassError = false; // Error ketika password masih kosong

  // Controller untuk mengambil input teks dari TextField
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();

  // Dropdown untuk memilih role/jabatan pengguna
  String? selectedRole;
  final List<String> roles = ["Tata Usaha", "Kepala Sekolah", "Lainnya"];

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar agar komponen UI responsif
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Mengatur warna status bar dan navigasi HP agar sesuai tema aplikasi
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFE3F2FD),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),

      /* WILLPOPSCOPE
         - Digunakan untuk mencegah user keluar menggunakan tombol back
         - dan mengarahkan kembali ke halaman WelcomePage. */
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomePage()),
          );
          return false;
        },

        child: Scaffold(
          resizeToAvoidBottomInset:
              false, // Mencegah layout bergeser saat keyboard muncul

          body: Container(
            width: width,
            height: height,

            /*LATAR BELAKANG (BACKGROUND GRADIENT)*/
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
                      physics:
                          const BouncingScrollPhysics(), // Efek scroll lembut
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 0.04),

                          /*BAGIAN LOGO / MASKOT
                             - ditampilkan agar user mengenali aplikasi sebelum login*/
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

                          /*FORM LOGIN DENGAN GLASS EFFECT (Glassmorphism)*/
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 12,
                                sigmaY: 12,
                              ), // Efek blur
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
                                    // Judul form login
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

                                    // INPUT EMAIL
                                    _buildTextField(
                                      controller: emailC,
                                      label: "Email",
                                      icon: Icons.email_outlined,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(height: height * 0.02),

                                    // INPUT PASSWORD + LOGIC SHOW/HIDE
                                    _buildPasswordField(
                                      controller: passwordC,
                                      label: "Kata Sandi",
                                      obscure: _obscurePass,
                                      onTap: () => setState(
                                        () => _obscurePass = !_obscurePass,
                                      ),
                                    ),

                                    // Menampilkan validasi jika user belum mengisi password
                                    if (_showEmptyPassError)
                                      _errorMessage("Isi kata sandi", width),

                                    // Menampilkan pesan jika password salah
                                    if (_showError)
                                      _errorMessage("Kata sandi salah", width),

                                    SizedBox(height: height * 0.02),

                                    // DROPDOWN ROLE / JABATAN
                                    _buildDropdown(width),
                                    SizedBox(height: height * 0.03),

                                    /*TOMBOL LOGIN
                                       - Menjalankan fungsi loginUser() ketika ditekan*/
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

                                    // Link menuju halaman pendaftaran akun
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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

                  // Copyright footer
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                    child: Text(
                      "© 2025 SMKN 2 Singosari. All Rights Reserved",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: width * 0.033,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget reusable untuk error message
  Widget _errorMessage(String msg, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        msg,
        style: TextStyle(color: Colors.red, fontSize: width * 0.035),
      ),
    );
  }

  /*REUSABLE INPUT FIELD (EMAIL ROLE)*/
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

  /*REUSABLE INPUT FIELD PASSWORD (DENGAN TOGGLE ICON)*/
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

        // Icon mata untuk menampilkan atau menyembunyikan password
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

  /*DROPDOWN JABATAN*/
  Widget _buildDropdown(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.black26),
      ),
      child: Row(
        children: [
          const Icon(Icons.person_2_outlined, color: Colors.black54),
          const SizedBox(width: 8),

          Expanded(
            child: DropdownButton<String>(
              value: selectedRole,
              isExpanded: true,
              underline: const SizedBox(),
              hint: Text(
                "Jabatan",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: width * 0.038,
                ),
              ),

              // Mengubah role ketika user memilih opsi
              onChanged: (value) => setState(() => selectedRole = value),

              items: roles.map((role) {
                return DropdownMenuItem(value: role, child: Text(role));
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  /*FUNGSI LOGIN
     - Validasi password & role
     - Menentukan halaman tujuan sesuai jabatan pengguna
     - Backend masih placeholder (print)*/
  Future<void> loginUser() async {
    final email = emailC.text.trim();
    final password = passwordC.text.trim();
    final role = selectedRole;

    // Validasi password kosong
    setState(() {
      _showEmptyPassError = password.isEmpty;
      _showError = false;
    });

    if (password.isEmpty) return;

    // Validasi role belum dipilih
    if (role == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jabatan terlebih dahulu')),
      );
      return;
    }

    // CARI USER DI DUMMY DATA
    final user = dummyUsers.firstWhere(
      (u) =>
          u['email'] == email && u['password'] == password && u['role'] == role,
      orElse: () => {},
    );

    // Jika tidak ditemukan -> error
    if (user.isEmpty) {
      setState(() => _showError = true);
      return;
    }

    // Jika sesuai → NAVIGASI sesuai role
    if (role == "Tata Usaha") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TUHomePage()),
      );
    } else if (role == "Kepala Sekolah") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const KepsekMenu()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MenuOther()),
      );
    }
  }
}
