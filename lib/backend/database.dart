import "package:postgres/postgres.dart";

class Database {
  PostgreSQLConnection conn = PostgreSQLConnection(
    "localhost",
    5432,
    "google-keep",
    username: "postgres",
    password: "postgres",
  );

  void loginUser(String email, String password) async {
    await conn.open();

    var user = await conn.query(
        "SELECT * FROM users WHERE email = @email AND password = @password",
        substitutionValues: {
          "email": email,
          "password": password,
        });

    try {
      print(user[0]);
    } catch (e) {
      print("User not found");
    }

    await conn.close();
  }
}
