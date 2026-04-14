import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AkademikELearning extends StatefulWidget {
  final Function(String) onMateriTap;
  final Map<String, dynamic> userData;

  const AkademikELearning({
    super.key,
    required this.onMateriTap,
    required this.userData,
  });

  @override
  State<AkademikELearning> createState() => _AkademikELearningState();
}

class _AkademikELearningState extends State<AkademikELearning> {
  bool _showAllTasks = false;
  int _currentPage = 0; // 0: Main E-Learning, 1: Materi Saya, 2: Materi Detail
  Map<String, String>? _selectedMateri;

  final List<Map<String, String>> _allTasks = [
    {
      'title': 'Quiz Trigonometri',
      'class': 'XII - A',
      'status': 'PERLU DINILAI',
      'progress': '28/36 Siswa',
    },
    {
      'title': 'Tugas Hukum Newton',
      'class': 'XI - B',
      'status': 'SELESAI',
      'progress': '28/30 Siswa',
    },
    {
      'title': 'Quiz Aljabar',
      'class': 'XII - A',
      'status': 'PERLU DINILAI',
      'progress': '28/36 Siswa',
    },
    {
      'title': 'Tugas Listrik Magnet',
      'class': 'XII - A',
      'status': 'PERLU DINILAI',
      'progress': '28/35 Siswa',
    },
    {
      'title': 'Quiz Sel Jaringan',
      'class': 'XII - A',
      'status': 'PERLU DINILAI',
      'progress': '28/36 Siswa',
    },
    {
      'title': 'Tugas Konflik Sosial',
      'class': 'XI - B',
      'status': 'SELESAI',
      'progress': '29/32 Siswa',
    },
    {
      'title': 'Tugas Struktur Atom',
      'class': 'XII - C',
      'status': 'PERLU DINILAI',
      'progress': '28/36 Siswa',
    },
    {
      'title': 'Quiz Biografi',
      'class': 'X - C',
      'status': 'SELESAI',
      'progress': '28/30 Siswa',
    },
    {
      'title': 'Tugas Sejarah Kemerdekaan',
      'class': 'X - A',
      'status': 'PERLU DINILAI',
      'progress': '25/30 Siswa',
    },
    {
      'title': 'Quiz Kimia Organik',
      'class': 'XI - A',
      'status': 'SELESAI',
      'progress': '27/31 Siswa',
    },
    {
      'title': 'Tugas Bahasa Inggris',
      'class': 'X - B',
      'status': 'PERLU DINILAI',
      'progress': '26/29 Siswa',
    },
    {
      'title': 'Quiz Fisika Kuantum',
      'class': 'XII - B',
      'status': 'SELESAI',
      'progress': '30/30 Siswa',
    },
    {
      'title': 'Tugas Geografi',
      'class': 'XI - C',
      'status': 'PERLU DINILAI',
      'progress': '24/28 Siswa',
    },
    {
      'title': 'Quiz Sastra Indonesia',
      'class': 'X - C',
      'status': 'SELESAI',
      'progress': '29/30 Siswa',
    },
    {
      'title': 'Tugas Seni Budaya',
      'class': 'XI - A',
      'status': 'PERLU DINILAI',
      'progress': '23/27 Siswa',
    },
  ];

  final List<Map<String, String>> _myMaterials = [
    {
      'title': 'Matematika: Peminatan',
      'class': 'Kelas 12 - A',
      'time': '4.8 Jam',
      'module': '10 Module',
      'image': 'assets/images/math.png',
    },
    {
      'title': 'Matematika: Peminatan',
      'class': 'Kelas 12 - B',
      'time': '4.8 Jam',
      'module': '10 Module',
      'image': 'assets/images/math.png',
    },
    {
      'title': 'Matematika: Lanjutan',
      'class': 'Kelas 12 - A',
      'time': '4.8 Jam',
      'module': '10 Module',
      'image': 'assets/images/math.png',
    },
    {
      'title': 'Matematika: Lanjutan',
      'class': 'Kelas 12 - B',
      'time': '4.8 Jam',
      'module': '10 Module',
      'image': 'assets/images/math.png',
    },
    {
      'title': 'Fisika Modern: Relativitas',
      'class': 'Kelas 11 - B',
      'time': '4.5 Jam',
      'module': '12 Module',
      'image': 'assets/images/fisika.png',
    },
    {
      'title': 'Fisika Modern: Kuantum',
      'class': 'Kelas 10 - C',
      'time': '4.5 Jam',
      'module': '12 Module',
      'image': 'assets/images/fisika.png',
    },
  ];

  final List<Map<String, String>> _studentMaterials = [
    {
      'title': 'Fisika Modern: Relativitas',
      'class': 'Kelas 12 - A',
      'time': '4.5 Jam',
      'module': '12 Module',
      'image': 'assets/images/fisika.png',
    },
    {
      'title': 'Matematika: Peminatan',
      'class': 'Kelas 12 - A',
      'time': '4.8 Jam',
      'module': '10 Module',
      'image': 'assets/images/math.png',
    },
    {
      'title': 'Biologi: Ekosistem',
      'class': 'Kelas 12 - A',
      'time': '4 Jam',
      'module': '12 Module',
      'image': 'assets/images/biologi.png',
    },
    {
      'title': 'Bahasa Inggris: Captions',
      'class': 'Kelas 12 - A',
      'time': '5 Jam',
      'module': '10 Module',
      'image': 'assets/images/bahasa-inggris.png',
    },
  ];

  final List<Map<String, dynamic>> _materiDetailData = [
    {
      'title': 'Matematika Lanjut',
      'teacher': 'Dr. Andi Wijaya',
      'class': '12 - A',
      'chapters': [
        {
          'title': 'BAB 1: TRIGONOMETRI',
          'modules': [
            {'type': 'Modul', 'content': ''},
            {'type': 'Tugas', 'content': ''},
            {'type': 'Quiz', 'content': ''},
          ],
        },
        {
          'title': 'BAB 2: ALJABAR',
          'modules': [
            {'type': 'Modul', 'content': ''},
            {'type': 'Tugas', 'content': ''},
            {'type': 'Quiz', 'content': ''},
          ],
        },
      ],
    },
    {
      'title': 'Matematika: Peminatan',
      'teacher': 'Dr. Andi Wijaya',
      'class': '12 - A',
      'chapters': [
        {
          'title': 'BAB 1: TRIGONOMETRI',
          'modules': [
            {'type': 'Modul', 'content': ''},
            {'type': 'Tugas', 'content': ''},
            {'type': 'Quiz', 'content': ''},
          ],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isTeacher = widget.userData['role'] == 'guru';

    return Container(
      color: const Color(0xFFE1D9CD),
      padding: const EdgeInsets.all(25),
      child: _currentPage == 0
          ? _buildMainELearning(isTeacher)
          : _currentPage == 1
          ? _buildMateriSayaPage()
          : _buildMateriDetailPage(),
    );
  }

  Widget _buildMainELearning(bool isTeacher) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-Learning',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D1B10),
            ),
          ),
          const SizedBox(height: 25),
          if (isTeacher) ...[
            _buildTeacherPortal(),
            const SizedBox(height: 30),
            _buildTasksSection(),
          ] else ...[
            _buildStudentGrid(),
          ],
        ],
      ),
    );
  }

  Widget _buildTeacherPortal() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flash_on, color: Color(0xFF81602D)),
              const SizedBox(width: 10),
              Text(
                'PORTAL MANAJEMEN GURU',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF81602D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Kelola Materi & Pembelajaran',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D1B10),
            ),
          ),
          Text(
            'Unggah materi baru, dan pantau proses beajar seluruh siswa anda.',
            style: GoogleFonts.poppins(color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _currentPage = 1),
              icon: const Icon(Icons.menu_book_rounded),
              label: Text(
                'MATERI SAYA',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF81602D),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoCard('MATERI SAYA', '12', Icons.menu_book),
              const SizedBox(width: 15),
              _buildInfoCard('TOTAL SISWA', '324', Icons.group),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTasksSection() {
    final List<Map<String, String>> displayedTasks = _showAllTasks
        ? _allTasks
        : _allTasks.take(6).toList();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tugas Menunggu Koreksi',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D1B10),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => _showAllTasks = !_showAllTasks),
              child: Text(
                _showAllTasks ? 'LIHAT SEDIKIT TUGAS' : 'LIHAT SEMUA TUGAS',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF81602D),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.5,
          ),
          itemCount: displayedTasks.length,
          itemBuilder: (context, index) {
            final task = displayedTasks[index];
            return _buildTaskCard(task);
          },
        ),
      ],
    );
  }

  Widget _buildStudentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        childAspectRatio: 1.0,
      ),
      itemCount: _studentMaterials.length,
      itemBuilder: (context, index) {
        final item = _studentMaterials[index];
        return _buildMateriCard(item, isStudent: true);
      },
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D1B10),
                      ),
                    ),
                  ],
                ),
                Icon(icon, color: const Color(0xFF81602D), size: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(Map<String, String> task) {
    Color statusColor = task['status'] == 'PERLU DINILAI'
        ? Colors.red.withOpacity(0.7)
        : Colors.green.withOpacity(0.7);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.assignment, color: Color(0xFF2D1B10)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  task['status']!,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            task['title']!,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D1B10),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            task['class']!,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.group, size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    task['progress']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'PERIKSA',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF81602D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMateriSayaPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => _currentPage = 0),
              icon: const Icon(Icons.arrow_back_ios, size: 28),
            ),
            Text(
              'Materi Saya',
              style: GoogleFonts.poppins(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D1B10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 1.0,
            ),
            itemCount: _myMaterials.length,
            itemBuilder: (context, index) {
              final materi = _myMaterials[index];
              return _buildMateriCard(materi);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMateriCard(
    Map<String, String> materi, {
    bool isStudent = false,
  }) {
    return InkWell(
      onTap: () {
        if (isStudent) {
          widget.onMateriTap(materi['title']!);
        } else {
          setState(() {
            _selectedMateri = materi;
            _currentPage = 2;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(127, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                ),
                child: Center(
                  child: materi['image'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            materi['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) => Icon(
                              Icons.menu_book_rounded,
                              size: 70,
                              color: Colors.grey[300],
                            ),
                          ),
                        )
                      : Icon(
                          Icons.menu_book_rounded,
                          size: 70,
                          color: Colors.grey[300],
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: Column(
                children: [
                  Text(
                    materi['title']!,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: const Color(0xFF2D1B10),
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionBadge(materi['class']!),
                      Text(
                        materi['time']!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMateriDetailPage() {
    if (_selectedMateri == null)
      return const Center(child: Text('Materi tidak ditemukan.'));

    final String selectedTitle = _selectedMateri!['title'] ?? '';
    final String selectedClass = _selectedMateri!['class'] ?? '';

    final materiData = _materiDetailData.firstWhere(
      (element) =>
          element['title'] == selectedTitle ||
          selectedTitle.contains(element['title'] ?? ''),
      orElse: () => {
        'title': selectedTitle,
        'teacher': 'Dr. Andi Wijaya',
        'class': selectedClass.replaceAll('Kelas ', ''),
        'chapters': [],
      },
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: BoxDecoration(
              color: const Color(0xFFBCA88E).withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => setState(() => _currentPage = 1),
                      icon: const Icon(Icons.arrow_back_ios, size: 28),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          materiData['title']!,
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2D1B10),
                          ),
                        ),
                        Text(
                          materiData['teacher']!,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    materiData['class']!,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2D1B10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: _showAddMateriDialog,
                icon: const Icon(Icons.add_circle_outline, size: 20),
                label: Text(
                  'TAMBAH MATERI',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF81602D),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              ElevatedButton.icon(
                onPressed: () =>
                    _showEditChapterDialog({'title': materiData['title']}),
                icon: const Icon(Icons.edit, size: 20),
                label: Text(
                  'EDIT',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBCA88E),
                  foregroundColor: const Color(0xFF2D1B10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ...materiData['chapters']
              .map<Widget>((chapter) => _buildChapterCard(chapter))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildChapterCard(Map<String, dynamic> chapter) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                chapter['title']!,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D1B10),
                ),
              ),
              TextButton.icon(
                onPressed: () => _showEditChapterDialog(chapter),
                icon: const Icon(Icons.edit_note, color: Colors.black87),
                label: Text(
                  'EDIT',
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF718664),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildChapterSubItem('Modul', Icons.menu_book_rounded),
                const SizedBox(height: 15),
                _buildChapterSubItem('Tugas', Icons.assignment_rounded),
                const SizedBox(height: 15),
                _buildChapterSubItem('Quiz', Icons.quiz_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterSubItem(String label, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF718664), size: 28),
          const SizedBox(width: 15),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D1B10),
            ),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildActionBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color.fromARGB(51, 158, 158, 158)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF81602D),
        ),
      ),
    );
  }

  void _showAddMateriDialog() => showDialog(
    context: context,
    builder: (context) => _buildAddEditChapterDialog('Tambah Materi', null),
  );
  void _showEditChapterDialog(Map<String, dynamic> chapter) => showDialog(
    context: context,
    builder: (context) => _buildAddEditChapterDialog('Edit Materi', chapter),
  );

  Widget _buildAddEditChapterDialog(
    String title,
    Map<String, dynamic>? chapter,
  ) {
    final TextEditingController titleController = TextEditingController(
      text: chapter?['title'] ?? '',
    );
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(30),
        width: 500,
        decoration: BoxDecoration(
          color: const Color(0xFFE1D9CD),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D1B10),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Color(0xFF2D1B10)),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildPopupField(
              'Judul Buku',
              titleController,
              'Contoh: MTK Peminatan',
            ),
            const SizedBox(height: 15),
            _buildPopupField(
              'Modul',
              TextEditingController(),
              'Link Modul atau Deskripsi',
            ),
            const SizedBox(height: 15),
            _buildPopupField(
              'Tugas',
              TextEditingController(),
              'Link Tugas atau Deskripsi',
            ),
            const SizedBox(height: 15),
            _buildPopupField(
              'Quiz',
              TextEditingController(),
              'Link Quiz atau Deskripsi',
            ),
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF718664),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  title.contains('Tambah') ? 'Tambah' : 'Update',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Row(
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFBCA88E),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2D1B10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
