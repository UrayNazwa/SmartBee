import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const DashboardScreen({super.key, required this.userData});

  // --- FUNGSI POP-UP NOTIFIKASI ---
  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFFEFEBE9),
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    Text(
                      'Notifikasi',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D1B10),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildNotificationItem('FISIKA MODERN BAB 1', 'Materi telah tersedia di daftar kegiatan belajar Anda.'),
                _buildNotificationItem('FISIKA MODERN BAB 1', 'Tugas telah tersedia di daftar kegiatan belajar Anda.'),
                _buildNotificationItem('FISIKA MODERN BAB 1', 'Quiz telah tersedia di daftar kegiatan belajar Anda.'),
                _buildNotificationItem('KIMIA BAB 1', 'Materi telah tersedia di daftar kegiatan belajar Anda.'),
                _buildNotificationItem('BAHASA INDONESIA BAB 1', 'Materi telah tersedia di daftar kegiatan belajar Anda.'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF81602D),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text('Cek', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // --- UI UTAMA DASHBOARD ---
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeBanner(context),
          const SizedBox(height: 25),
          _buildStatsRow(),
          const SizedBox(height: 30),
          Text(
            'Jadwal Hari Ini',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D1B10),
            ),
          ),
          const SizedBox(height: 15),
          _buildScheduleList(),
        ],
      ),
    );
  }

  Widget _buildWelcomeBanner(BuildContext context) {
    return Stack(
      children: [
        // Background Banner Cokelat
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color(0xFF81602D).withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10), // Memberi ruang untuk icon notifikasi
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'JENJANG : SMA',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Halo, ${userData['name'] ?? 'User'}!',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Selamat datang kembali! Manfaatkan waktu belajarmu dengan maksimal untuk hasil terbaik hari ini.',
                      style: GoogleFonts.poppins(color: Colors.white.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
              Icon(Icons.home_work_outlined, size: 120, color: Colors.white.withOpacity(0.15)),
            ],
          ),
        ),

        // ICON NOTIFIKASI (Lonceng + Badge Merah)
        Positioned(
          top: 20,
          left: 20,
          child: GestureDetector(
            onTap: () => _showNotificationDialog(context),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                  size: 35,
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: const Text(
                      '5',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(Icons.check_circle_outline, 'MATERI PEMBELAJARAN', '15'),
        const SizedBox(width: 20),
        _buildStatCard(Icons.access_time, 'JAM KBM', '06.30 - 15.00'),
        const SizedBox(width: 20),
        _buildStatCard(Icons.assignment_outlined, 'TUGAS TERJADWAL', '10'),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFEFEBE9),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF81602D).withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF2D1B10).withOpacity(0.7),
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D1B10),
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

  Widget _buildScheduleList() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEFEBE9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          _buildScheduleItem('08.00 - 09.00', 'Matematika Lanjut', 'Selesai', isCompleted: true),
          const Divider(height: 1),
          _buildScheduleItem('10.00 - 12.00', 'Ilmu Pengetahuan Alam', 'Belum Selesai'),
          const Divider(height: 1),
          _buildScheduleItem('13.00 - 15.00', 'Matematika Wajib', 'Belum Selesai'),
          const Divider(height: 1),
          _buildScheduleItem('19.00 - 20.30', 'Bahasa Inggris', 'Belum Selesai'),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(String time, String subject, String status, {bool isCompleted = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(time, style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14)),
          ),
          Expanded(
            child: Text(subject, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Text(
            status,
            style: GoogleFonts.poppins(
              color: isCompleted ? Colors.green : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}