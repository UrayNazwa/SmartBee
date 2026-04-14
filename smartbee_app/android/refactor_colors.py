import os

colors_file = '../lib/theme/app_colors.dart'
os.makedirs(os.path.dirname(colors_file), exist_ok=True)
with open(colors_file, 'w') as f:
    f.write('''import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFE1D9CD);
  static const Color textPrimary = Color(0xFF2D1B10);
  static const Color accentBrown = Color(0xFF81602D);
  static const Color accentLightBrown = Color(0xFFBCA88E);
  static const Color primaryGreen = Color(0xFF718664);
  static const Color glassWhite = Color.fromARGB(127, 255, 255, 255);
  static const Color badgeBorder = Color.fromARGB(51, 158, 158, 158);
}
''')

target_file = '../lib/screens/akademik/e_learning.dart'
with open(target_file, 'r') as f:
    content = f.read()

replacements = [
    ('const Color(0xFFE1D9CD)', 'AppColors.background'),
    ('Color(0xFFE1D9CD)', 'AppColors.background'),
    ('const Color(0xFF2D1B10)', 'AppColors.textPrimary'),
    ('Color(0xFF2D1B10)', 'AppColors.textPrimary'),
    ('const Color(0xFF81602D)', 'AppColors.accentBrown'),
    ('Color(0xFF81602D)', 'AppColors.accentBrown'),
    ('const Color(0xFFBCA88E)', 'AppColors.accentLightBrown'),
    ('Color(0xFFBCA88E)', 'AppColors.accentLightBrown'),
    ('const Color(0xFF718664)', 'AppColors.primaryGreen'),
    ('Color(0xFF718664)', 'AppColors.primaryGreen'),
    ('const Color.fromARGB(127, 255, 255, 255)', 'AppColors.glassWhite'),
    ('Color.fromARGB(127, 255, 255, 255)', 'AppColors.glassWhite'),
    ('const Color.fromARGB(51, 158, 158, 158)', 'AppColors.badgeBorder'),
    ('Color.fromARGB(51, 158, 158, 158)', 'AppColors.badgeBorder'),
]

for old, new in replacements:
    content = content.replace(old, new)

if "import '../../theme/app_colors.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport '../../theme/app_colors.dart';")

with open(target_file, 'w') as f:
    f.write(content)

print('Refactoring complete')
