import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/graphql/QueryMutation.dart';
import 'package:userapp/service/GraphqlService.dart';

class AuthService {
  static var client = GraphqlService.client();

  // static bool login() {
  //   print("login test");
  //   bool result = GraphqlService.checkToken();
  //   return result;
  // }

  static Future<QueryResult> getToken(String userEmail, String userPW) async {
    print(QueryMutation.getToken(userPW, userEmail));

    QueryResult response = await client.value.query(
      QueryOptions(
        // ignore: deprecated_member_use
        document: QueryMutation.getToken(userPW, userEmail),
        variables: {
          'email': userEmail,
          'password': userPW,
        },
      ),
    );
    return response;
  }

  static Future<QueryResult> createUser(
    String userPW,
    String userName,
    String userEmail,
    String userMobile,
  ) async {
    print(
      QueryMutation.createUser(userPW, userName, userEmail, userMobile),
    );
    QueryResult response = await client.value.query(
      QueryOptions(
        // ignore: deprecated_member_use
        document:
            QueryMutation.createUser(userPW, userName, userEmail, userMobile),
        variables: {
          'email': userEmail,
          'password': userPW,
          'phone': userMobile,
          'firstName': userName,
          'lastName': userName,
        },
      ),
    );
    return response;
  }

  // static logout() async {
  //   await GraphqlService.deleteToken();
  //   bool result = GraphqlService.checkToken();
  //   print(result);
  // }
}
