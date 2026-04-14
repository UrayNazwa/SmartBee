import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AkunKaryaSiswa extends StatelessWidget {
  final VoidCallback onBack;
  final Function(Map<String, String>) onKaryaTap;

  const AkunKaryaSiswa({
    super.key,
    required this.onBack,
    required this.onKaryaTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> karya = [
      {
        'title': 'POSTER ANAK BANGSA',
        'author': 'FATHIA SUHAILAH TRIADI',
        'class': 'XII A - SMA',
        'description':
            'Karya poster ini menggambarkan semangat kemerdekaan yang tertuang dalam kreativitas seni rupa modern.',
        'pdfUrl': 'assets/pdf/poster_anak_bangsa.pdf',
        'image': 'assets/images/karya_poster_bangsa.png',
      },
      {
        'title': 'JURNAL',
        'author': 'FATHIA SUHAILAH TRIADI',
        'class': 'XII A - SMA',
        'description':
            'Jurnal penelitian mandiri mengenai pemanfaatan limbah organik di lingkungan sekolah untuk pembuatan pupuk kompos.',
        'pdfUrl': 'assets/pdf/jurnal_fathia.pdf',
        'image': 'assets/images/karya_jurnal.png',
      },
      {
        'title': 'PUISI',
        'author': 'FATHIA SUHAILAH TRIADI',
        'class': 'XII A - SMA',
        'description':
            'Kumpulan puisi bertema "Senja di Sekolah" yang menceritakan kenangan dan harapan di masa SMA.',
        'pdfUrl': 'assets/pdf/puisi_fathia.pdf',
        'image': 'assets/images/karya_puisi.png',
      },
    ];

    return Container(
      color: const Color(0xFFE1D9CD),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 30),
                onPressed: onBack,
              ),
              Expanded(
                child: Text(
                  'Karya Siswa Saya',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D1B10),
                  ),
                ),
              ),
              const SizedBox(width: 48), // Spacer to balance back button
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 0.85,
              ),
              itemCount: karya.length,
              itemBuilder: (context, index) {
                final item = karya[index];
                return GestureDetector(
                  onTap: () => onKaryaTap(item),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(127, 255, 255, 255),
                      borderRadius: BorderRadius.circular(20),
                      // PERBAIKAN: Menambahkan border hitam transparan yang sama dengan frame lain
                      border: Border.all(
                        color: const Color.fromARGB(76, 0, 0, 0),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              // Menambahkan border halus juga di dalam frame gambar agar lebih rapi
                              border: Border.all(
                                color: const Color.fromARGB(30, 0, 0, 0),
                                width: 1,
                              ),
                            ),
                            child: item['image'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.asset(
                                      item['image']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Icon(
                                              Icons.art_track,
                                              size: 100,
                                              color: Colors.grey[300],
                                            );
                                          },
                                    ),
                                  )
                                : Icon(
                                    Icons.art_track,
                                    size: 100,
                                    color: Colors.grey[300],
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Text(
                                item['title']!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8E1D9), // Warna disesuaikan ke earth tone
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color.fromARGB(50, 0, 0, 0),
                                  ),
                                ),
                                child: Text(
                                  item['author']!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
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
              },
            ),
          ),
        ],
      ),
    );
  }
}