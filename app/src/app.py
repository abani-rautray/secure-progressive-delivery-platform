from flask import Flask
from routes.frontend import frontend_routes
from routes.backend import backend_routes

app = Flask(**name**)

# ==========================================

# Register Blueprints

# ==========================================

app.register_blueprint(frontend_routes)
app.register_blueprint(backend_routes)

# ==========================================

# Health Endpoint

# ==========================================

@app.route("/health")
def health():
return {
"status": "healthy"
}, 200

# ==========================================

# Main

# ==========================================

if **name** == "**main**":
app.run(
host="0.0.0.0",
port=8080
)
