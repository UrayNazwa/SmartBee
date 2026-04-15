import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class AkademikEBook extends StatefulWidget {
  final Function(String) onSearch;
  final Map<String, dynamic> userData;

  const AkademikEBook({
    super.key,
    required this.onSearch,
    required this.userData,
  });

  @override
  State<AkademikEBook> createState() => _AkademikEBookState();
}

class _AkademikEBookState extends State<AkademikEBook> {
  bool isEditMode = false;
  // Daftar semua buku (Master Data)
  final List<Map<String, String>> allEbooks = [
    {
      'title': 'BAHASA INDONESIA KELAS 12',
      'size': '12.4 MB',
      'image': 'assets/images/bahasa-indonesia.png',
    },
    {
      'title': 'SOSIOLOGI KELAS 12',
      'size': '12.4 MB',
      'image': 'assets/images/sosiologi.png',
    },
    {
      'title': 'BIOLOGI KELAS 12',
      'size': '12.4 MB',
      'image': 'assets/images/biologi.png',
    },
    {
      'title': 'MATEMATIKA KELAS 12',
      'size': '12.4 MB',
      'image': 'assets/images/math.png',
    },
    {
      'title': 'EKONOMI KELAS 12',
      'size': '12.4 MB',
      'image': 'assets/images/ekonomi.png',
    },
    {
      'title': 'KIMIA KELAS 12',
      'size': '12.4 MB',
      'image': 'assets/images/kimia.png',
    },
  ];

  // Daftar buku yang akan ditampilkan (Hasil Filter)
  List<Map<String, String>> displayedEbooks = [];

  @override
  void initState() {
    super.initState();
    // Saat pertama kali dibuka, tampilkan semua buku
    displayedEbooks = allEbooks;
  }

  // Fungsi untuk menyaring buku berdasarkan input user
  void _filterBooks(String query) {
    setState(() {
      displayedEbooks = allEbooks
          .where(
            (ebook) =>
                ebook['title']!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(25),
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
                    'E-Book',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Koleksi e-book jenjang SMA.',
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  if (widget.userData['role'] == 'guru') ...[
                    _buildTeacherButton(
                      'Upload Buku',
                      Icons.upload_file_rounded,
                      _showUploadDialog,
                    ),
                    const SizedBox(width: 15),
                  ],
                  _buildSearchBar('Cari Judul Buku'),
                  if (widget.userData['role'] == 'guru') ...[
                    const SizedBox(width: 15),
                    _buildTeacherButton(
                      'Edit Buku',
                      Icons.edit_note_rounded,
                      () => setState(() => isEditMode = !isEditMode),
                      isActive: isEditMode,
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: displayedEbooks.isEmpty
                ? _buildEmptyState() // Tampilan jika buku tidak ditemukan
                : GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: displayedEbooks.length,
                    itemBuilder: (context, index) {
                      final ebook = displayedEbooks[index];
                      return _buildEbookCard(ebook);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEbookCard(Map<String, String> ebook) {
    return Container(
      decoration: BoxDecoration(
        color: isEditMode
            ? AppColors.borderLight.withOpacity(
                0.8,
              ) // Warna lebih gelap saat edit
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.3), width: 1),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: AppColors.textPrimary.withOpacity(0.05),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: ebook['image'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              ebook['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.menu_book_rounded,
                                  size: 70,
                                  color: AppColors.surfaceDark.withOpacity(0.3),
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.menu_book_rounded,
                            size: 70,
                            color: AppColors.surfaceDark.withOpacity(0.3),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  children: [
                    Text(
                      ebook['title']!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionBadge('BACA SEKARANG'),
                        Text(
                          ebook['size']!,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isEditMode)
            Positioned.fill(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildEditIcon(
                      Icons.edit_square,
                      () => _showEditDialog(ebook),
                    ),
                    const SizedBox(width: 15),
                    _buildEditIcon(
                      Icons.delete_rounded,
                      () => _showDeleteDialog(ebook['title']!),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEditIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 28),
      ),
    );
  }

  Widget _buildTeacherButton(
    String label,
    IconData icon,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? AppColors.primary : Colors.white,
        foregroundColor: isActive ? Colors.white : AppColors.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
      ),
    );
  }

  void _showDeleteDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(25),
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 50,
              ),
              const SizedBox(height: 20),
              Text(
                'Yakin Ingin Menghapus $title?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Tidak'),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Ya'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => _buildFormDialog(
        'Upload Buku',
        'Upload PDF',
        'Upload Thumbnail',
        'Upload Buku',
        true,
      ),
    );
  }

  void _showEditDialog(Map<String, String> ebook) {
    showDialog(
      context: context,
      builder: (context) => _buildFormDialog(
        'Edit Buku',
        'Upload E-Book',
        'Upload Thumbnail',
        'Update Buku',
        false,
        initialTitle: ebook['title'],
      ),
    );
  }

  Widget _buildFormDialog(
    String title,
    String fileLabel,
    String thumbLabel,
    String btnLabel,
    bool isUpload, {
    String? initialTitle,
  }) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(25),
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Judul Buku',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(initialValue: initialTitle),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildFilePicker(thumbLabel, Icons.image)),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildFilePicker(fileLabel, Icons.picture_as_pdf),
                ),
              ],
            ),
            if (isUpload) ...[
              const SizedBox(height: 20),
              Text(
                'Jumlah Buku',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _buildTextField(hint: 'Masukkan jumlah buku'),
            ],
            const SizedBox(height: 35),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  btnLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({String? hint, String? initialValue}) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFilePicker(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[400], size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(String hint) {
    return Container(
      width: 240,
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.5),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: (value) => _filterBooks(value),
              style: GoogleFonts.poppins(fontSize: 13),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Buku tidak ditemukan',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
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
          color: AppColors.primary,
        ),
      ),
    );
  }
}
