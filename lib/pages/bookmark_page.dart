import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_core/bloc/main_bloc.dart';
import 'package:red_core/widgets/shared_prefs.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final Set<String> _bookmarkedImages = {};

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await BookmarkStorage.loadBookmarks();
    setState(() {
      _bookmarkedImages.addAll(bookmarks);
    });
    context.read<MainBloc>().add(FetchImageData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Images')),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is FetchImageDataLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchImageDataSuccess) {
            final images = state.data
                .where((image) => _bookmarkedImages.contains(image.id))
                .toList();

            return images.isEmpty
                ? const Center(child: Text('No bookmarks yet'))
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];

                      return Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${image.createdAt.toLocal()}'.split(' ')[0],
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
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
