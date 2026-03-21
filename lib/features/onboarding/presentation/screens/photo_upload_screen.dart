import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';
import '../widgets/onboarding_progress_bar.dart';
import '../widgets/onboarding_next_button.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  final List<String?> _photos = List.generate(6, (_) => null);

  void _addPhoto(int index) {
    // In a real app, this would open the image picker.
    // For now, we'll just simulate adding a photo with a placeholder.
    setState(() {
      _photos[index] = "https://picsum.photos/400/600?random=$index";
    });
  }

  void _removePhoto(int index) {
    setState(() {
      _photos[index] = null;
    });
  }

  int get _photoCount => _photos.where((p) => p != null).length;
  bool get _isComplete => _photoCount >= 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const OnboardingProgressBar(value: 1.0),
              const SizedBox(height: 48),
              const Text(
                "Time to put a face to\nthe name",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Add at least 4 photos to continue (${_photoCount}/6)",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return _buildPhotoSlot(index);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Drag to reorder",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    OnboardingNextButton(
                      enabled: _isComplete,
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.openingMove);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoSlot(int index) {
    final photo = _photos[index];
    return GestureDetector(
      onTap: () => photo == null ? _addPhoto(index) : null,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              image: photo != null ? DecorationImage(
                image: NetworkImage(photo),
                fit: BoxFit.cover,
              ) : null,
              border: photo == null ? Border.all(
                color: Colors.black12,
                width: 1.5,
                style: BorderStyle.solid,
              ) : null,
            ),
            child: photo == null ? const Center(
              child: Icon(Icons.add_rounded, color: Colors.black26, size: 32),
            ) : null,
          ),
          if (photo != null)
            Positioned(
              top: -8,
              right: -8,
              child: GestureDetector(
                onTap: () => _removePhoto(index),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                    ],
                  ),
                  child: const Icon(Icons.close_rounded, size: 16, color: Colors.black54),
                ),
              ),
            ),
          if (index == 0 && photo != null)
             Positioned(
              bottom: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Main",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
