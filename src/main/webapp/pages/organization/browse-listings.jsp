<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.listing.model.Listing" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("organization")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    List<Listing> listings = (List<Listing>) request.getAttribute("listings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Browse Listings - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/organization/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/organization/browse" class="active"><i class="fas fa-search"></i> Browse Listings</a>
            <a href="${pageContext.request.contextPath}/organization/my-requests"><i class="fas fa-tasks"></i> My Requests</a>
        </nav>
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Available Food Listings</h1>
                <p class="sub">Browse and request surplus food donations</p>
            </div>
            <a href="${pageContext.request.contextPath}/organization/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user"></i></a>
        </div>

        <div class="search-section" style="background: white; padding: 24px; border-radius: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 32px;">
            <form action="${pageContext.request.contextPath}/organization/browse" method="get" style="display: flex; gap: 12px; align-items: center;">
                <div style="flex: 1; position: relative;">
                    <i class="fas fa-search" style="position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: #94a3b8;"></i>
                    <input type="text" name="query" placeholder="Search for food, category, or business name..." value="<%= request.getParameter("query") != null ? request.getParameter("query") : "" %>" style="width: 100%; padding: 12px 12px 12px 48px; border: 1px solid #e2e8f0; border-radius: 12px; font-size: 1rem; outline: none; transition: border-color 0.2s;">
                </div>
                <button type="submit" class="btn-primary" style="padding: 12px 28px; border-radius: 12px; height: 48px;"><i class="fas fa-search"></i> Search</button>
                <% if (request.getParameter("query") != null && !request.getParameter("query").isEmpty()) { %>
                <a href="${pageContext.request.contextPath}/organization/browse" style="padding: 12px 20px; background: #f1f5f9; border-radius: 12px; color: #64748b; text-decoration: none; font-weight: 500; height: 48px; display: flex; align-items: center;">Clear</a>
                <% } %>
            </form>
        </div>

        <div class="listings-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 24px;">
            <% if (listings != null && !listings.isEmpty()) {
                for (Listing l : listings) { %>
            <div class="listing-card" style="background: white; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); border: 1px solid #f1f5f9; transition: transform 0.2s, box-shadow 0.2s;">
                <div class="card-body" style="padding: 24px;">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px;">
                        <span class="badge" style="background: #f0fdf4; color: #16a34a; padding: 4px 12px; border-radius: 100px; font-size: 0.75rem; font-weight: 600; text-transform: uppercase;"><%= l.getCategoryName() %></span>
                    </div>
                    <h4 style="font-size: 1.25rem; font-weight: 700; color: #1e293b; margin-bottom: 12px;"><%= l.getFoodName() %></h4>
                    <div style="display: flex; flex-direction: column; gap: 8px;">
                        <p style="font-size: 0.875rem; color: #64748b; display: flex; align-items: center; gap: 8px;"><i class="fas fa-weight-hanging" style="width: 16px;"></i> <strong>Quantity:</strong> <%= l.getQuantity() %> <%= l.getUnit() %></p>
                        <p style="font-size: 0.875rem; color: #64748b; display: flex; align-items: center; gap: 8px;"><i class="fas fa-calendar-alt" style="width: 16px;"></i> <strong>Expiry:</strong> <%= l.getExpiryDate() %></p>
                        <% if (l.getStorageNotes() != null && !l.getStorageNotes().isEmpty()) { %>
                        <p style="font-size: 0.875rem; color: #64748b; display: flex; align-items: center; gap: 8px;"><i class="fas fa-info-circle" style="width: 16px;"></i> <strong>Storage:</strong> <%= l.getStorageNotes() %></p>
                        <% } %>
                    </div>
                </div>
                <div class="card-actions" style="padding: 16px 24px; background: #f8fafc; border-top: 1px solid #f1f5f9;">
                    <form action="${pageContext.request.contextPath}/pickup/request" method="post" style="width:100%;">
                        <input type="hidden" name="action" value="requestPickup"/>
                        <input type="hidden" name="listingId" value="<%= l.getId() %>"/>
                        <button type="submit" class="btn-primary" style="width:100%; border-radius: 12px; display: flex; align-items: center; justify-content: center; gap: 8px;"><i class="fas fa-truck"></i> Request Pickup</button>
                    </form>
                </div>
            </div>
            <% } } else { %>
            <div style="grid-column: 1 / -1; text-align: center; padding: 64px;">
                <div style="font-size: 48px; color: #cbd5e1; margin-bottom: 16px;"><i class="fas fa-search"></i></div>
                <h3 style="color: #1e293b; font-weight: 600;">No listings found</h3>
                <p style="color: #64748b;">There are no available food donations matching your search.</p>
            </div>
            <% } %>
        </div>
    </main>
</div>
</body>
</html>