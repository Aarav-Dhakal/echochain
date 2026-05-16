<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Register - EcoChain</title>
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
            <p>Create your account</p>
        </a>

        <div class="alert alert-warning"><i class="fas fa-exclamation-triangle"></i> After registration, wait for admin approval before logging in.</div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="/register" method="post">
            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required/>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required/>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Create a password" required/>
            </div>
            <div class="form-group">
                <label for="role">Register As</label>
                <select id="role" name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="donor">Food Donor (Restaurant / Bakery / Store)</option>
                    <option value="organization">Recipient Organization (Shelter / Food Bank)</option>
                </select>
            </div>
            <button type="submit" class="btn-submit" style="width:100%;padding:12px;font-size:15px;">Register</button>
        </form>

        <div class="link">
            Already have an account? <a href="/login">Login here</a>
        </div>
    </div>
</div>
</body>
</html>