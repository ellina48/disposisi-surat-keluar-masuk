import 'package:flutter/material.dart';

class SuratMasukPage extends StatelessWidget {
  const SuratMasukPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFE0963A)),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Surat Masuk",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE0963A),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textFieldLabel("Nomor Surat"),
            inputField("Masukkan nomor surat", orangeBorder),

            textFieldLabel("Perihal"),
            inputField("Masukkan perihal surat", orangeBorder),

            textFieldLabel("Asal"),
            inputField("Masukkan asal surat", orangeBorder),

            textFieldLabel("Tanggal Surat"),
            inputField("Masukkan tanggal surat", orangeBorder),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                uploadButton("Unggah", const Color(0xFFE0963A)),
                sendButton("Kirim", const Color(0xFFC06B24)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// 🔽 Reusable Components
final orangeBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Color(0xFFE0963A)),
);

Widget textFieldLabel(String txt) => Padding(
  padding: const EdgeInsets.only(top: 12, bottom: 4),
  child: Text(txt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
);

Widget inputField(String hint, OutlineInputBorder border) => TextField(
  decoration: InputDecoration(
    hintText: hint,
    border: border,
    enabledBorder: border,
    focusedBorder: border,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
  ),
);

Widget uploadButton(String text, Color color) => ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.upload),
  label: Text(text),
  style: ElevatedButton.styleFrom(
    backgroundColor: color,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
);

Widget sendButton(String text, Color color) => ElevatedButton(
  onPressed: () {},
  child: Text(text),
  style: ElevatedButton.styleFrom(
    backgroundColor: color,
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
);
