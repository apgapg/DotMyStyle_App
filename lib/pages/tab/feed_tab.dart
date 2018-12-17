import 'package:flutter/material.dart';
import 'package:salon/bloc/home_bloc.dart';
import 'package:salon/feed_model.dart';
import 'package:salon/utils/dialog_utils.dart';
import 'package:salon/widget/feed_card.dart';

class FeedTab extends StatefulWidget {
  _FeedTabState createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  FeedBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = new FeedBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<FeedItem>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              itemBuilder: (context, index) {
                return FeedCard(snapshot.data.elementAt(index));
              },
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.feedController.stream,
      ),
    );
  }
}
