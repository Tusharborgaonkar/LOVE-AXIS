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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Done', style: AppTextStyles.bodyPrimary.copyWith(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photos Grid
            Text('Photos', style: AppTextStyles.titleLarge),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _photoCell('https://images.unsplash.com/photo-1527980965255-d3b416303d12?w=200', true),
                ..._addedImages.asMap().entries.map((entry) => _filePhotoCell(entry.value, entry.key)),
                if (_addedImages.length < 5) _addPhotoCell(),
                if (_addedImages.length < 4) _addPhotoCell(),
                if (_addedImages.length < 3) _addPhotoCell(),
                if (_addedImages.length < 2) _addPhotoCell(),
                if (_addedImages.isEmpty) _addPhotoCell(),
              ],
            ),
            const SizedBox(height: 32),

            // Info
            Text('About Me', style: AppTextStyles.titleLarge),
            const SizedBox(height: 12),
            CustomTextField(
              hint: 'Bio',
              controller: _bioController,
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            Text('Basic Info', style: AppTextStyles.titleLarge),
            const SizedBox(height: 12),
            CustomTextField(
              hint: 'Full Name',
              controller: _nameController,
              prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Birthdate',
              controller: _birthdateController,
              prefixIcon: const Icon(Icons.calendar_today_rounded, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Job Title',
              controller: _jobController,
              prefixIcon: const Icon(Icons.work_outline_rounded, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Education',
              controller: _schoolController,
              prefixIcon: const Icon(Icons.school_outlined, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Location',
              controller: _locationController,
              prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.textHint),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              hint: 'Looking For',
              controller: _lookingForController,
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textHint),
            ),
            const SizedBox(height: 32),

            // Interests
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Interests', style: AppTextStyles.titleLarge),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, RouteNames.interests),
                  child: Text('Edit', style: AppTextStyles.bodyPrimary),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ['Travel', 'Coffee', 'Design', 'Music', 'Photography'].map((i) => _chip(i)).toList(),
            ),
            const SizedBox(height: 40),

            GradientButton(
              label: 'Save Changes ✨',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Profile updated successfully! ✨'),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _photoCell(String url, bool isPrimary) {
    return _basePhotoCell(
      isPrimary: isPrimary,
      onRemove: () {
        // In a real app, remove from backend
      },
      child: Image.network(url, fit: BoxFit.cover),
    );
  }

  Widget _filePhotoCell(XFile file, int index) {
    return _basePhotoCell(
      isPrimary: false,
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

  Widget _basePhotoCell({required Widget child, required bool isPrimary, required VoidCallback onRemove}) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox.expand(child: child),
        ),
        if (isPrimary)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.8),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              child: const Text(
                'Primary',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.close_rounded, size: 12, color: AppColors.error),
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

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(label, style: AppTextStyles.labelMedium),
    );
  }
}
