import "package:postgres/postgres.dart";
import "package:project/backend/database.dart";
import "package:shelf_router/shelf_router.dart";
import "package:shelf/shelf.dart";
import "package:shelf/shelf_io.dart" as io;
import "dart:convert";

void main() async {
  var app = Router();
  var db = Database();

  app.get("/", (Request request) {
    return Response.ok(json.encode({"message": "Welcome to the API!"}),
        headers: {"Access-Control-Allow-Origin": "*"});
  });

  app.post("/login", (Request request) async {
    var payload = await request.readAsString();
    var data = json.decode(payload);

    if (!data.containsKey("email") || !data.containsKey("password")) {
      return Response.badRequest(
          body: json
              .encode({"message": "Fields 'email', 'password' are required."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }

    var resp = await db.loginUser(data["email"], data["password"]);
    if (resp != null) {
      return Response.ok(
          json.encode({
            "id": resp,
            "email": data["email"],
          }),
          headers: {"Access-Control-Allow-Origin": "*"});
    } else {
      return Response.notFound(json.encode({"message": "User not found."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }
  });

  app.post("/notes/<id>", (Request request, String id) async {
    int? userId;
    DateTime now = DateTime.now();
    String today = DateTime(now.year, now.month, now.day)
        .toString()
        .replaceAll("00:00:00.000", "");

    var payload = await request.readAsString();
    var data = json.decode(payload);

    try {
      userId = int.parse(id);
    } catch (e) {
      return Response.badRequest(
          body: json.encode({"message": "Invalid user ID."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }

    if (!data.containsKey("title") || !data.containsKey("content")) {
      return Response.badRequest(
          body: json
              .encode({"message": "Fields 'title', 'content' are required."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }

    var resp =
        await db.createNote(userId, data["title"], data["content"], today);
    if (resp) {
      return Response.ok(json.encode({"message": "Note created successfully."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    } else {
      return Response.internalServerError(
          body: json.encode({"message": "Something went wrong."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }
  });

  app.get("/notes/<id>", (Request request, String id) async {
    int? userId;

    try {
      userId = int.parse(id);
    } catch (e) {
      return Response.badRequest(
          body: json.encode({"message": "Invalid user ID."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }

    var resp = await db.getUserNotes(userId);
    List<Map> allNotes = [];
    for (var note in resp) {
      allNotes.add({
        "id": note[0],
        "title": note[2],
        "content": note[3],
        "date_modified": note[4].toString(),
      });
    }

    return Response.ok(json.encode({"data": allNotes}),
        headers: {"Access-Control-Allow-Origin": "*"});
  });

  var server = await io.serve(app, "192.168.100.58", 8080);
  print("Server running on port ${server.port}");
}
