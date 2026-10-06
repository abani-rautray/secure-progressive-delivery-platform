from flask import Blueprint

frontend_routes = Blueprint(
"frontend",
**name**
)

@frontend_routes.route("/")
def home():
return {
"message": "Frontend Service Running"
}, 200
