<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>404 - Page Not Found</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: Arial, sans-serif;
            background: #f0f4f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            text-align: center;
        }
        .container {
            background: white;
            padding: 60px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 { font-size: 72px; color: #2e7d32; margin-bottom: 20px; }
        p { color: #666; font-size: 18px; margin-bottom: 30px; }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            background: #2e7d32;
            color: white;
            text-decoration: none;
            border-radius: 6px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>404</h1>
    <p>Oops! Page not found.</p>
    <a href="/" class="btn">Go Home</a>
</div>
</body>
</html>