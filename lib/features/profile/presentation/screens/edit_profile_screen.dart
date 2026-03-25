import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' show File;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_gradients.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../common/widgets/buttons/gradient_button.dart';
import '../../../../common/widgets/inputs/custom_text_field.dart';
import '../../../../core/routes/route_names.dart';
import 'profile_strength_screen.dart';
// import '../../../../common/widgets/effects/animated_fade_slide.dart'; // unused


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Alex Johnson');
  final _birthdateController = TextEditingController(text: '12/05/1998');
  final _bioController = TextEditingController(text: 'Adventure seeker 🌍 | Coffee lover ☕ | Design enthusiast 🎨. Looking for someone who matches my energy and loves exploring new places.');
  final _jobController = TextEditingController(text: 'Product Designer');
  final _schoolController = TextEditingController(text: 'IIT Bombay');
  final _locationController = TextEditingController(text: 'Mumbai, India');
  final _lookingForController = TextEditingController(text: 'A long-term relationship');
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _addedImages = [];
  // bool _isPickingImage = false; // unused


  @override
  void dispose() {
    _nameController.dispose();
    _birthdateController.dispose();
    _bioController.dispose();
    _jobController.dispose();
    _schoolController.dispose();
    _locationController.dispose();
    _lookingForController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'LoveAxis Date',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w900, fontSize: 24),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: Container(
            height: 4,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: const LinearProgressIndicator(
                value: 0.22,
                backgroundColor: AppColors.background,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Strength
            const Text(
              'Profile strength',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileStrengthScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black.withOpacity(0.05)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Text(
                      '22% complete',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black.withOpacity(0.5)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Photos and videos
            const Text(
              'Photos and videos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Pick some that show the true you.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              children: [
                _photoCell('https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200', true, "Main"),
                _photoCell('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200', false, "2"),
                _photoCell('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200', false, "3"),
                _addPhotoCell(),
                _addPhotoCell(),
                _addPhotoCell(),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Hold and drag media to reorder',
              style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.4), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            
            // Helpful hint box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb, color: Colors.black, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nailed it. You’re all set!',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Looking great - your photos are showing off the real you. 👌',
                          style: TextStyle(color: Colors.black.withOpacity(0.6), height: 1.4),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined, size: 18, color: Colors.black.withOpacity(0.6)),
                            const SizedBox(width: 16),
                            Icon(Icons.thumb_down_alt_outlined, size: 18, color: Colors.black.withOpacity(0.6)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            _menuItem(Icons.photo_library_outlined, 'Best Photo', 'On'),
            _menuItem(Icons.verified_user_rounded, 'Verification', 'Not ID verified', iconColor: Colors.blueAccent),
            const SizedBox(height: 32),

            // Interests Section
            const Text(
              'Interests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Get specific about the things you love.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _actionButton('Add interest badges'),
            const SizedBox(height: 32),

            // Causes section
            const Text(
              'My causes and communities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Add up to 3 causes close to your heart.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _actionButton('Add your causes and communities'),
            const SizedBox(height: 32),

            // Qualities section
            const Text(
              'Qualities I value',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose up to 3 qualities you value in a person.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _actionButton('Add their qualities'),
            const SizedBox(height: 32),

            // Prompts section
            const Text(
              'Prompts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Let people know what it\'s like to date you.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _promptRow('One thing you need to know about me is', 'Jyyhhuh'),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Add a bit more detail', style: TextStyle(fontWeight: FontWeight.w700)),
                              const SizedBox(height: 4),
                              Text(
                                'Share a specific thing people often ask you about, it can help spark better chats.',
                                style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 13),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.black.withOpacity(0.4)),
                                  const SizedBox(width: 12),
                                  Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.black.withOpacity(0.4)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _addPromptButton(),
            const SizedBox(height: 32),

            // Opening Moves
            const Text(
              'Opening Moves',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Add 3 first messages your new matches can reply to.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _actionButton('What\'s your karaoke song?'),
            const SizedBox(height: 32),

            // Bio
            const Text(
              'Bio',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Write a fun and punchy intro.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.05)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'A little bit about you...',
                style: TextStyle(color: Colors.black26),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lightbulb, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('A bio helps you stand out', style: TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(
                          'Try adding a line or two about yourself.',
                          style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined, size: 16, color: Colors.black.withOpacity(0.4)),
                            const SizedBox(width: 12),
                            Icon(Icons.thumb_down_alt_outlined, size: 16, color: Colors.black.withOpacity(0.4)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // About you Section
            const Text(
              'About you',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            _infoRow(Icons.cake_outlined, 'Age', '21'),
            _infoRow(Icons.work_outline_rounded, 'Work', 'Add'),
            _infoRow(Icons.school_outlined, 'Education', 'Add'),
            _infoRow(Icons.person_3_outlined, 'Gender', 'Man'),
            _infoRow(Icons.location_on_outlined, 'Location', 'Ahmedabad'),
            _infoRow(Icons.home_outlined, 'Hometown', 'Add'),
            const SizedBox(height: 32),

            // More about you Section
            const Text(
              'More about you',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Cover the things most people are curious about.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'How we use this information',
              style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 24),
            _infoRow(Icons.straighten_rounded, 'Height', '167 cm'),
            _infoRow(Icons.fitness_center_rounded, 'Exercise', 'Add'),
            _infoRow(Icons.school_outlined, 'Education level', 'Add'),
            _infoRow(Icons.wine_bar_rounded, 'Drinking', 'Add'),
            _infoRow(Icons.smoke_free_rounded, 'Smoking', 'Add'),
            _infoRow(Icons.search_rounded, 'Looking for', 'A long-term relationship, A life...'),
            _infoRow(Icons.auto_awesome_outlined, 'Zodiac', 'Add'),
            _infoRow(Icons.account_balance_outlined, 'Politics', 'Add'),
            _infoRow(Icons.self_improvement_outlined, 'Religion', 'Add'),
            const SizedBox(height: 32),

            // Pronouns
            const Text(
              'Pronouns',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Be you on Bumble and pick your pronouns.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _actionButton('Add your pronouns'),
            const SizedBox(height: 32),

            // Languages
            const Text(
              'Languages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Choose the languages you know.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            _actionButton('Add your languages'),
            const SizedBox(height: 32),

            // Connected accounts
            const Text(
              'Connected accounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'Connect your social accounts to show off your personality.',
              style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            _socialConnectItem(Icons.music_note_rounded, 'Spotify', Colors.green, subtitle: 'Show your top artists'),
            _socialConnectItem(Icons.chat_bubble_rounded, 'WhatsApp', const Color(0xFF25D366)),
            _socialConnectItem(Icons.camera_alt_rounded, 'Instagram', const Color(0xFFE1306C)),
            _socialConnectItem(Icons.facebook_rounded, 'Facebook', const Color(0xFF1877F2)),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _socialConnectItem(IconData icon, String label, Color color, {String? subtitle}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.05)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(color: Colors.black.withOpacity(0.6), height: 1.4, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  Widget _photoCell(String url, bool isPrimary, String label) {
    return _basePhotoCell(
      isPrimary: isPrimary,
      label: label,
      onRemove: () {
        // In a real app, remove from backend
      },
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

  Widget _filePhotoCell(XFile file, int index) {
    return _basePhotoCell(
      isPrimary: false,
      label: (index + 2).toString(),
      onRemove: () {
        setState(() {
          _addedImages.removeAt(index);
        });
      },
      child: kIsWeb
          ? Image.network(file.path, fit: BoxFit.cover)
          : Image.file(File(file.path), fit: BoxFit.cover),
    );
  }

  Widget _basePhotoCell({required Widget child, required bool isPrimary, required String label, required VoidCallback onRemove}) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox.expand(child: child),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Positioned(
          top: -2,
          right: -2,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
              child: const Icon(Icons.close_rounded, size: 14, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _addPhotoCell() {
    return GestureDetector(
      onTap: _showPhotoOptions,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider, style: BorderStyle.none),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(gradient: AppGradients.primary, shape: BoxShape.circle),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
          ),
        ),
      ),
    );
  }

  void _showPhotoOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text('Add Photo', style: AppTextStyles.titleLarge),
            const SizedBox(height: 8),
            Text('Choose a source to add a new photo', style: AppTextStyles.bodyMedium),
            const SizedBox(height: 32),
            _photoOptionTile(
              icon: Icons.camera_alt_rounded,
              label: 'Take a Photo',
              subtitle: 'Use your camera to snap a new one',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            const SizedBox(height: 16),
            _photoOptionTile(
              icon: Icons.photo_library_rounded,
              label: 'Choose from Gallery',
              subtitle: 'Pick an existing photo from your library',
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    debugPrint('LOVEAXIS: Requesting image branch source: $source');
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );
      if (image != null) {
        debugPrint('LOVEAXIS: Successfully picked image from $source. Path: ${image.path}');
        setState(() {
          _addedImages.add(image);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Photo added! 📸'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      } else {
        debugPrint('LOVEAXIS: Image picking cancelled by user.');
      }
    } catch (e) {
      debugPrint('LOVEAXIS ERROR: Error picking image: $e');
      if (mounted) {
        String errorMsg = 'Could not access ${source == ImageSource.camera ? 'camera' : 'gallery'}.';
        if (e.toString().contains('permission_denied')) {
          errorMsg = 'Permission denied. Please enable ${source == ImageSource.camera ? 'Camera' : 'Photos'} in settings.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      // Done
    }
  }

  Widget _photoOptionTile({
    required IconData icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.w700)),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textHint),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, String value, {Color iconColor = Colors.black45}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _actionButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.black.withOpacity(0.6)),
        ],
      ),
    );
  }

  Widget _promptRow(String title, String value) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black.withOpacity(0.6)),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.black.withOpacity(0.6)),
      ],
    );
  }

  Widget _addPromptButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Text(
            'Add a prompt',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black87),
          ),
          Spacer(),
          Icon(Icons.add, size: 24, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black87, size: 24),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.black.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _emptyCircle() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
    );
  }
}
