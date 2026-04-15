import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class AkunUbahPassword extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onConfirmSuccess;

  const AkunUbahPassword({
    super.key,
    required this.onBack,
    required this.onConfirmSuccess,
  });

  @override
  State<AkunUbahPassword> createState() => _AkunUbahPasswordState();
}

class _AkunUbahPasswordState extends State<AkunUbahPassword> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  final FocusNode _oldPasswordFocus = FocusNode();
  final FocusNode _newPasswordFocus = FocusNode();
  final FocusNode _confirmNewPasswordFocus = FocusNode();

  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _oldPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _confirmNewPasswordFocus.dispose();
    super.dispose();
  }

  bool _validatePasswords() {
    setState(() {
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmNewPasswordError = null;
    });

    if (_oldPasswordController.text.isEmpty) {
      setState(() {
        _oldPasswordError = 'Password lama tidak boleh kosong';
      });
      return false;
    }

    if (_newPasswordController.text.isEmpty) {
      setState(() {
        _newPasswordError = 'Password baru tidak boleh kosong';
      });
      return false;
    }

    if (_newPasswordController.text.length < 6) {
      setState(() {
        _newPasswordError = 'Password baru minimal 6 karakter';
      });
      return false;
    }

    if (_confirmNewPasswordController.text.isEmpty) {
      setState(() {
        _confirmNewPasswordError =
            'Konfirmasi password baru tidak boleh kosong';
      });
      return false;
    }

    if (_newPasswordController.text != _confirmNewPasswordController.text) {
      setState(() {
        _confirmNewPasswordError =
            'Password baru dan konfirmasi password tidak cocok';
      });
      return false;
    }

    return true;
  }

  void _showConfirmPopup() {
    if (!_validatePasswords()) {
      return;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 450,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(25),
            // Border pada popup agar konsisten
            border: Border.all(
              color: AppColors.textPrimary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Apakah anda yakin untuk mengubah password ini?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close confirm
                        widget.onConfirmSuccess();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'YA',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'TIDAK',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 30),
                onPressed: widget.onBack,
              ),
              Expanded(
                child: Text(
                  'Password',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                  // PERBAIKAN: Border hitam disamakan dengan frame lainnya
                  border: Border.all(
                    color: AppColors.textPrimary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(
                      'Password Lama',
                      'Masukkan Password Lama',
                      _oldPasswordController,
                      _oldPasswordFocus,
                      _oldPasswordError,
                    ),
                    const SizedBox(height: 25),
                    _buildField(
                      'Password Baru',
                      'Masukkan Password Baru',
                      _newPasswordController,
                      _newPasswordFocus,
                      _newPasswordError,
                    ),
                    const SizedBox(height: 25),
                    _buildField(
                      'Ketik Ulang Password Baru',
                      'Ketik Ulang Password Baru',
                      _confirmNewPasswordController,
                      _confirmNewPasswordFocus,
                      _confirmNewPasswordError,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _showConfirmPopup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary.withOpacity(0.8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'UBAH',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller,
    FocusNode focusNode,
    String? errorText,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: AppColors.textMuted),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textPrimary.withOpacity(0.38),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textPrimary.withOpacity(0.4),
              ),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
