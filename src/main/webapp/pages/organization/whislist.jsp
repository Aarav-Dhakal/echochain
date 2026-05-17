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
    <title>Wishlist - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="/organization/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="/organization/browse"><i class="fas fa-search"></i> Browse Listings</a>
            <a href="/organization/my-requests"><i class="fas fa-tasks"></i> My Requests</a>
            <a href="/organization/wishlist" class="active"><i class="fas fa-heart"></i> Wishlist</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>My Wishlist</h1>
                <p class="sub">Food categories you're currently watching</p>
            </div>
            <a href="/organization/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user-circle"></i></a>
        </div>

        <div class="empty-state" style="text-align: center; padding: 5rem; background: white; border-radius: 12px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
            <div style="font-size: 4rem; color: #fecaca; margin-bottom: 1.5rem;"><i class="fas fa-heart"></i></div>
            <h3 style="margin: 0; font-size: 1.5rem;">Your wishlist is empty</h3>
            <p style="color: #6b7280; margin: 1rem 0 2rem; max-width: 400px; margin-left: auto; margin-right: auto;">
                Save food categories to your wishlist to get notified when new donations matching your needs are posted.
            </p>
            <a href="/organization/browse" class="btn-primary" style="padding: 12px 30px;">Find Food to Watch</a>
        </div>
    </main>
</div>
</body>
</html>