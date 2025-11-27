import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String selectedFilter = "semua";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ===== BODY =====
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HEADER =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/images/logosmk.jpg", height: 32),
                  Icon(
                    Icons.notifications_none,
                    size: 32,
                    color: Colors.grey.shade500,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ===== TITLE =====
              const Text(
                "Disposisi Surat Masuk\nSurat Keluar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 14),

              // ===== SEARCH BAR =====
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black87),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 18),
                    SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "",
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ===== FILTER BUTTONS =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  filterChip("semua"),
                  filterChip("disetujui"),
                  filterChip("menunggu"),
                  filterChip("ditolak"),
                ],
              ),

              const SizedBox(height: 18),

              // ===== CARD SURAT KELUAR =====
              suratCard(
                title: "Surat Keluar",
                date: "Senin, 12 Oktober 2025",
                icon: "assets/surat_keluar.png",
                info: ["Kode", "No Surat", "Asal"],
              ),

              const SizedBox(height: 18),

              // ===== CARD SURAT MASUK =====
              suratCard(
                title: "Surat Masuk",
                date: "Senin, 12 Oktober 2025",
                icon: "assets/surat_masuk.png",
                info: ["No Surat", "Asal", "Perihal", "Tgl Diterima"],
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),

      // ===== FLOATING ADD BUTTON =====
      floatingActionButton: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
          color: const Color(0xFF2BA6B7),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(0.2)),
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 34),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ===== CURVED BOTTOM NAV =====
      bottomNavigationBar: Container(
        height: 78,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(38)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.12),
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navIcon(Icons.home, true),
            navIcon(Icons.group_outlined, false),
            const SizedBox(width: 40), // space for FAB
            navIcon(Icons.insert_drive_file_outlined, false),
            navIcon(Icons.more_horiz, false),
          ],
        ),
      ),
    );
  }

  // ===== FILTER CHIP WIDGET =====
  Widget filterChip(String label) {
    bool active = selectedFilter == label;

    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? Colors.grey.shade800 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: active ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ===== SURAT CARD =====
  Widget suratCard({
    required String title,
    required String date,
    required String icon,
    required List<String> info,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black87, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + Icon + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: const Color(0xFFD3ECF4),
                      child: Image.asset(icon, height: 26),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Text(date, style: const TextStyle(fontSize: 11)),
              ],
            ),

            const SizedBox(height: 10),

            // Details Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black87),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: info
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(e, style: const TextStyle(fontSize: 12)),
                      ),
                    )
                    .toList(),
              ),
            ),

            const SizedBox(height: 10),

            // Button
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4EB5D6),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text(
                  "Selengkapnya",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== NAV ICON =====
  Widget navIcon(IconData icon, bool active) {
    return Icon(
      icon,
      size: 30,
      color: active ? const Color(0xFF2BA6B7) : Colors.grey,
    );
  }
}
