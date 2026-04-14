import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaKaryaSiswaDetail extends StatelessWidget {
  final Map<String, String> karya;
  final VoidCallback onBack;

  const MediaKaryaSiswaDetail({
    super.key,
    required this.karya,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1D9CD),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back Button and Title
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2D1B10)),
                onPressed: onBack,
              ),
              const SizedBox(width: 10),
              Text(
                'Detail Karya Siswa',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D1B10),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // PDF Preview / Icon Section
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 500, 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        // Menambahkan Border di frame Preview
                        border: Border.all(
                          color: Colors.black.withOpacity(0.4),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.picture_as_pdf_rounded,
                            size: 120,
                            color: Colors.redAccent,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'PDF Karya',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Klik untuk membuka file',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Membuka file PDF...'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Buka PDF'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF81602D),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 30),
                  
                  // Information Section
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoField('Judul Karya', karya['title'] ?? '-'),
                        const SizedBox(height: 20),
                        _buildInfoField('Nama Siswa', karya['author'] ?? '-'),
                        const SizedBox(height: 20),
                        _buildInfoField('Kelas', karya['class'] ?? '-'),
                        const SizedBox(height: 20),
                        _buildInfoField(
                          'Deskripsi Karya', 
                          karya['description'] ?? 'Tidak ada deskripsi untuk karya ini.',
                          isLongText: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value, {bool isLongText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF81602D),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            // Mempertegas border di setiap frame info
            border: Border.all(
              color: Colors.black87.withOpacity(0.5),
              width: 1.2,
            ),
          ),
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: const Color(0xFF2D1B10),
              height: 1.5,
            ),
            maxLines: isLongText ? 10 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}