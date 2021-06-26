import 'package:chat_app_sockets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final Color colorHeader = Colors.black54;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final users = [
    User(
        email: 'email@email', name: "Zaira Ronda", online: false, uid: "12323"),
    User(email: 'emai1l@email', name: "Amelia Ronda", online: true, uid: "asd"),
    User(
        email: 'email2@email',
        name: "Jorge Ronda",
        online: false,
        uid: "43efs"),
    User(
        email: 'email3@email',
        name: "Alexandra Ronda",
        online: true,
        uid: "6543"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cristian Ronda"),
          elevation: 1,
          backgroundColor: this.colorHeader,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.exit_to_app)),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.online_prediction_sharp,
                color: Colors.greenAccent.shade400,
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          primary: true,
          onRefresh: () => _loadUsers(),
          header: WaterDropHeader(
            complete: Icon(Icons.check_circle,color: Colors.green,),
            failed: Icon(Icons.error_rounded, color: Colors.red),
          ),
          child: _userListView(),
        ));
  }

  ListView _userListView() {
    return ListView.separated(
      itemBuilder: (_, i) => _userListTile(users[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: user.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(122),
        ),
      ),
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent.shade400,
        child: Text(user.name.substring(0, 2)),
      ),
    );
  }

  _loadUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
