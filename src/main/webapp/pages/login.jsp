<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="auth-page">
    <a href="${pageContext.request.contextPath}/" class="btn-back"><i class="fas fa-arrow-left"></i> Go Back</a>
    <div class="auth-card">
        <a href="${pageContext.request.contextPath}/" class="auth-logo" style="display: block; text-decoration: none;">
            <i class="fas fa-leaf" style="font-size: 40px; color: var(--primary); margin-bottom: 15px;"></i>
            <h1>EcoChain</h1>
            <p>Reducing food waste, feeding communities</p>
        </a>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("success") %></div>
        <% } %>

        <form action="/login" method="post">
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required/>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required/>
            </div>
            <button type="submit" class="btn-submit" style="width:100%;padding:12px;font-size:15px;">Login</button>
        </form>

        <div class="link">
            Don't have an account? <a href="/register">Register here</a>
        </div>
    </div>
</div>
</body>
</html>