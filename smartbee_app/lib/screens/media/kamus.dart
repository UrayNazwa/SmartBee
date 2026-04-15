import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class MediaKamus extends StatefulWidget {
  const MediaKamus({super.key});

  @override
  State<MediaKamus> createState() => _MediaKamusState();
}

class _MediaKamusState extends State<MediaKamus> {
  int _currentPage = 0; // 0: Selection, 1: ENG, 2: KSA, 3: Detail Soal
  bool isIndoToEng = true;
  bool isIndoToKsa = true;
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _inputKsaController = TextEditingController();
  String _translatedText = "";
  String _translatedKsaText = "";
  String _currentTopic = "";

  // Penentuan gaya border global (Hitam opacity 0.4)
  final Border _globalBorder = Border.all(
    color: AppColors.textPrimary.withOpacity(0.4),
    width: 2,
  );

  final List<String> _topics = [
    "Perkenalan Diri",
    "Percakapan Singkat",
    "Pertanyaan Ilahi",
    "Manusia Makhluk Paling Sempurna",
    "Pekerjaan Rumah",
    "Berpergian",
    "Kehidupan yang Bermakna",
    "Kehidupan yang Bahagia",
  ];

  final Map<String, List<Map<String, String>>> _perkenalanDiriData = {
    "Perkenalan Diri": [
      {"indo": "Halo, selamat pagi", "arab": "مرحباً، صباح الخير"},
      {"indo": "Halo, selamat pagi juga", "arab": "مرحباً، صباح الخير أيضاً"},
      {
        "indo": "Perkenalkan nama saya Fathia",
        "arab": "دعوني أقدم نفسي، اسمي فتحية.",
      },
      {
        "indo": "Halo Fathia, nama saya Nabil Usman",
        "arab": "مرحباً فتحية، اسمي نبيل عثمان",
      },
      {
        "indo": "Perkenalkan nama saya Fathia",
        "arab": "دعوني أقدم نفسي، اسمi فتحية.",
      },
      {
        "indo": "Halo Fathia, nama saya Nabil Usman",
        "arab": "مرحباً فتحية، اسمي نبيل عثمان",
      },
      {
        "indo": "Halo Fathia, nama saya Nabil Usman",
        "arab": "مرحباً فتحية، اسمي نبيل عثمان",
      },
    ],
  };

  final Map<String, List<Map<String, String>>> dictionaryData = {
    'A': [
      {'word': 'Apple', 'meaning': 'Apel'},
      {'word': 'Always', 'meaning': 'Selalu'},
      {'word': 'Air', 'meaning': 'Udara'},
    ],
    'B': [
      {'word': 'Book', 'meaning': 'Buku'},
      {'word': 'Believe', 'meaning': 'Percaya'},
      {'word': 'Blue', 'meaning': 'Biru'},
    ],
    'C': [
      {'word': 'Cat', 'meaning': 'Kucing'},
      {'word': 'Cold', 'meaning': 'Dingin'},
      {'word': 'Change', 'meaning': 'Ubah'},
    ],
    'D': [
      {'word': 'Dream', 'meaning': 'Mimpi'},
      {'word': 'Door', 'meaning': 'Pintu'},
    ],
    'E': [
      {'word': 'Eat', 'meaning': 'Makan'},
      {'word': 'Earth', 'meaning': 'Bumi'},
    ],
    'F': [
      {'word': 'Fire', 'meaning': 'Api'},
      {'word': 'Friend', 'meaning': 'Teman'},
    ],
    'G': [
      {'word': 'Game', 'meaning': 'Permainan'},
      {'word': 'Great', 'meaning': 'Hebat'},
    ],
    'H': [
      {'word': 'Help', 'meaning': 'Bantuan'},
      {'word': 'Home', 'meaning': 'Rumah'},
    ],
    'I': [
      {'word': 'Ice', 'meaning': 'Es'},
      {'word': 'Island', 'meaning': 'Pulau'},
    ],
    'J': [
      {'word': 'Job', 'meaning': 'Pekerjaan'},
      {'word': 'Joy', 'meaning': 'Kegembiraan'},
    ],
    'K': [
      {'word': 'King', 'meaning': 'Raja'},
      {'word': 'Key', 'meaning': 'Kunci'},
    ],
    'L': [
      {'word': 'Love', 'meaning': 'Cinta'},
      {'word': 'Light', 'meaning': 'Lampu'},
    ],
    'M': [
      {'word': 'Moon', 'meaning': 'Bulan'},
      {'word': 'Mountain', 'meaning': 'Gunung'},
    ],
    'N': [
      {'word': 'Night', 'meaning': 'Malam'},
      {'word': 'Nature', 'meaning': 'Alam'},
    ],
    'O': [
      {'word': 'Ocean', 'meaning': 'Samudra'},
      {'word': 'Open', 'meaning': 'Buka'},
    ],
    'P': [
      {'word': 'Paper', 'meaning': 'Kertas'},
      {'word': 'People', 'meaning': 'Orang'},
    ],
    'Q': [
      {'word': 'Queen', 'meaning': 'Ratu'},
      {'word': 'Quick', 'meaning': 'Cepat'},
    ],
    'R': [
      {'word': 'Rain', 'meaning': 'Hujan'},
      {'word': 'Road', 'meaning': 'Jalan'},
    ],
    'S': [
      {'word': 'Sun', 'meaning': 'Matahari'},
      {'word': 'School', 'meaning': 'Sekolah'},
    ],
    'T': [
      {'word': 'Time', 'meaning': 'Waktu'},
      {'word': 'Tree', 'meaning': 'Pohon'},
    ],
    'U': [
      {'word': 'Under', 'meaning': 'Di bawah'},
      {'word': 'Use', 'meaning': 'Gunakan'},
    ],
    'V': [
      {'word': 'Voice', 'meaning': 'Suara'},
      {'word': 'Village', 'meaning': 'Desa'},
    ],
    'W': [
      {'word': 'Water', 'meaning': 'Air'},
      {'word': 'World', 'meaning': 'Dunia'},
    ],
    'X': [
      {'word': 'X-Ray', 'meaning': 'Sinar-X'},
    ],
    'Y': [
      {'word': 'Yellow', 'meaning': 'Kuning'},
      {'word': 'Young', 'meaning': 'Muda'},
    ],
    'Z': [
      {'word': 'Zoo', 'meaning': 'Kebun Binatang'},
      {'word': 'Zero', 'meaning': 'Nol'},
    ],
  };

  void _handleTranslate(String text) {
    setState(() {
      if (text.isEmpty) {
        _translatedText = "";
        return;
      }
      Map<String, String> words = {
        "kamu siapa": "Who are you?",
        "halo": "Hello",
        "selamat pagi": "Good morning",
        "apa kabar": "How are you?",
        "saya budi": "I am Budi",
      };
      String input = text.toLowerCase().trim();
      if (isIndoToEng) {
        _translatedText = words[input] ?? "Not found in local database.";
      } else {
        String? foundKey;
        words.forEach((key, value) {
          if (value.toLowerCase().contains(input)) foundKey = key;
        });
        _translatedText = foundKey ?? "Terjemahan tidak ditemukan.";
      }
    });
  }

  void _handleTranslateKsa(String text) {
    setState(() {
      if (text.isEmpty) {
        _translatedKsaText = "";
        return;
      }
      Map<String, String> words = {
        "halo": "مرحباً",
        "selamat pagi": "صبah الخير",
        "apa kabar": "كيف حالك؟",
        "saya": "أنا",
      };
      String input = text.toLowerCase().trim();
      if (isIndoToKsa) {
        _translatedKsaText =
            words[input] ?? "Kata tidak ditemukan di database.";
      } else {
        String? foundKey;
        words.forEach((key, value) {
          if (value.contains(input)) foundKey = key;
        });
        _translatedKsaText = foundKey ?? "Terjemahan tidak ditemukan.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: _currentPage == 0
                  ? _buildSelectionMenu()
                  : _currentPage == 1
                  ? _buildTranslatePage()
                  : _currentPage == 2
                  ? _buildTranslatePageKSA()
                  : _buildDetailSoalPage(),
            ),
          ),
          if (_currentPage == 1 || _currentPage == 2)
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                border: Border(
                  left: BorderSide(
                    color: AppColors.textPrimary.withOpacity(0.4),
                    width: 2,
                  ),
                ),
              ),
              child: ListView.builder(
                itemCount: 26,
                itemBuilder: (context, index) {
                  String char = String.fromCharCode(65 + index);
                  return InkWell(
                    onTap: () => _showAbjadDialog(char),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 15,
                      ),
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: _globalBorder,
                      ),
                      child: Center(
                        child: Text(
                          char,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSelectionMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kamus',
          style: GoogleFonts.poppins(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLanguageCard(
              title: "IND - ENG",
              imagePath: "assets/images/bindo-eng.png",
              onTap: () => setState(() => _currentPage = 1),
              isLocked: false,
            ),
            const SizedBox(width: 40),
            _buildLanguageCard(
              title: "IND - KSA",
              imagePath: "assets/images/bindo-ksa.png",
              onTap: () => setState(() => _currentPage = 2),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLanguageCard({
    required String title,
    required String imagePath,
    required VoidCallback onTap,
    bool isLocked = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 350,
        height: 450,
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(25),
          border: _globalBorder,
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  border: Border.all(
                    color: AppColors.textPrimary.withOpacity(0.2),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.surfaceLight,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: AppColors.textMuted.withOpacity(0.5),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "File tidak terbaca:\n$imagePath",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.textMuted,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      if (isLocked)
                        Container(
                          color: AppColors.textPrimary.withOpacity(0.45),
                          child: const Center(
                            child: Icon(
                              Icons.lock,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFlagCircle(title.split(' - ')[0]),
                const Icon(Icons.swap_horiz, size: 30),
                _buildFlagCircle(title.split(' - ')[1]),
              ],
            ),
            const SizedBox(height: 20),
            // Updated container for labels "IND - ENG" and "IND - KSA"
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              decoration: BoxDecoration(
                // PERUBAHAN DISINI: Warna diubah dari putih menjadi krem (AppColors.background)
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: _globalBorder,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlagCircle(String code) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.background,
        shape: BoxShape.circle,
        border: _globalBorder,
      ),
      child: Center(
        child: Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTranslatePage() {
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
              'Kamus ENG',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Row(
            children: [
              _buildTranslateBox(
                isIndoToEng ? 'Indonesia' : 'Inggris',
                _inputController,
                true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  onTap: () => setState(() {
                    isIndoToEng = !isIndoToEng;
                    _inputController.clear();
                    _translatedText = "";
                  }),
                  child: const Icon(Icons.swap_horiz, size: 45),
                ),
              ),
              _buildTranslateBox(
                isIndoToEng ? 'Inggris' : 'Indonesia',
                null,
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTranslateBox(
    String title,
    TextEditingController? controller,
    bool isInput,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.borderLight,
          borderRadius: BorderRadius.circular(20),
          border: _globalBorder,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.textPrimary.withOpacity(0.1),
                  ),
                ),
                child: isInput
                    ? TextField(
                        controller: controller,
                        onChanged: _handleTranslate,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Ketik di sini...",
                        ),
                      )
                    : SingleChildScrollView(
                        child: Text(
                          _translatedText.isEmpty
                              ? "Hasil Translate"
                              : _translatedText,
                          style: TextStyle(
                            color: _translatedText.isEmpty
                                ? AppColors.textPrimary.withOpacity(0.45)
                                : AppColors.textPrimary,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTranslatePageKSA() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() => _currentPage = 0),
                  icon: const Icon(Icons.arrow_back_ios, size: 28),
                ),
                Text(
                  'Kamus KSA',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () => _showContohSoalDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.borderLight,
                side: BorderSide(
                  color: AppColors.textPrimary.withOpacity(0.4),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              child: const Text(
                'Contoh Soal',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildKsaLabel(isIndoToKsa ? 'Indonesia' : 'Arab'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () => setState(() {
                        isIndoToKsa = !isIndoToKsa;
                        _inputKsaController.clear();
                        _translatedKsaText = "";
                      }),
                      child: const Icon(Icons.swap_horiz, size: 45),
                    ),
                  ),
                  _buildKsaLabel(isIndoToKsa ? 'Arab' : 'Indonesia'),
                ],
              ),
              const SizedBox(height: 30),
              _buildTranslateBoxKSA(
                'Masukkan Teks di sini!',
                _inputKsaController,
                true,
              ),
              const SizedBox(height: 20),
              _buildTranslateBoxKSA('Hasil Terjemahan', null, false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKsaLabel(String text) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(10),
        border: _globalBorder,
      ),
      child: Center(
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTranslateBoxKSA(
    String hint,
    TextEditingController? controller,
    bool isInput,
  ) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.borderLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.4),
          width: 3,
        ),
      ),
      child: isInput
          ? TextField(
              controller: controller,
              onChanged: _handleTranslateKsa,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
            )
          : SingleChildScrollView(
              child: Text(
                _translatedKsaText.isEmpty ? hint : _translatedKsaText,
                style: TextStyle(
                  color: _translatedKsaText.isEmpty
                      ? AppColors.textPrimary.withOpacity(0.45)
                      : AppColors.textPrimary,
                  fontSize: 18,
                ),
              ),
            ),
    );
  }

  void _showContohSoalDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.textPrimary.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  Text(
                    'CONTOH SOAL',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _topics.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (_topics[index] == "Perkenalan Diri") {
                          setState(() {
                            _currentTopic = _topics[index];
                            _currentPage = 3;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          _topics[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSoalPage() {
    final data = _perkenalanDiriData[_currentTopic] ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => setState(() => _currentPage = 2),
              icon: const Icon(Icons.arrow_back_ios, size: 28),
            ),
            Expanded(
              child: Center(
                child: Text(
                  _currentTopic,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
        const SizedBox(height: 30),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: _globalBorder,
            ),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          data[index]['indo']!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Text(
                          data[index]['arab']!,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 20,
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
        ),
      ],
    );
  }

  void _showAbjadDialog(String letter) {
    final listKata = dictionaryData[letter] ?? [];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.textPrimary.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ABJAD: $letter',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 350),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: listKata.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "${listKata[index]['word']} - ${listKata[index]['meaning']}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.edit, size: 18, color: AppColors.info),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.delete,
                          size: 18,
                          color: AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
