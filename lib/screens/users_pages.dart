import 'package:chat_app_sockets/helpers/show_snack.dart';
import 'package:chat_app_sockets/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app_sockets/models/user.dart';
import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:chat_app_sockets/services/socket_service.dart';
import 'package:chat_app_sockets/services/users_services.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final Color colorHeader = Colors.black54;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final userServices = UsersServices();

  List<User> users = [];
  bool isMounted = false;

  @override
  void initState() {
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;
    final isServerOffline = ServerStatus.Offline == socketService.serverStatus;

    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
          elevation: 1,
          backgroundColor: this.colorHeader,
          leading: IconButton(
              onPressed: () async {
                socketService.disconnect();
                await AuthService.logout();
                Navigator.pushReplacementNamed(context, 'login');
              },
              icon: Icon(Icons.exit_to_app)),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: isServerOffline
                  ? Icon(
                      Icons.offline_bolt_outlined,
                      color: Colors.red.shade400,
                    )
                  : Icon(
                      Icons.flash_on_outlined,
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
            complete: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
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
    final chatService = Provider.of<ChatService>(context, listen: false);
    return ListTile(
      onTap: () {
        chatService.userReceive = user;
        Navigator.pushNamed(context, "chat");
      },
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
    this.users = await userServices.getUsers();

    if (this.users.length == 0) {
      showSnackBar(
          context: context,
          title: "No hay usuarios conectados",
          color: Colors.red);
    }

    if (isMounted) {
      showSnackBar(
        context: context,
        title: "Lista actualizada",
      );
    }
    this.isMounted = true;
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
