import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:userapp/graphql/QueryMutation.dart';
import 'package:userapp/utils/shared_pref.dart';

class GraphqlService {
  static final HttpLink httpLink = HttpLink(
    uri: "https://mocktestbk.herokuapp.com/graphql/",
  );
  static HttpLink httpLinkAuth(String authToken) => HttpLink(
        uri: "https://mocktestbk.herokuapp.com/graphql/",
        headers: {
          "Authorization": "JWT $authToken",
        },
      );

  static Future<QueryResult> createUserService(
    String userId,
    String userPW,
    String userName,
    String userEmail,
    String userMobile,
  ) async {
    QueryResult response = await client().value.mutate(
          MutationOptions(
            // ignore: deprecated_member_use
            document: QueryMutation.createUser(
              userPW,
              userName,
              userEmail,
              userMobile,
            ),
          ),
        );
    return response;
  }

  static Future<QueryResult> getUserStatus(String authToken) async {
    print(authToken);
    QueryResult response = await clientAuth(authToken).value.query(
          QueryOptions(
            document: QueryMutation.authUser(),
          ),
        );

    // print(response.hasException);
    return response;
  }

  static ValueNotifier<GraphQLClient> client() {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: httpLink,
      ),
    );
    return client;
  }

  static ValueNotifier<GraphQLClient> clientAuth(String authToken) {
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
        link: httpLinkAuth(authToken),
      ),
    );
    return client;
  }
}
