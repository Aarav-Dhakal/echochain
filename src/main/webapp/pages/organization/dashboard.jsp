<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.organization.model.Organization" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("organization")) {
        response.sendRedirect("/login");
        return;
    }
    Organization organization = (Organization) request.getAttribute("org");
    if (organization == null && user.getRole().equals("organization")) {
        // If org is not in request, try to handle it (maybe redirected from an error)
        // For now, if it's missing and we're not already redirecting, we should probably check if we need to complete profile
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Organization Dashboard - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/organization/dashboard" class="active"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/organization/browse"><i class="fas fa-search"></i> Browse Listings</a>
            <a href="${pageContext.request.contextPath}/organization/my-requests"><i class="fas fa-tasks"></i> My Requests</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Welcome, <%= organization != null ? organization.getOrgName() : "User" %>!</h1>
                <p class="sub">Your organization activity overview</p>
            </div>
            <a href="/organization/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user-circle"></i></a>
        </div>

        <% String error = (String) request.getAttribute("error");
            if (error != null) { %>
        <div class="alert alert-danger" style="background: #fee2e2; color: #991b1b; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid #fecaca;">
            <strong>Error:</strong> <%= error %>
        </div>
        <% } %>

        <% if (organization != null) { %>
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-paper-plane"></i></div>
                <h3><%= request.getAttribute("totalRequests") %></h3>
                <p>Total Requests</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-check-double"></i></div>
                <h3><%= request.getAttribute("completedPickups") %></h3>
                <p>Completed Pickups</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-weight-hanging"></i></div>
                <h3><%= String.format("%.2f", organization.getTotalFoodReceived()) %> kg</h3>
                <p>Total Food Received</p>
            </div>
        </div>
        <% } %>

        <div class="quick-grid">
            <div class="quick-card">
                <h3><i class="fas fa-search" style="color: var(--primary); margin-right: 8px;"></i> Browse Listings</h3>
                <p>Find available food donations from local businesses and restaurants.</p>
                <a href="/organization/browse" class="btn-primary">Browse</a>
            </div>
            <div class="quick-card">
                <h3><i class="fas fa-clipboard-check" style="color: var(--info); margin-right: 8px;"></i> My Requests</h3>
                <p>Track and manage your pickup requests and delivery status.</p>
                <a href="/organization/my-requests" class="btn-primary">View Requests</a>
            </div>
        </div>
    </main>
</div>
</body>
</html>