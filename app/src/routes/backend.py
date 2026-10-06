from flask import Blueprint

backend_routes = Blueprint(
"backend",
**name**
)

@backend_routes.route("/api")
def api():
return {
"message": "Backend API Running"
}, 200
