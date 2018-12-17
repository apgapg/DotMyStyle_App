import 'package:flutter/material.dart';
import 'package:salon/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = new ProfileBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Profile",
          style: TextStyle(color: Colors.blueGrey[700]),
        ),
        iconTheme: IconThemeData(
          color: Colors.blueGrey[700],
        ),
        elevation: 2.0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text("Amit Kumar"),
            subtitle: Text("+91-7078689565"),
            trailing: Icon(Icons.settings),
          ),
          WalletMenuItem(),
          MenuItem("Wishlist"),
          MenuItem("Booking History"),
          MenuItem("Support"),
          MenuItem("Invite Friends"),
          MenuItem("About Us"),
          MenuItem("Logout"),
        ],
      ),
      /*body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<List<ProductItem>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(4.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return ProductCard(snapshot.data.elementAt(index));
                    }, childCount: snapshot.data.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Some error..."),
            );
          } else {
            return DialogUtils.showCircularProgressBar();
          }
        },
        stream: _bloc.profileController,
      ),*/
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class MenuItem extends StatelessWidget {
  final String title;

  MenuItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[100]),
              bottom: BorderSide(color: Colors.grey[100]))),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

class WalletMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(color: Colors.grey[100]),
              bottom: BorderSide(color: Colors.grey[100]))),
      child: ListTile(
        title: Text("DOT Wallet"),
        trailing: Container(
          height: 24.0,
          child: Text(
            "₹ 0",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
          decoration: BoxDecoration(
              color: Color(0xff64DD17),
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
        ),
      ),
    );
  }
}
