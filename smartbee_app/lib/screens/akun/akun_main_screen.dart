import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class AkunMainScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onKaryaSiswaTap;
  final VoidCallback onPasswordTap;

  const AkunMainScreen({
    super.key,
    required this.userData,
    required this.onKaryaSiswaTap,
    required this.onPasswordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileBanner(),
            const SizedBox(height: 25),
            _buildInformasiPribadi(),
            const SizedBox(height: 25),
            _buildMenuButton(
              icon: Icons.workspace_premium,
              title: 'Karya Siswa',
              onTap: onKaryaSiswaTap,
            ),
            const SizedBox(height: 15),
            _buildMenuButton(
              icon: Icons.lock,
              title: 'Password',
              onTap: onPasswordTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        // Disamakan dengan border hitam tipis frame lainnya
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 2,
              ),
            ),
            child: userData['profileImage'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.asset(
                      userData['profileImage']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 80,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  )
                : const Icon(Icons.person, size: 80, color: AppColors.primary),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'JENJANG : SMA',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  userData['name'] ?? 'Fathia Suhailah Triadi',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userData['class'] ?? 'KELAS 12 - A',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformasiPribadi() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        // PERBAIKAN: Border disamakan dengan frame Detail Nilai dan Password
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Pribadi',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              _infoItem(
                Icons.email_outlined,
                'EMAIL',
                'fathiasuhailah@gmail.com',
              ),
              const SizedBox(width: 50),
              _infoItem(
                Icons.phone_outlined,
                'NOMOR TELEPON',
                '0852-1066-8866',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              _infoItem(Icons.wc_outlined, 'JENIS KELAMIN', 'Perempuan'),
              const SizedBox(width: 50),
              _infoItem(
                Icons.calendar_today_outlined,
                'TANGGAL LAHIR',
                '29 Mei 2005',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceDark.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.textMuted),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          // Tambahkan border juga agar selaras dengan frame di atasnya
          border: Border.all(
            color: AppColors.textPrimary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }
}
