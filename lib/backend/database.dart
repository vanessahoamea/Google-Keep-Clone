import "package:postgres/postgres.dart";

class Database {
  Future<int?> loginUser(String email, String password) async {
    PostgreSQLConnection conn = PostgreSQLConnection(
      "localhost",
      5432,
      "google-keep",
      username: "postgres",
      password: "postgres",
    );

    await conn.open();

    var user = await conn.query(
        "SELECT * FROM users WHERE email = @email AND password = @password",
        substitutionValues: {
          "email": email,
          "password": password,
        });
    var result = user.isNotEmpty ? user[0][0] : null;

    await conn.close();
    return result;
  }
}
