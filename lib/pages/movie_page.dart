import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:red_core/bloc/main_bloc.dart';
import 'package:red_core/main.dart';
import 'package:red_core/widgets/repo_list_view_child_container.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late MainBloc mainBloc;

  @override
  void initState() {
    super.initState();
    final mainBloc = BlocProvider.of<MainBloc>(context);
    if (mainBloc.state is! FetchRepoDataSuccess) {
      mainBloc.add(FetchRepoData());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
            alignment: Alignment.topLeft, child: Text('Movie Lists')),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final homePageState =
                  context.findAncestorStateOfType<MyHomePageState>()!;
              homePageState.onIconTap(1);
            },
          ),
        ],
      ),
      body: BlocListener<MainBloc, MainState>(
        listener: (context, state) {
          if (state is FetchRepoDataFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to fetch data')),
            );
          }
        },
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (state is MainInitial || state is FetchRepoDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FetchRepoDataFailure) {
              return const Center(child: Text('Failed to load movies.'));
            } else if (state is FetchRepoDataSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      title: repo.show?.name ?? '',
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
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
