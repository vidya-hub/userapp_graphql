class QueryMutation {
  static String authUser() {
    return r"""
        query me{
          me{
            id
            firstName
            lastName
            email
            isActive
          }
        }
    """;
  }

  static String createUser(
    String userPW,
    String userName,
    String userEmail,
    String userMobile,
  ) {
    return """
    mutation s{
      createUser(
        password: "$userPW"
        firstName: "$userName"
        lastName: "$userName"
        email: "$userEmail"
        parentEmail:"$userEmail"
        phone: "$userMobile"
      ){
        success
      }
    }
    """;
  }

  static String getToken(
    String userPW,
    String userEmail,
  ) {
    return """
    mutation to{
      tokenAuth(
      email:"$userEmail"
      password:"$userPW"
    ) {
    token
    }
    }
    """;
  }
}
