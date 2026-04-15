import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class AdministrasiERaport extends StatefulWidget {
  const AdministrasiERaport({super.key});

  @override
  State<AdministrasiERaport> createState() => _AdministrasiERaportState();
}

class _AdministrasiERaportState extends State<AdministrasiERaport> {
  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });

        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromARGB(51, 0, 0, 0),
                width: 1,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 20),
                Text(
                  'Berhasil!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Kuisioner berhasil dikirim.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showKuisionerPopup(BuildContext context, String guruName) {
    int rating = 0;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setPopupState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Icon(Icons.help_outline, size: 40, color: Colors.black),
                const SizedBox(height: 15),
                Text(
                  'Suara Siswa untuk Guru',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Bantu bapak/ibu guru untuk terus berinovasi dalam mengajar.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.black54),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.orange,
                        size: 40,
                      ),
                      onPressed: () {
                        setPopupState(() => rating = index + 1);
                      },
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Text(
                  'Masukan untuk $guruName',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.background.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Tulis komentar...',
                            hintStyle: GoogleFonts.poppins(fontSize: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          Navigator.pop(context);
                          _showSuccessPopup(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
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
                      'E-Raport',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'Evaluasi belajar semester ganjil - SMA.',
                      style: GoogleFonts.poppins(color: Colors.black54),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.description, size: 18),
                  label: const Text('CETAK RAPORT'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                _buildStatCard('RATA - RATA NILAI', '93', Icons.check_circle),
                const SizedBox(width: 20),
                _buildStatCard('PERINGKAT KELAS', '1/36', Icons.check_circle),
                const SizedBox(width: 20),
                _buildStatCard('KEHADIRAN', '100%', Icons.check_circle),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color.fromARGB(127, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
                // PERBAIKAN: Border hitam diselaraskan dengan frame statistik
                border: Border.all(
                  color: const Color.fromARGB(76, 0, 0, 0),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange),
                          const SizedBox(width: 10),
                          Text(
                            'Detail Nilai Mata Pelajaran',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      _buildMiniSearchBar(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildNilaiTable(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(127, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(76, 0, 0, 0),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniSearchBar() {
    return Container(
      width: 250,
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(76, 158, 158, 158)),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 16, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari Mata Pelajaran',
                hintStyle: GoogleFonts.poppins(fontSize: 12),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNilaiTable(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'mapel': 'Matematika',
        'guru': 'Dr. Andi Wijaya',
        'target': '90',
        'nilai': '95',
        'status': 'Naik',
      },
      {
        'mapel': 'Fisika',
        'guru': 'Siti Rahma',
        'target': '85',
        'nilai': '84',
        'status': 'Turun',
      },
      {
        'mapel': 'Kimia',
        'guru': 'Bambang',
        'target': '88',
        'nilai': '95',
        'status': 'Naik',
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              _headerCell('MATA PELAJARAN', 2),
              _headerCell('GURU PENGAMPU', 2),
              _headerCell('TARGET', 1),
              _headerCell('NILAI', 1),
              _headerCell('STATUS', 1),
              _headerCell('Kuisioner Guru', 1),
            ],
          ),
        ),
        const Divider(),
        ...data.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: [
                _dataCell(item['mapel'], 2, isBold: true),
                _dataCell(item['guru'], 2),
                _dataCell(item['target'], 1),
                _dataCell(item['nilai'], 1, isBold: true),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: item['status'] == 'Naik'
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['status'] == 'Naik'
                              ? Icons.trending_up
                              : Icons.trending_down,
                          size: 14,
                          color: item['status'] == 'Naik'
                              ? AppColors.success
                              : AppColors.error,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item['status'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: item['status'] == 'Naik'
                                ? AppColors.success
                                : AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: const Icon(Icons.send, size: 18),
                    onPressed: () => _showKuisionerPopup(context, item['guru']),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String label, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _dataCell(String label, int flex, {bool isBold = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
        ),
      ),
    );
  }
}
