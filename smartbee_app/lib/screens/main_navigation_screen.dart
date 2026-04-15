import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/logo_widget.dart';
import 'dashboard_screen.dart';
import 'splash_screen.dart';
import 'akademik/ebook.dart';
import 'akademik/e_learning.dart';
import 'akademik/e_learning_materi_detail.dart';
import 'akademik/rancangan_pembelajaran.dart';
import 'media/kamus.dart';
import 'media/karya_siswa.dart';
import 'media/karya_siswa_detail.dart';
import 'media/video_pembelajaran.dart';
import 'administrasi/e_raport.dart';
import 'administrasi/manajemen_data.dart';
import 'akun/akun_main_screen.dart';
import 'akun/akun_karya_siswa_screen.dart';
import 'akun/akun_ubah_password_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const MainNavigationScreen({super.key, required this.userData});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  String _activeMenu = 'Dashboard';
  String _activeSubMenu = '';
  Map<String, String>? _selectedKarya;
  bool _isAkademikExpanded = false;
  bool _isMediaExpanded = false;
  bool _isAdministrasiExpanded = false;
  bool _isSuperAdminExpanded = false;

  bool get isSuperAdmin => widget.userData['role'] == 'super_admin';

  void _showGlobalSuccessPopup(String message) {
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
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      height: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: LogoWidget(size: 50),
                  ),
                  _buildSidebarItem(
                    Icons.home_outlined,
                    'Dashboard',
                    isActive: _activeMenu == 'Dashboard',
                    onTap: () {
                      setState(() {
                        _activeMenu = 'Dashboard';
                        _activeSubMenu = '';
                        _isAkademikExpanded = false;
                        _isMediaExpanded = false;
                        _isAdministrasiExpanded = false;
                      });
                    },
                  ),
                  if (!isSuperAdmin) ...[
                    _buildSidebarItem(
                      Icons.menu_book,
                      'Akademik',
                      isActive: _activeMenu == 'Akademik',
                      hasSubmenu: true,
                      isExpanded: _isAkademikExpanded,
                      onTap: () {
                        setState(() {
                          _activeMenu = 'Akademik';
                          _activeSubMenu = 'E-Book';
                          _isAkademikExpanded = true;
                          _isMediaExpanded = false;
                          _isAdministrasiExpanded = false;
                        });
                      },
                    ),
                    if (_isAkademikExpanded) ...[
                      _buildSubMenu('E-Book'),
                      _buildSubMenu('E-Learning'),
                      _buildSubMenu('Rancangan Pembelajaran'),
                    ],
                    _buildSidebarItem(
                      Icons.play_circle_outline,
                      'Media',
                      isActive: _activeMenu == 'Media',
                      hasSubmenu: true,
                      isExpanded: _isMediaExpanded,
                      onTap: () {
                        setState(() {
                          _activeMenu = 'Media';
                          _activeSubMenu = 'Kamus';
                          _isMediaExpanded = true;
                          _isAkademikExpanded = false;
                          _isAdministrasiExpanded = false;
                        });
                      },
                    ),
                    if (_isMediaExpanded) ...[
                      _buildSubMenu('Kamus'),
                      _buildSubMenu('Karya Siswa'),
                      _buildSubMenu('Video Pembelajaran'),
                    ],
                    _buildSidebarItem(
                      Icons.assignment_outlined,
                      'Administrasi',
                      isActive: _activeMenu == 'Administrasi',
                      hasSubmenu: true,
                      isExpanded: _isAdministrasiExpanded,
                      onTap: () {
                        setState(() {
                          _activeMenu = 'Administrasi';
                          _activeSubMenu = 'E-Raport';
                          _isAdministrasiExpanded = true;
                          _isAkademikExpanded = false;
                          _isMediaExpanded = false;
                        });
                      },
                    ),
                    if (_isAdministrasiExpanded) ...[
                      _buildSubMenu('E-Raport'),
                      _buildSubMenu('Manajemen Data'),
                    ],
                  ],
                  if (isSuperAdmin) ...[
                    _buildSidebarItem(
                      Icons.admin_panel_settings,
                      'Super Admin',
                      isActive: _activeMenu == 'Super Admin',
                      hasSubmenu: true,
                      isExpanded: _isSuperAdminExpanded,
                      onTap: () {
                        setState(() {
                          _activeMenu = 'Super Admin';
                          _activeSubMenu = 'Manajemen User';
                          _isSuperAdminExpanded = true;
                          _isAkademikExpanded = false;
                          _isMediaExpanded = false;
                          _isAdministrasiExpanded = false;
                        });
                      },
                    ),
                    if (_isSuperAdminExpanded) ...[
                      _buildSubMenu('Manajemen User'),
                      _buildSubMenu('Konfigurasi Sistem'),
                    ],
                  ],
                  _buildSidebarItem(
                    Icons.person_outline,
                    'Akun',
                    isActive: _activeMenu == 'Akun',
                    onTap: () {
                      setState(() {
                        _activeMenu = 'Akun';
                        _activeSubMenu = '';
                        _isAkademikExpanded = false;
                        _isMediaExpanded = false;
                        _isAdministrasiExpanded = false;
                        _isSuperAdminExpanded = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          if (!isSuperAdmin) _buildLogoutSection(),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
    IconData icon,
    String title, {
    bool isActive = false,
    bool hasSubmenu = false,
    bool isExpanded = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap:
          onTap ??
          () => setState(() {
            _activeMenu = title;
            _activeSubMenu = '';
            _isAkademikExpanded = false;
            _isMediaExpanded = false;
            _isAdministrasiExpanded = false;
          }),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isActive ? Colors.white : AppColors.textPrimary,
            size: 24,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: isActive ? Colors.white : AppColors.textPrimary,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              fontSize: 16,
            ),
          ),
          trailing: hasSubmenu
              ? Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: isActive ? Colors.white : AppColors.textPrimary,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSubMenu(String title) {
    bool isSubActive =
        _activeSubMenu == title ||
        (_activeSubMenu.startsWith('Materi:') && title == 'E-Learning') ||
        (_activeSubMenu.startsWith('DetailKarya:') && title == 'Karya Siswa') ||
        (_activeSubMenu.startsWith('DetailKaryaSaya:') &&
            title == 'Karya Siswa Saya');
    return InkWell(
      onTap: () => setState(() => _activeSubMenu = title),
      child: Container(
        margin: const EdgeInsets.only(left: 30, right: 15, top: 2, bottom: 2),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSubActive ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: isSubActive
                    ? AppColors.primary
                    : AppColors.textMuted.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isSubActive ? AppColors.primary : AppColors.textMuted,
                  fontWeight: isSubActive ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height:
          110, // <--- UBAH NILAI INI (Ganti ke 100, 110, atau 120 sesuai selera)
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: AppColors.textMuted.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Judul Dashboard
          Text(
            _activeMenu.toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          // Bagian Profil (Nama & Avatar)
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.userData['name'] ?? 'USER',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    widget.userData['class'] ??
                        widget.userData['title'] ??
                        'CLASS INFO',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.textMuted,
                child: Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_activeMenu == 'Dashboard') {
      return DashboardScreen(userData: widget.userData);
    }
    if (_activeMenu == 'Akademik') {
      if (_activeSubMenu == 'E-Book') {
        return AkademikEBook(onSearch: (val) {}, userData: widget.userData);
      }
      if (_activeSubMenu == 'E-Learning') {
        return AkademikELearning(
          onMateriTap: (title) {
            setState(() {
              _activeSubMenu = 'Materi:$title';
            });
          },
          userData: widget.userData,
        );
      }
      if (_activeSubMenu == 'Rancangan Pembelajaran') {
        return const AkademikRancanganScreen();
      }
      if (_activeSubMenu.startsWith('Materi:')) {
        return AkademikMateriDetail(
          title: _activeSubMenu.replaceFirst('Materi:', ''),
          onBack: () => setState(() => _activeSubMenu = 'E-Learning'),
        );
      }
    }
    if (_activeMenu == 'Media') {
      if (_activeSubMenu == 'Kamus') {
        return const MediaKamus();
      }
      if (_activeSubMenu == 'Karya Siswa') {
        return MediaKaryaSiswa(
          onSearch: (val) {},
          onKaryaTap: (karya) {
            setState(() {
              _selectedKarya = karya;
              _activeSubMenu = 'DetailKarya:${karya['title']}';
            });
          },
        );
      }
      if (_activeSubMenu == 'Video Pembelajaran') {
        return MediaVideoPembelajaran(onSearch: (val) {});
      }
      if (_activeSubMenu.startsWith('DetailKarya:') && _selectedKarya != null) {
        return MediaKaryaSiswaDetail(
          karya: _selectedKarya!,
          onBack: () => setState(() => _activeSubMenu = 'Karya Siswa'),
        );
      }
    }
    if (_activeMenu == 'Administrasi') {
      if (_activeSubMenu == 'E-Raport') {
        return const AdministrasiERaport();
      }
      if (_activeSubMenu == 'Manajemen Data') {
        return const AdministrasiManajemenData();
      }
    }
    if (_activeMenu == 'Akun') {
      if (_activeSubMenu == 'Karya Siswa Saya') {
        return AkunKaryaSiswa(
          onBack: () => setState(() => _activeSubMenu = ''),
          onKaryaTap: (karya) {
            setState(() {
              _selectedKarya = karya;
              _activeSubMenu = 'DetailKaryaSaya:${karya['title']}';
            });
          },
        );
      }
      if (_activeSubMenu.startsWith('DetailKaryaSaya:') &&
          _selectedKarya != null) {
        return MediaKaryaSiswaDetail(
          karya: _selectedKarya!,
          onBack: () => setState(() => _activeSubMenu = 'Karya Siswa Saya'),
        );
      }
      if (_activeSubMenu == 'Ubah Password') {
        return AkunUbahPassword(
          onBack: () => setState(() => _activeSubMenu = ''),
          onConfirmSuccess: () {
            setState(() => _activeSubMenu = '');
            _showGlobalSuccessPopup('Password berhasil diperbarui.');
          },
        );
      }
      return AkunMainScreen(
        userData: widget.userData,
        onKaryaSiswaTap: () =>
            setState(() => _activeSubMenu = 'Karya Siswa Saya'),
        onPasswordTap: () => setState(() => _activeSubMenu = 'Ubah Password'),
      );
    }
    if (_activeMenu == 'Super Admin') {
      if (_activeSubMenu == 'Manajemen User') {
        return _SuperAdminUserManagement(userData: widget.userData);
      }
      if (_activeSubMenu == 'Konfigurasi Sistem') {
        return _SuperAdminConfig(userData: widget.userData);
      }
    }
    return Center(
      child: Text(
        'Halaman $_activeMenu $_activeSubMenu Belum Tersedia',
        style: GoogleFonts.poppins(),
      ),
    );
  }

  Widget _buildLogoutSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Divider(),
          TextButton.icon(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            ),
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: Text(
              'Keluar',
              style: GoogleFonts.poppins(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'PT. Gamma Persada Group © 2026',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SuperAdminUserManagement extends StatelessWidget {
  final Map<String, dynamic> userData;
  const _SuperAdminUserManagement({required this.userData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Manajemen User',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar User',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                _buildUserRow(
                  'Fathia Suhailah',
                  'fathia@smartbee.com',
                  'siswa',
                ),
                _buildUserRow('Dr. Andi Wijaya', 'guru@smartbee.com', 'guru'),
                _buildUserRow(
                  'Super Admin',
                  'admin@smartbee.com',
                  'super_admin',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow(String name, String email, String role) {
    Color roleColor = role == 'super_admin'
        ? AppColors.roleSuperAdmin
        : (role == 'guru' ? AppColors.roleGuru : AppColors.roleSiswa);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: roleColor.withOpacity(0.2),
            child: Icon(Icons.person, color: roleColor),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                Text(
                  email,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: roleColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              role.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: roleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.info),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.error),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _SuperAdminConfig extends StatelessWidget {
  final Map<String, dynamic> userData;
  const _SuperAdminConfig({required this.userData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Konfigurasi Sistem',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D1B10),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildConfigItem('Nama Aplikasi', 'SmartBee'),
                _buildConfigItem('Versi', '1.0.0'),
                _buildConfigItem('Mode Maintenance', 'Nonaktif'),
                _buildConfigItem('Max Upload Size', '10MB'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEBE9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          Text(value, style: GoogleFonts.poppins(color: Colors.grey[600])),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
