import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news/blocs/comments_provider.dart';
import 'package:news/models/item_model.dart';
import 'package:news/widgets/comment.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('News Details')),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWIthComments,
      builder:
          (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final itemFuture = snapshot.data[itemId];

            return FutureBuilder(
              future: itemFuture,
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
                if(!itemSnapshot.hasData) {
                  return CircularProgressIndicator();
                }


                return buildList(itemSnapshot.data, snapshot.data);
              },
            );
          },
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        itemMap: itemMap,
        depth: 0,
      );
    }).toList();
    children.addAll(commentsList);


    return ListView(
      children: children,
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
