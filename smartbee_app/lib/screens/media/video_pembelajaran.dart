import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaVideoPembelajaran extends StatefulWidget {
  final Function(String) onSearch;

  const MediaVideoPembelajaran({super.key, required this.onSearch});

  @override
  State<MediaVideoPembelajaran> createState() => _MediaVideoPembelajaranState();
}

class _MediaVideoPembelajaranState extends State<MediaVideoPembelajaran> {
  // Data master untuk Video
  final List<Map<String, String>> allVideos = [
    {
      'mapel': 'MATEMATIKA',
      'title': 'Kalkulus Dasar dalam 10 Menit',
      'tutor': 'Dr. Andi Wijaya',
      'image': 'assets/images/video_matematika.png',
    },
    {
      'mapel': 'BIOLOGI',
      'title': 'Struktur Sel dan Fungsinya',
      'tutor': 'Ibu Sari Pratama',
      'image': 'assets/images/video_biologi.png',
    },
    {
      'mapel': 'FISIKA',
      'title': 'Hukum Newton I, II, dan III',
      'tutor': 'Bpk. Budi Rahardjo',
      'image': 'assets/images/video_fisika.png',
    },
    {
      'mapel': 'KIMIA',
      'title': 'Tabel Periodik Unsur',
      'tutor': 'Siti Aminah, M.Si',
      'image': 'assets/images/video_kimia.png',
    },
    {
      'mapel': 'EKONOMI',
      'title': 'Mekanisme Pasar & Harga',
      'tutor': 'Dr. Faisal Basri',
      'image': 'assets/images/video_ekonomi.png',
    },
    {
      'mapel': 'SOSIOLOGI',
      'title': 'Interaksi Sosial di Masyarakat',
      'tutor': 'Bpk. Gunawan',
      'image': 'assets/images/video_sosiologi.png',
    },
  ];

  // List untuk menampilkan video hasil filter
  List<Map<String, String>> displayedVideos = [];

  @override
  void initState() {
    super.initState();
    // Awalnya tampilkan semua video
    displayedVideos = allVideos;
  }

  // Fungsi untuk menyaring video berdasarkan input user
  void _filterVideos(String query) {
    setState(() {
      displayedVideos = allVideos
          .where(
            (video) =>
                video['title']!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
    // Menjalankan callback onSearch agar parent tetap terupdate jika perlu
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
                    'Video Pembelajaran',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D1B10),
                    ),
                  ),
                  Text(
                    'Video Pembelajaran untuk Jenjang SMA',
                    style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              _buildSearchBar('Cari Judul Video'),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: displayedVideos.isEmpty
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
                    itemCount: displayedVideos.length,
                    itemBuilder: (context, index) {
                      final video = displayedVideos[index];
                      return _buildVideoCard(video);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFC4B6A6),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black.withOpacity(0.05),
                  width: 1,
                ),
              ),
              child: Center(
                child: video['image'] != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          video['image']!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.play_circle_fill_rounded,
                              size: 60,
                              color: Colors.white70,
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.play_circle_fill_rounded,
                        size: 60,
                        color: Colors.white70,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video['mapel']!,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF81602D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  video['title']!,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D1B10),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  video['tutor']!,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ],
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
              onChanged: _filterVideos, // Filter langsung saat mengetik
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
          Icon(Icons.video_library_sharp, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Video tidak ditemukan',
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
