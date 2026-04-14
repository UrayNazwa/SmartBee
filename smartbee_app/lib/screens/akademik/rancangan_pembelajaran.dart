import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AkademikRancanganScreen extends StatefulWidget {
  const AkademikRancanganScreen({super.key});

  @override
  State<AkademikRancanganScreen> createState() =>
      _AkademikRancanganScreenState();
}

class _AkademikRancanganScreenState extends State<AkademikRancanganScreen> {
  String _activePeriod = 'Mingguan';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE1D9CD),
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
                      'Rancangan Pembelajaran',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2D1B10),
                      ),
                    ),
                    Text(
                      'Jenjang SMA',
                      style: GoogleFonts.poppins(color: Colors.black54),
                    ),
                  ],
                ),
                _buildPeriodToggle(),
              ],
            ),
            const SizedBox(height: 25),
            _buildHeroBanner(),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color.fromARGB(127, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromARGB(76, 0, 0, 0),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.menu_book),
                      const SizedBox(width: 15),
                      Text(
                        _activePeriod == 'Mingguan'
                            ? 'Jadwal Target Minggu Ini'
                            : 'Jadwal Target Bulan Ini',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  if (_activePeriod == 'Mingguan') ...[
                    _buildJadwalDay('Senin - 5 April 2026', [
                      {
                        'subject': 'MATEMATIKA',
                        'topic': 'Turunan Fungsi',
                        'done': true,
                      },
                      {
                        'subject': 'BAHASA INDONESIA',
                        'topic': 'Teks Editorial',
                        'done': true,
                      },
                      {
                        'subject': 'BAHASA INGGRIS',
                        'topic': 'Captions',
                        'done': true,
                      },
                    ]),
                    const SizedBox(height: 20),
                    _buildJadwalDay('Selasa - 6 April 2026', [
                      {
                        'subject': 'FISIKA',
                        'topic': 'Termodinamika',
                        'done': false,
                      },
                      {
                        'subject': 'KIMIA',
                        'topic': 'Laju Reaksi',
                        'done': false,
                      },
                    ]),
                  ] else ...[
                    _buildMonthlySchedule(),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildCatatanGuru(),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlySchedule() {
    return Column(
      children: [
        _buildJadwalDay('Minggu 1 - Fokus: Dasar & Teori', [
          {'subject': 'MATEMATIKA', 'topic': 'Limit Fungsi', 'done': false},
          {'subject': 'FISIKA', 'topic': 'Termodinamika', 'done': false},
          {'subject': 'KIMIA', 'topic': 'Laju Reaksi', 'done': false},
        ]),
        const SizedBox(height: 20),
        _buildJadwalDay('Minggu 2 - Fokus: Analisis & Praktek', [
          {'subject': 'BIOLOGI', 'topic': 'Genetika', 'done': false},
          {'subject': 'B. INDONESIA', 'topic': 'Teks Editorial', 'done': false},
          {'subject': 'B. INGGRIS', 'topic': 'Narrative Text', 'done': false},
        ]),
        const SizedBox(height: 20),
        _buildJadwalDay('Minggu 3 - Fokus: Pendalaman Materi', [
          {'subject': 'EKONOMI', 'topic': 'Akuntansi Dasar', 'done': false},
          {'subject': 'SOSIOLOGI', 'topic': 'Perubahan Sosial', 'done': false},
          {'subject': 'GEOGRAFI', 'topic': 'Mitigasi Bencana', 'done': false},
        ]),
        const SizedBox(height: 20),
        _buildJadwalDay('Minggu 4 - Fokus: Evaluasi & Review', [
          {'subject': 'EVALUASI', 'topic': 'Try Out Mandiri', 'done': false},
          {
            'subject': 'REVIEW',
            'topic': 'Review Materi Bab 1-4',
            'done': false,
          },
          {
            'subject': 'TANYA JAWAB',
            'topic': 'Sesi Tanya Jawab Guru',
            'done': false,
          },
        ]),
      ],
    );
  }

  Widget _buildPeriodToggle() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => setState(() => _activePeriod = 'Mingguan'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: _activePeriod == 'Mingguan'
                    ? const Color.fromARGB(204, 129, 96, 45)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Mingguan',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: _activePeriod == 'Mingguan'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _activePeriod = 'Bulanan'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: _activePeriod == 'Bulanan'
                    ? const Color.fromARGB(204, 129, 96, 45)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Bulanan',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: _activePeriod == 'Bulanan'
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(102, 0, 0, 0), width: 1),
      ),
      child: Row(
        children: [
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
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromARGB(25, 0, 0, 0),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt, size: 16),
                      const SizedBox(width: 5),
                      Text(
                        'KURIKULUM SMA TERBARU',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Kuasai Materi Terstruktur',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2D1B10),
                  ),
                ),
                Text(
                  'Pengalaman belajar khusus untuk jenjang SMA.',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.rocket_launch, size: 100, color: Colors.grey[300]),
        ],
      ),
    );
  }

  Widget _buildJadwalDay(String day, List<Map<String, dynamic>> items) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.brown[300],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.brown, width: 1),
              ),
            ),
            Container(width: 2, height: 100, color: Colors.grey[300]),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: items.map((item) {
                  return Container(
                    width: 200,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: item['done']
                          ? const Color(0xFF718664)
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: item['done']
                            ? const Color.fromARGB(127, 113, 134, 100)
                            : const Color.fromARGB(13, 0, 0, 0),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['subject'],
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: item['done']
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            if (item['done'])
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 14,
                              ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['topic'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: item['done']
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCatatanGuru() {
    final List<Map<String, String>> catatan = [
      {
        'pesan': '"Perdalam materi terakhir sebelum ujian besok!"',
        'nama': 'Ibu Siti',
        'waktu': 'Kemarin',
      },
      {
        'pesan': '"Video penjelasan tambahan sudah tersedia."',
        'nama': 'Pak Bambang',
        'waktu': 'Tadi',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color.fromARGB(127, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color.fromARGB(76, 0, 0, 0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.priority_high, size: 20),
              ),
              const SizedBox(width: 15),
              Text(
                'Catatan Guru',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(children: catatan.map((c) => _buildCatatanCard(c)).toList()),
        ],
      ),
    );
  }

  Widget _buildCatatanCard(Map<String, String> data) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(204, 188, 168, 142),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['pesan']!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(127, 255, 255, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['nama']!,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    data['waktu']!,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.black54,
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
}
