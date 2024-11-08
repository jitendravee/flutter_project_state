import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:red_core/bloc/main_bloc.dart';
import 'package:red_core/model/image_model.dart';
import 'package:red_core/widgets/shared_prefs.dart';

class ImagesView extends StatefulWidget {
  const ImagesView({super.key});

  @override
  State<ImagesView> createState() => _ImagesViewState();
}

class _ImagesViewState extends State<ImagesView> {
  final Set<String> _bookmarkedImages = {};

  @override
  void initState() {
    super.initState();
    context.read<MainBloc>().add(FetchImageData());

    // Load bookmarks on init
    BookmarkStorage.loadBookmarks().then((bookmarks) {
      setState(() {
        _bookmarkedImages.addAll(bookmarks);
      });
    });
  }

  void _toggleBookmark(String imageId) async {
    setState(() {
      if (_bookmarkedImages.contains(imageId)) {
        _bookmarkedImages.remove(imageId);
      } else {
        _bookmarkedImages.add(imageId);
      }
    });
    await BookmarkStorage.saveBookmarks(_bookmarkedImages);
  }

  void _openFullScreenImage(ImageModel image) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageView(
          image: image,
          isBookmarked: _bookmarkedImages.contains(image.id),
          onBookmarkToggle: () => _toggleBookmark(image.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is FetchImageDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchImageDataSuccess) {
            final images = state.data;

            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index];
                final isBookmarked = _bookmarkedImages.contains(image.id);

                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _openFullScreenImage(image),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                image.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          image.uploaderName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${image.createdAt.toLocal()}'.split(' ')[0],
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.yellow : Colors.white,
                        ),
                        onPressed: () => _toggleBookmark(image.id),
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is FetchImageDataFailure) {
            return const Center(child: Text('Failed to load images'));
          } else {
            return const Center(child: Text('No images available'));
          }
        },
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final ImageModel image;
  final bool isBookmarked;
  final VoidCallback onBookmarkToggle;

  const FullScreenImageView({
    super.key,
    required this.image,
    required this.isBookmarked,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(image.uploaderName),
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: isBookmarked ? Colors.yellow : Colors.white,
            ),
            onPressed: onBookmarkToggle,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PhotoView(
              imageProvider: NetworkImage(image.imageUrl),
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 30, bottom: 30),
            child: Text(
              'Uploaded on ${image.createdAt.toLocal()}',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
