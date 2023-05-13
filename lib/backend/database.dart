import "package:postgres/postgres.dart";

class Database {
  Future<int> createUser(String email, String password) async {
    PostgreSQLConnection conn = PostgreSQLConnection(
      "localhost",
      5432,
      "google-keep",
      username: "postgres",
      password: "postgres",
    );

    await conn.open();

    var user = await conn.query("SELECT * FROM users WHERE email = @email",
        substitutionValues: {"email": email});
    if (user.isNotEmpty) return -1;

    int result = 1;
    try {
      await conn.query(
          "INSERT INTO users (email, password) VALUES (@email, @password)",
          substitutionValues: {"email": email, "password": password});
    } catch (e) {
      result = 0;
    }

    await conn.close();
    return result;
  }

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

  Future<bool> createNote(
      int userId, String title, String content, String date) async {
    PostgreSQLConnection conn = PostgreSQLConnection(
      "localhost",
      5432,
      "google-keep",
      username: "postgres",
      password: "postgres",
    );

    await conn.open();

    bool result = true;
    try {
      await conn.query(
          "INSERT INTO notes (user_id, title, content, date_modified) VALUES (@userId, @title, @content, @date)",
          substitutionValues: {
            "userId": userId,
            "title": title,
            "content": content,
            "date": date,
          });
    } catch (e) {
      result = false;
    }

    await conn.close();
    return result;
  }

  Future<List> getUserNotes(int userId) async {
    PostgreSQLConnection conn = PostgreSQLConnection(
      "localhost",
      5432,
      "google-keep",
      username: "postgres",
      password: "postgres",
    );

    await conn.open();

    var notes = await conn.query(
        "SELECT * FROM notes WHERE user_id = @userId ORDER BY id DESC",
        substitutionValues: {
          "userId": userId,
        });
    List result = notes.toList();

    await conn.close();
    return result;
  }

  Future<bool> updateNote(
      int noteId, String title, String content, String date) async {
    PostgreSQLConnection conn = PostgreSQLConnection(
      "localhost",
      5432,
      "google-keep",
      username: "postgres",
      password: "postgres",
    );

    await conn.open();

    bool result = true;
    try {
      await conn.query(
          "UPDATE notes SET title = @title, content = @content, date_modified = @date WHERE id = @id",
          substitutionValues: {
            "title": title,
            "content": content,
            "date": date,
            "id": noteId
          });
    } catch (e) {
      result = false;
    }

    await conn.close();
    return result;
  }

  Future<bool> deleteNote(int noteId) async {
    PostgreSQLConnection conn = PostgreSQLConnection(
      "localhost",
      5432,
      "google-keep",
      username: "postgres",
      password: "postgres",
    );

    await conn.open();

    bool result = true;
    try {
      await conn.query("DELETE FROM notes WHERE id = @id",
          substitutionValues: {"id": noteId});
    } catch (e) {
      result = false;
    }

    await conn.close();
    return result;
  }
}
