// @dart=2.9

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/screens/signin.dart';
import 'package:userapp/screens/welcomePage.dart';
import 'package:userapp/service/GraphqlService.dart';

import 'utils/shared_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var user = await SharedPref.getUserData();
  String token = '';
  print(user);
  final AuthLink authLink = AuthLink(
    getToken: () async => 'JWT $user',
  );
  final Link link = authLink.concat(
    HttpLink(
      uri: "https://mocktestbk.herokuapp.com/graphql/",
    ),
  );
  ValueNotifier<GraphQLClient> clientAuth(String authToken) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: link,
      ),
    );
    return client;
  }

  runApp(
    GraphQLProvider(
      client: clientAuth(user),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (user != null && user != null && user.toString().trim() != "")
            ? GamePage()
            : HomePage(
                token: token,
              ),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  final String token;
  HomePage({this.token});
  @override
  Widget build(BuildContext context) {
    return LogInPage();
  }
}



    /* 
    print(token);
    GraphqlService.getUserStatus(token).then(
      (value) {
        // print((jsonEncode(value.source)));
        print((value.data));
      },
    ); */