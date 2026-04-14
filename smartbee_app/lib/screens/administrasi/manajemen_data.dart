import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdministrasiManajemenData extends StatefulWidget {
  const AdministrasiManajemenData({super.key});

  @override
  State<AdministrasiManajemenData> createState() =>
      _AdministrasiManajemenDataState();
}

class _AdministrasiManajemenDataState extends State<AdministrasiManajemenData> {
  String _currentTab = 'Peringkat Umum';
  String _selectedClass = 'X';
  bool _isClassDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xFFE1D9CD),
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 25),
              Expanded(
                child: _currentTab == 'Peringkat Umum'
                    ? SingleChildScrollView(child: _buildPeringkatUmum())
                    : _buildDaftarSiswa(),
              ),
            ],
          ),
        ),
        if (_isClassDropdownOpen && _currentTab == 'Daftar Lihat Siswa/i')
          Positioned(
            top: 75, // Posisi tepat di bawah navbar
            right: 25,
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E1D9),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: const Color.fromARGB(51, 0, 0, 0),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  'X',
                  'XI',
                  'XII',
                ].map((c) => _dropdownItem(c)).toList(),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Manajemen Data',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D1B10),
              ),
            ),
            Text(
              'Daftar rekan belajar di jenjang SMA.',
              style: GoogleFonts.poppins(color: Colors.black54),
            ),
          ],
        ),
        _buildNavbar(),
      ],
    );
  }

  Widget _buildNavbar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _navbarItem('Peringkat Umum'),
          _navbarItem('Daftar Lihat Siswa/i'),
        ],
      ),
    );
  }

  Widget _navbarItem(String title) {
    bool isActive = _currentTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentTab = title;
          if (title == 'Daftar Lihat Siswa/i') {
            _isClassDropdownOpen = !_isClassDropdownOpen;
          } else {
            _isClassDropdownOpen = false;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? const Color.fromARGB(204, 129, 96, 45)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _dropdownItem(String className) {
    bool isSelected = _selectedClass == className;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _selectedClass = className;
          _isClassDropdownOpen = false;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF81602D).withOpacity(0.1)
              : Colors.transparent,
          border: const Border(
            bottom: BorderSide(color: Colors.black12, width: 0.5),
          ),
        ),
        child: Text(
          className,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: isSelected ? const Color(0xFF81602D) : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildPeringkatUmum() {
    final List<Map<String, String>> topStudents = [
      {'rank': '1', 'name': 'Fathia Suhailah Triadi', 'score': '98.5'},
      {'rank': '2', 'name': 'Ghina Raudhotul Fashli', 'score': '97.2'},
      {'rank': '3', 'name': 'Uray Nazwa Shavira', 'score': '96.8'},
      {'rank': '4', 'name': 'Andovi Da Lopez', 'score': '95.0'},
      {'rank': '5', 'name': 'Jeon Jungkook', 'score': '94.5'},
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color.fromARGB(127, 255, 255, 255),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.emoji_events, color: Colors.amber),
                        const SizedBox(width: 10),
                        Text(
                          'Top 5 Siswa',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(204, 129, 96, 45),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Peringkat Umum',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ...topStudents.map((s) => _buildTopStudentItem(s)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 25),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color.fromARGB(204, 113, 134, 100),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.black),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(76, 255, 255, 255),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Siswa Terbaik',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Text(
                  'Fathia Suhailah\nTriadi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white30, thickness: 2),
                const SizedBox(height: 20),
                Text(
                  'Selamat kepada Fathia atas pencapaian luar biasa di semester ini!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopStudentItem(Map<String, String> student) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFFBCA88E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                student['rank']!,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              student['name']!,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            student['score']!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF81602D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaftarSiswa() {
    final Map<String, List<Map<String, String>>> studentData = {
      'X': [
        {'name': 'Andovi Da Lopez', 'gender': 'L', 'class': 'X - A'},
        {'name': 'Fathia Suhailah Triadi', 'gender': 'P', 'class': 'X - A'},
        {'name': 'Ghina Raudhotul Fashli', 'gender': 'P', 'class': 'X - A'},
        {'name': 'Jeon Jungkook', 'gender': 'L', 'class': 'X - A'},
        {'name': 'Keonho', 'gender': 'L', 'class': 'X - A'},
        {'name': 'Uray Nazwa Shavira', 'gender': 'P', 'class': 'X - A'},
        {'name': 'Abdul', 'gender': 'L', 'class': 'X - B'},
      ],
      'XI': [
        {'name': 'Rizky Febian', 'gender': 'L', 'class': 'XI - A'},
        {'name': 'Tiara Andini', 'gender': 'P', 'class': 'XI - A'},
        {'name': 'Lyodra Ginting', 'gender': 'P', 'class': 'XI - A'},
        {'name': 'Angga Yunanda', 'gender': 'L', 'class': 'XI - B'},
        {'name': 'Adhisty Zara', 'gender': 'P', 'class': 'XI - B'},
        {'name': 'Jefri Nichol', 'gender': 'L', 'class': 'XI - C'},
        {'name': 'Vanesha Prescilla', 'gender': 'P', 'class': 'XI - C'},
        {'name': 'Iqbaal Ramadhan', 'gender': 'L', 'class': 'XI - C'},
      ],
      'XII': [
        {'name': 'Tulus', 'gender': 'L', 'class': 'XII - A'},
        {'name': 'Raisa Andriana', 'gender': 'P', 'class': 'XII - A'},
        {'name': 'Isyana Sarasvati', 'gender': 'P', 'class': 'XII - A'},
        {'name': 'Afgan Syahreza', 'gender': 'L', 'class': 'XII - B'},
        {'name': 'Maudy Ayunda', 'gender': 'P', 'class': 'XII - B'},
        {'name': 'Ariel Noah', 'gender': 'L', 'class': 'XII - C'},
      ],
    };

    final students = studentData[_selectedClass] ?? [];

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daftar Siswa Kelas $_selectedClass',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D1B10),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF81602D).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Total: ${students.length} Siswa',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF81602D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _tableHeader('Nama Siswa/i', 2),
              _tableHeader('Jenis Kelamin', 1),
              _tableHeader('Kelas', 1),
            ],
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final s = students[index];
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          s['name']!,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          s['gender']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          s['class']!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _tableHeader(String title, int flex) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        textAlign: flex == 1 ? TextAlign.center : TextAlign.start,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
