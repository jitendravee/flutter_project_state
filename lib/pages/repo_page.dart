import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:red_core/bloc/main_bloc.dart';
import 'package:red_core/widgets/repo_list_view_child_container.dart';

class RepoPage extends StatefulWidget {
  const RepoPage({super.key});

  @override
  State<RepoPage> createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
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
        title: const Text('Repositories'),
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
              return const Center(child: Text('Failed to load repositories.'));
            } else if (state is FetchRepoDataSuccess) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final repo = state.data[index];
                  return RepoListViewChildContainer(
                      ownerData: repo.owner!,
                      description: repo.description ?? 'No description',
                      commentCount: repo.comments ?? 0,
                      createdDate: repo.createdAt ?? 'No Date data',
                      updatedDate: repo.updatedAt ?? 'No Date data');
                },
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
