import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:new_pagination/models/model.dart';

import '../controlers/cubits/api_cubit.dart';
import 'details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);

  static int pageSize = 0;

  @override
  void initState() {
    pageSize = 1;
    _pagingController.addPageRequestListener((pageKey) {
      context.read<ApiCubit>().getData(pageKey);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ApiCubit, ApiState>(
        listener: (context, state) {
          if (state is ApiLoaded) {
            pageSize < state.model!.total
                ? _pagingController.appendPage(state.model!.users, pageSize++)
                : _pagingController.appendLastPage(
                    state.model!.users,
                  );
          }
        },
        builder: (context, state) {
          if (state is ApiInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ApiLoaded) {
            return Details(
              pagingController: _pagingController,
            );
          } else if (state is ApiError) {
            return const Text('Error');
          } else {
            return Container(
              color: Colors.grey,
            );
          }
        },
      ),
    );
  }
}
