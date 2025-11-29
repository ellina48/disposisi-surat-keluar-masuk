import 'package:flutter/material.dart';

class TUHomePage extends StatefulWidget {
  const TUHomePage({super.key});

  @override
  State<TUHomePage> createState() => _TUHomePageState();
}

class _TUHomePageState extends State<TUHomePage> {
  String selectedFilter = "semua";
  int selectedIndex = 0;

  final List<Map<String, String>> suratList = [
    {
      "tanggal": "Senin, 12 Oktober 2025",
      "jenis": "Surat Keluar",
      "status": "disetujui",
    },
    {
      "tanggal": "Senin, 12 Oktober 2025",
      "jenis": "Surat Masuk",
      "status": "ditolak",
    },
    {
      "tanggal": "Selasa, 13 Oktober 2025",
      "jenis": "Surat Masuk",
      "status": "menunggu",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Map<String, String>> filtered = selectedFilter == "semua"
        ? suratList
        : suratList.where((e) => e["status"] == selectedFilter).toList();

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              // HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logosmk.jpg',
                    width: size.width * 0.12,
                  ),
                  const Icon(
                    Icons.notifications_none,
                    size: 26,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Disposisi Surat",
                style: TextStyle(
                  fontSize: size.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // SEARCH BAR
              Container(
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(Icons.search),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: const InputDecoration(
                            hintText: "Cari surat...",
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // FILTER
              Row(
                children: [
                  filterChip("semua"),
                  const SizedBox(width: 8),
                  filterChip("disetujui"),
                  const SizedBox(width: 8),
                  filterChip("menunggu"),
                  const SizedBox(width: 8),
                  filterChip("ditolak"),
                ],
              ),
              const SizedBox(height: 18),
              // LIST CARD SURAT
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return suratCard(
                      jenis: filtered[index]["jenis"]!,
                      tanggal: filtered[index]["tanggal"]!,
                      status: filtered[index]["status"]!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }

  Widget filterChip(String text) {
    bool active = text == selectedFilter;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: active ? const Color(0xFF4D635B) : Colors.white,
          border: Border.all(color: const Color(0xFF4D635B)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF4D635B),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget suratCard({
    required String jenis,
    required String tanggal,
    required String status,
  }) {
    Color statusColor = status == "disetujui"
        ? const Color(0xFFB8DBC0)
        : status == "ditolak"
        ? const Color(0xFFE7B3B7)
        : const Color(0xFFE7DCA0);

    IconData icon = jenis == "Surat Masuk" ? Icons.inbox : Icons.send;

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
          // TITLE + ICON + STATUS
          Row(
            children: [
              Icon(icon, size: 42, color: statusColor),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jenis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(status, style: const TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
              Text(tanggal, style: const TextStyle(fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          // DETAIL SURAT + BUTTONS
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: jenis == "Surat Masuk"
                      ? [
                          detailRow("No Surat"),
                          detailRow("Asal"),
                          detailRow("Perihal"),
                          detailRow("Tgl Diterima"),
                        ]
                      : [
                          detailRow("Kode"),
                          detailRow("No Surat"),
                          detailRow("Asal"),
                        ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
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
                        "Hapus",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const CircleAvatar(
                    radius: 16,
                    backgroundColor: Color(0xFF1AA7D0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailRow(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(t, style: const TextStyle(fontSize: 13)),
  );

  // NAVBAR BERSIH + TOMBOL + MELAYANG
  Widget bottomNavBar() {
    return SizedBox(
      height: 110,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --- BACKGROUND PILL ---
          Positioned(
            bottom: 15,
            left: 30,
            right: 30,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navIcon(Icons.home, 0),
                  navIcon(Icons.person_outline, 1),

                  const SizedBox(width: 55), // ruang tombol +

                  navIcon(Icons.calendar_month_outlined, 3),
                  navIcon(Icons.person, 4),
                ],
              ),
            ),
          ),

          // --- TOMBOL + BULAT MENGAMBANG ---
          Positioned(
            top: -5,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1AA7D0),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, size: 38, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navIcon(IconData icon, int index) {
    bool active = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Icon(
        icon,
        size: 26,
        color: active ? const Color(0xFF1AA7D0) : Colors.grey,
      ),
    );
  }
}
