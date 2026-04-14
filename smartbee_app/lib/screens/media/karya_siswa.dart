import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaKaryaSiswa extends StatefulWidget {
  final Function(String) onSearch;
  final Function(Map<String, String>) onKaryaTap;

  const MediaKaryaSiswa({
    super.key,
    required this.onSearch,
    required this.onKaryaTap,
  });

  @override
  State<MediaKaryaSiswa> createState() => _MediaKaryaSiswaState();
}

class _MediaKaryaSiswaState extends State<MediaKaryaSiswa> {
  // Data master (tidak berubah)
  final List<Map<String, String>> allKarya = [
    {
      'title': 'POSTER ANAK BANGSA',
      'author': 'FATHIA SUHAILAH TRIADI',
      'class': 'XII A - SMA',
      'description':
          'Karya ini bertema tentang semangat juang anak bangsa dalam meraih cita-cita dan mengharumkan nama bangsa Indonesia di kancah internasional.',
      'pdfUrl': 'assets/pdf/poster_anak_bangsa.pdf',
      'image': 'assets/images/poster-anak-bangsa.png',
    },
    {
      'title': 'JURNAL',
      'author': 'FATHIA SUHAILAH TRIADI',
      'class': 'XII A - SMA',
      'description':
          'Jurnal ilmiah mengenai dampak teknologi terhadap pendidikan karakter siswa di era digital, dengan studi kasus di lingkungan sekolah.',
      'pdfUrl': 'assets/pdf/jurnal_fathia.pdf',
      'image': 'assets/images/jurnal.png',
    },
    {
      'title': 'PUISI',
      'author': 'GHINA RAUDHOTUL FASHLI',
      'class': 'XI B - SMA',
      'description':
          'Kumpulan puisi bertema alam dan lingkungan, mengajak pembaca untuk lebih mencintai dan menjaga kelestarian bumi pertiwi.',
      'pdfUrl': 'assets/pdf/puisi_ghina.pdf',
      'image': 'assets/images/bahasa-indonesia.png',
    },
    {
      'title': 'POSTER',
      'author': 'URAY NAZWA SHAVIRA',
      'class': 'X C - SMA',
      'description':
          'Poster edukatif mengenai pencegahan bullying di sekolah dan pentingnya membangun pertemanan yang sehat.',
      'pdfUrl': 'assets/pdf/poster_uray.pdf',
      'image': 'assets/images/fisika.png',
    },
    {
      'title': 'MADING',
      'author': 'URAY NAZWA SHAVIRA',
      'class': 'X C - SMA',
      'description':
          'Desain mading digital yang berisi berita terkini sekolah, tips belajar, dan karya-karya singkat dari teman-teman sekelas.',
      'pdfUrl': 'assets/pdf/mading_uray.pdf',
      'image': 'assets/images/mading.png',
    },
  ];

  // Data yang ditampilkan setelah difilter
  List<Map<String, String>> displayedKarya = [];

  @override
  void initState() {
    super.initState();
    // Awalnya tampilkan semua data
    displayedKarya = allKarya;
  }

  // Fungsi filter pencarian berdasarkan nama
  void _filterKarya(String query) {
    setState(() {
      displayedKarya = allKarya
          .where(
            (item) =>
                item['author']!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
    // Tetap panggil callback onSearch jika dibutuhkan di luar
    widget.onSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1D9CD),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Karya Siswa',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D1B10),
                    ),
                  ),
                  Text(
                    'Koleksi Karya Siswa jenjang SMA.',
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              _buildSearchBar('Cari Nama Siswa'),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: displayedKarya.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: displayedKarya.length,
                    itemBuilder: (context, index) {
                      final item = displayedKarya[index];
                      return _buildKaryaCard(item);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildKaryaCard(Map<String, String> item) {
    return GestureDetector(
      onTap: () => widget.onKaryaTap(item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: item['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[100],
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        "Error: ${item['image']}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.art_track_rounded,
                          size: 70,
                          color: Colors.grey[300],
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Column(
                children: [
                  Text(
                    item['title']!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: const Color(0xFF2D1B10),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item['author']!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(String hint) {
    return Container(
      width: 240,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF81602D).withOpacity(0.5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: Color(0xFF81602D)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: _filterKarya, // Langsung filter saat diketik
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Karya tidak ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
