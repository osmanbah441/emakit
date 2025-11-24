import 'package:cached_network_image/cached_network_image.dart';
import 'package:component_library/src/centered_progress_indicator.dart';
import 'package:flutter/material.dart';

class ProductImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final BorderRadius borderRadius;
  final double aspectRatio;

  /// If false, the user cannot swipe between images, and indicators are hidden.
  /// Defaults to true.
  final bool isScrollable;

  /// If false, tapping the image will not open the full-screen view.
  /// Defaults to true.
  final bool enableFullScreen;

  const ProductImageCarousel({
    super.key,
    required this.imageUrls,
    this.borderRadius = BorderRadius.zero,
    this.aspectRatio = 1 / 1,
    this.isScrollable = true,
    this.enableFullScreen = true,
  });

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (widget.imageUrls.isEmpty) {
      return Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: colorScheme.onSurfaceVariant,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              // 1. Disable scrolling physics if isScrollable is false
              physics: widget.isScrollable
                  ? const PageScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemCount: widget.imageUrls.length,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemBuilder: (context, index) {
                return GestureDetector(
                  // 2. Disable Tap if enableFullScreen is false
                  onTap: widget.enableFullScreen
                      ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => _FullScreenCarouselView(
                              imageUrls: widget.imageUrls,
                              initialPage: _currentPage,
                            ),
                          ),
                        )
                      : null,
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrls[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CenteredProgressIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error_outline,
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                );
              },
            ),
            // 3. Only show indicator if scrollable is true
            if (widget.isScrollable)
              _PageIndicator(
                imageCount: widget.imageUrls.length,
                currentPage: _currentPage,
              ),
          ],
        ),
      ),
    );
  }
}

// --- Helper classes (Unchanged) ---

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.imageCount, required this.currentPage});

  final int imageCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    if (imageCount <= 1) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      bottom: 10.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: .5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imageCount, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              width: currentPage == index ? 16.0 : 8.0,
              height: 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: currentPage == index
                    ? colorScheme.surface
                    : colorScheme.surface.withValues(alpha: .5),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _FullScreenCarouselView extends StatefulWidget {
  const _FullScreenCarouselView({
    required this.imageUrls,
    required this.initialPage,
  });

  final List<String> imageUrls;
  final int initialPage;

  @override
  State<_FullScreenCarouselView> createState() =>
      _FullScreenCarouselViewState();
}

class _FullScreenCarouselViewState extends State<_FullScreenCarouselView> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _jumpToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.imageUrls.length,
              onPageChanged: (value) => setState(() => _currentPage = value),
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrls[index],
                    fit: BoxFit.contain,
                    placeholder: (context, url) => CenteredProgressIndicator(),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.error_outline,
                        color: colorScheme.error,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _ThumbnailList(
            imageUrls: widget.imageUrls,
            currentPage: _currentPage,
            onThumbnailTap: _jumpToPage,
          ),
        ],
      ),
    );
  }
}

class _ThumbnailList extends StatelessWidget {
  const _ThumbnailList({
    required this.imageUrls,
    required this.currentPage,
    required this.onThumbnailTap,
  });

  final List<String> imageUrls;
  final int currentPage;
  final ValueChanged<int> onThumbnailTap;

  @override
  Widget build(BuildContext context) {
    if (imageUrls.length <= 1) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemBuilder: (context, index) {
          final isSelected = currentPage == index;
          return GestureDetector(
            onTap: () => onThumbnailTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? colorScheme.primary : Colors.transparent,
                  width: isSelected ? 3.0 : 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrls[index],
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 60,
                    height: 60,
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 60,
                    height: 60,
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: colorScheme.onSurfaceVariant,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
