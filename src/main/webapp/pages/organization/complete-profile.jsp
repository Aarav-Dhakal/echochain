<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || !user.getRole().equals("organization")) {
    response.sendRedirect("/login");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Complete Profile - EcoChain</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="auth-page">
  <div class="auth-card">
    <a href="${pageContext.request.contextPath}/" class="auth-logo" style="display: block; text-decoration: none;">
      <i class="fas fa-leaf" style="font-size: 40px; color: var(--primary); margin-bottom: 15px;"></i>
      <h1>EcoChain</h1>
      <p>Complete Your Organization Profile</p>
    </a>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="/organization/complete-profile" method="post">
      <input type="hidden" name="action" value="completeProfile"/>
      <div class="form-group">
        <label for="orgName">Organization Name</label>
        <input type="text" id="orgName" name="orgName" placeholder="Shelter / Food Bank name" required/>
      </div>
      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" id="address" name="address" placeholder="Organization address" required/>
      </div>
      <div class="form-group">
        <label for="phone">Phone</label>
        <input type="text" id="phone" name="phone" placeholder="Contact phone number" required/>
      </div>
      <div class="form-group">
        <label for="areaOfService">Area of Service</label>
        <input type="text" id="areaOfService" name="areaOfService" placeholder="e.g., Downtown, City Center" required/>
      </div>
      <div class="form-group">
        <label for="regCertificate">Registration Certificate</label>
        <input type="text" id="regCertificate" name="regCertificate" placeholder="Registration number" required/>
      </div>
      <button type="submit" class="btn-submit" style="width:100%;padding:12px;font-size:15px;">Complete Profile</button>
    </form>
  </div>
</div>
</body>
</html>