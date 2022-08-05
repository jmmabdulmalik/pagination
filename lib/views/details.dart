import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models/model.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.pagingController}) : super(key: key);

  final PagingController<int, User> pagingController;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return PagedListView(
      pagingController: widget.pagingController,
      builderDelegate:
          PagedChildBuilderDelegate<User>(itemBuilder: (context, data, index) {
        return Card(
          color: Colors.green.shade50,
          elevation: 5.0,
          child: SizedBox(
            height: 100,
            width: 100,
            child: ListTile(
              title: Text(data.firstName),
              subtitle: Text(data.email),
              trailing: Text(data.password),
              leading: Image(
                image: NetworkImage(data.image),
              ),
            ),
          ),
        );
      }),
    );
  }
}
