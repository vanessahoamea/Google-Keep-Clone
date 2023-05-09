import "dart:convert";
import "package:project/backend/database.dart";
import "package:shelf_router/shelf_router.dart";
import "package:shelf/shelf.dart";
import "package:shelf/shelf_io.dart" as io;

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
          json.encode({"message": "Logged in successfully.", "id": resp}),
          headers: {"Access-Control-Allow-Origin": "*"});
    } else {
      return Response.notFound(json.encode({"message": "User not found."}),
          headers: {"Access-Control-Allow-Origin": "*"});
    }
  });

  var server = await io.serve(app, "192.168.100.58", 8080);
  print("Server running on port ${server.port}");
}
