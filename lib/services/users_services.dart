import 'package:chat_app_sockets/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app_sockets/global/enviroments.dart';
import 'package:chat_app_sockets/models/users_list_response.dart';
import 'package:chat_app_sockets/services/auth_service.dart';

class UsersServices {
  Future<List<User>> getUsers() async {
    try {
      final resp =
          await http.get(Uri.parse('${Enviroments.apiURL}/users'), headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken(),
      });
      final usersListResponse = usersListResponseFromJson(resp.body);
      return usersListResponse.data!.users;
    } catch (e) {
      return [];
    }
  }
}
