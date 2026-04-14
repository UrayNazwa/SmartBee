import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              color: const Color(0xFFF5F1EB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF718664),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1D9CD),
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
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildLogoutSection(),
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
              ? const Color(0xFF81602D).withOpacity(0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isActive ? Colors.white : Colors.black,
            size: 24,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: isActive ? Colors.white : Colors.black,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              fontSize: 16,
            ),
          ),
          trailing: hasSubmenu
              ? Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: isActive ? Colors.white : Colors.black,
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
          color: isSubActive ? const Color(0xFFEFEBE9) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: isSubActive ? const Color(0xFF81602D) : Colors.grey[400],
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isSubActive
                      ? const Color(0xFF81602D)
                      : Colors.grey[600],
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
          bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
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
              color: const Color(0xFF1A1A1A),
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
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF9E9E9E),
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
            icon: const Icon(Icons.logout, color: Colors.red),
            label: Text(
              'Keluar',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'PT. Gamma Persada Group © 2026',
            style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
