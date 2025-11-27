import 'package:flutter/material.dart';

class KepsekMenu extends StatefulWidget {
  const KepsekMenu({super.key});

  @override
  State<KepsekMenu> createState() => _KepsekMenuState();
}

class _KepsekMenuState extends State<KepsekMenu> {
  String selectedFilter = "Semua";
  int selectedIndex = 0;

  final List<Map<String, dynamic>> suratList = [
    {"tanggal": "Senin, 12 Oktober 2025", "jenis": "Surat Keluar"},
    {"tanggal": "Senin, 12 Oktober 2025", "jenis": "Surat Masuk"},
    {"tanggal": "Selasa, 13 Oktober 2025", "jenis": "Surat Masuk"},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List filteredSurat = selectedFilter == "Semua"
        ? suratList
        : suratList.where((s) => s["jenis"] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xffffffff),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER LOGO + NOTIF
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/logosmk.jpg",
                    width: size.width * 0.12,
                  ),
                  const Icon(Icons.notifications_none, size: 30),
                ],
              ),

              const SizedBox(height: 15),

              // ← posisi teks diatur di sini
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                ), // atur nilai sesuai keinginan
                child: Text(
                  "Disposisi Surat Masuk\nSurat Keluar",
                  style: TextStyle(
                    fontSize: size.width * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// SEARCH BAR
              Container(
                height: size.height * 0.055,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: "Cari surat...",
                            border: InputBorder.none,
                            isDense:
                                true, // <- ini penting agar tinggi InputDecoration pas
                            contentPadding:
                                EdgeInsets.zero, // <- hapus padding default
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// FILTER SURAT BUTTONS
              Row(
                children: [
                  filterButton("Semua"),
                  const SizedBox(width: 25),
                  filterButton("Surat Keluar"),
                  const SizedBox(width: 25),
                  filterButton("Surat Masuk"),
                  const SizedBox(width: 25),
                ],
              ),

              const SizedBox(height: 17),

              /// LIST SURAT
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSurat.length,
                  itemBuilder: (context, index) {
                    return suratCard(
                      tanggal: filteredSurat[index]["tanggal"],
                      jenis: filteredSurat[index]["jenis"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      /// NEW NAVBAR STYLE
      bottomNavigationBar: bottomNavBar(),
    );
  }

  // ====================== NEW SOFT UI BOTTOM NAVBAR ======================

  Widget bottomNavBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 25,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navIcon("assets/icons/ic_home.png", 0),
          navIcon("assets/icons/ic_history.png", 1),
          navIcon("assets/icons/ic_profile.png", 2),
        ],
      ),
    );
  }

  Widget navIcon(String iconPath, int index) {
    bool active = selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: AnimatedScale(
        scale: active ? 1.25 : 1.0,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        child: Image.asset(
          iconPath,
          width: 28,
          color: active
              ? const Color(0xFF0A6F82)
              : Colors.grey.withOpacity(0.45),
        ),
      ),
    );
  }

  // ====================== FILTER BUTTON ======================

  Widget filterButton(String title) {
    bool active = title == selectedFilter;

    return GestureDetector(
      onTap: () => setState(() => selectedFilter = title),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF187DA3) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF187DA3), width: 1.2),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: active ? Colors.white : const Color(0xFF187DA3),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ====================== SURAT CARD ======================

  Widget suratCard({required String tanggal, required String jenis}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// TITLE + ICON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFFC1E5F2),
                    child: Image.asset(
                      jenis == "Surat Masuk"
                          ? "assets/icons/ic_inmail.png"
                          : "assets/icons/ic_outmail.png",
                      width: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    jenis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              Text(tanggal, style: const TextStyle(fontSize: 12)),
            ],
          ),

          const SizedBox(height: 15),
          detailBox(jenis),
          const SizedBox(height: 15),

          /// BUTTON SELENGKAPNYA
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 115,
              height: 32,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1AA7D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Selengkapnya",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget detailBox(String jenis) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: jenis == "Surat Masuk"
            ? [
                detailText("No Surat"),
                detailText("Asal"),
                detailText("Perihal"),
                detailText("Tanggal Diterima"),
              ]
            : [
                detailText("Kode Surat"),
                detailText("No Surat"),
                detailText("Tujuan"),
              ],
      ),
    );
  }

  Widget detailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontSize: 13)),
    );
  }
}
