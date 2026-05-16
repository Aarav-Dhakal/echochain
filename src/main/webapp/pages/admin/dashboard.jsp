<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Dashboard - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="/admin/dashboard" class="active"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="/admin/users"><i class="fas fa-users"></i> Users</a>
            <a href="/admin/categories"><i class="fas fa-folder"></i> Categories</a>
            <a href="/admin/listings"><i class="fas fa-clipboard-list"></i> Listings</a>
            <a href="/admin/impact"><i class="fas fa-chart-bar"></i> Impact Report</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Welcome, <%= user.getFullName() %>!</h1>
                <p class="sub">Platform administration overview</p>
            </div>
            <div class="user-avatar"><i class="fas fa-user-shield"></i></div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-users"></i></div>
                <h3><%= request.getAttribute("totalUsers") %></h3>
                <p>Total Users</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-clock"></i></div>
                <h3><%= request.getAttribute("pendingUsers") %></h3>
                <p>Pending Approvals</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-box"></i></div>
                <h3><%= request.getAttribute("totalListings") %></h3>
                <p>Total Listings</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon red"><i class="fas fa-check-circle"></i></div>
                <h3><%= request.getAttribute("totalPickups") %></h3>
                <p>Completed Pickups</p>
            </div>
        </div>

        <div class="impact-section" style="margin-top: 2rem;">
            <h2><i class="fas fa-seedling" style="color: var(--primary); margin-right: 10px;"></i> Environmental Impact</h2>
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon green"><i class="fas fa-apple-alt"></i></div>
                    <h3><%= String.format("%.2f", request.getAttribute("totalFoodRescued")) %> kg</h3>
                    <p>Food Rescued</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fas fa-thermometer-half"></i></div>
                    <h3><%= String.format("%.2f", request.getAttribute("totalCO2Saved")) %> kg</h3>
                    <p>CO2 Saved</p>
                </div>
                <div class="stat-card">
                    <div class="stat-icon orange"><i class="fas fa-soup"></i></div>
                    <h3><%= request.getAttribute("totalMealsServed") %></h3>
                    <p>Meals Served</p>
                </div>
            </div>
        </div>

        <div class="quick-grid">
            <div class="quick-card">
                <h3><i class="fas fa-users-cog" style="color: var(--primary); margin-right: 8px;"></i> User Management</h3>
                <p>Approve, suspend, or delete user accounts across the platform.</p>
                <a href="/admin/users" class="btn-primary">Manage Users</a>
            </div>
            <div class="quick-card">
                <h3><i class="fas fa-tags" style="color: var(--info); margin-right: 8px;"></i> Category Management</h3>
                <p>Add or remove food categories to keep listings organized.</p>
                <a href="/admin/categories" class="btn-primary">Manage Categories</a>
            </div>
        </div>
    </main>
</div>
</body>
</html>