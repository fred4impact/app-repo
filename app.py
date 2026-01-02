from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>GitOps Demo App</title>
        <style>
            body {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                font-family: Arial, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            }
            .content {
                text-align: center;
                font-size: 48px;
                font-weight: 900;
                color: #ffffff;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                line-height: 1.4;
            }
        </style>
    </head>
    <body>
        <div class="content">
            Hello <br>
            from GitOps + ArgoCD!<br>
            These demo app for GitOps practices
            <br> Flask application for GitOps practices from </br>
            Bilarn
        </div>
    </body>
    </html>
    '''

@app.route("/health")
def health():
    return {"status": "healthy"}, 200

if __name__ == "__main__":
    # Allow port to be configured via environment variable, default to 5000
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=False)
