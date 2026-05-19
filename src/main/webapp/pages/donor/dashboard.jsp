<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.donor.model.Donor" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("donor")) {
        response.sendRedirect("/login");
        return;
    }
    Donor donor = (Donor) request.getAttribute("donor");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Donor Dashboard - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/donor/dashboard" class="active"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/listing/add"><i class="fas fa-plus-circle"></i> Add Listing</a>
            <a href="${pageContext.request.contextPath}/listing/my-listings"><i class="fas fa-list"></i> My Listings</a>
            <a href="${pageContext.request.contextPath}/donor/pickup-requests"><i class="fas fa-truck"></i> Pickup Requests</a>
            <a href="${pageContext.request.contextPath}/donor/history"><i class="fas fa-history"></i> History</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <!-- Main -->
    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Welcome, <%= donor.getBusinessName() %>!</h1>
                <p class="sub">Here is your donation activity overview</p>
            </div>
            <a href="/donor/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user-circle"></i></a>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-box"></i></div>
                <h3><%= request.getAttribute("totalListings") %></h3>
                <p>Total Listings</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-check-circle"></i></div>
                <h3><%= request.getAttribute("totalPickups") %></h3>
                <p>Completed Pickups</p>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-star"></i></div>
                <h3><%= String.format("%.2f", donor.getReputationScore()) %></h3>
                <p>Reputation Score</p>
            </div>
        </div>

        <div class="quick-grid">
            <div class="quick-card">
                <h3><i class="fas fa-carrot" style="color: var(--primary); margin-right: 8px;"></i> Add New Listing</h3>
                <p>Post surplus food from your business for donation to community organizations.</p>
                <a href="/listing/add" class="btn-primary">Add Listing</a>
            </div>
            <div class="quick-card">
                <h3><i class="fas fa-clipboard-list" style="color: var(--info); margin-right: 8px;"></i> View My Listings</h3>
                <p>Manage your posted food items, check status, and track donation history.</p>
                <a href="/listing/my-listings" class="btn-primary">View Listings</a>
            </div>
        </div>
    </main>
</div>
</body>
</html>