import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_core/bloc/main_bloc.dart';
import 'package:red_core/widgets/repo_list_view_child_container.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late MainBloc mainBloc;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    mainBloc = BlocProvider.of<MainBloc>(context);
  }

  void fetchSearch() {
    final searchTerm = _searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      mainBloc.add(FetchSearchData(paramerterSearch: searchTerm));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.topLeft, child: Text("Search Movies")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for movies...',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchSearch,
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  if (state is FetchSearchDataLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is FetchSearchDataFailure) {
                    return const Center(
                        child: Text('No results For the input.'));
                  } else if (state is FetchSearchDataSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          final repo = state.data[index];
                          return MovieListContainer(
                            repo: repo,
                            title: repo.show?.name ?? 'No title',
                            url: repo.show?.image?.medium ?? '',
                            description: repo.show?.summary
                                    ?.replaceAll('<p>', '')
                                    .replaceAll('<b>', '')
                                    .replaceAll('</b>', '')
                                    .replaceAll('</p>', '') ??
                                'No description',
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('No results.'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
