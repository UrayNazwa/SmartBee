import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AkademikMateriDetail extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const AkademikMateriDetail({
    super.key,
    required this.title,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1D9CD),
      padding: const EdgeInsets.all(25),
      child: ListView(
        physics: const BouncingScrollPhysics(), // Efek scroll yang lebih smooth
        children: [
          const SizedBox(height: 25), // Jarak atas pengganti padding Container
          // Header Section (Sekarang di dalam ListView agar ikut ter-scroll)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(51, 129, 96, 45),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 30),
                    onPressed: onBack,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D1B10),
                      ),
                    ),
                    Text(
                      'Siti Rahma',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: const Color.fromARGB(204, 45, 27, 16),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(204, 255, 255, 255),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '12 - A',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: const Color(0xFF2D1B10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // Bagian Konten BAB
          _buildBabSection('BAB 1: MEKANIKA'),
          const SizedBox(height: 40),
          _buildBabSection('BAB 2: TERMODINAMIKA'),

          const SizedBox(
            height: 40,
          ), // Jarak bawah agar tidak terlalu mepet saat di-scroll pol
        ],
      ),
    );
  }

  Widget _buildBabSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D1B10),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFF718664),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _buildMateriItem('Modul'),
              const SizedBox(height: 15),
              _buildMateriItem('Tugas'),
              const SizedBox(height: 15),
              _buildMateriItem('Quiz'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMateriItem(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: const Color(0xFF2D1B10),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFCDAD7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'To Do',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFFD32F2F),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
