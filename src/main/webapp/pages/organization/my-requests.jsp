<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.pickup.model.OrgPickupRequestDTO" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("organization")) {
        response.sendRedirect("/login");
        return;
    }
    List<OrgPickupRequestDTO> requests = (List<OrgPickupRequestDTO>) request.getAttribute("requests");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>My Requests - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/organization/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/organization/browse"><i class="fas fa-search"></i> Browse Listings</a>
            <a href="${pageContext.request.contextPath}/organization/my-requests" class="active"><i class="fas fa-tasks"></i> My Requests</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>My Pickup Requests</h1>
                <p class="sub">Track the status of food you've requested</p>
            </div>
            <a href="/organization/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user-circle"></i></a>
        </div>

        <div class="requests-list" style="display: flex; flex-direction: column; gap: 1.5rem;">
            <% if (requests != null && !requests.isEmpty()) {
                for (OrgPickupRequestDTO r : requests) { %>
            <div class="request-card" style="background: white; padding: 1.5rem; border-radius: 12px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <div style="display: flex; gap: 1.5rem; align-items: center;">
                    <div style="width: 50px; height: 50px; background: #f0fdf4; color: #16a34a; display: flex; align-items: center; justify-content: center; border-radius: 10px; font-size: 1.5rem;">
                        <i class="fas fa-utensils"></i>
                    </div>
                    <div>
                        <h4 style="margin: 0; font-size: 1.1rem;"><%= r.getFoodName() %></h4>
                        <p style="margin: 4px 0 0; color: #6b7280; font-size: 0.9rem;">From: <strong><%= r.getDonorName() %></strong></p>
                        <p style="margin: 2px 0 0; color: #9ca3af; font-size: 0.8rem;"><%= r.getDonorAddress() %></p>
                    </div>
                </div>
                <div style="text-align: right;">
                    <span class="badge" style="background: <%= r.getStatus().equals("completed") ? "#d1fae5" : "#fef3c7" %>; color: <%= r.getStatus().equals("completed") ? "#065f46" : "#92400e" %>; padding: 6px 16px; border-radius: 9999px; font-size: 0.85rem; font-weight: 600;">
                        <%= r.getStatus().toUpperCase() %>
                    </span>
                    <p style="margin: 8px 0 0; color: #6b7280; font-size: 0.8rem;">Requested: <%= r.getPickupTime() %></p>

                    <% if ("completed".equals(r.getStatus())) { %>
                    <div style="margin-top: 15px;">
                        <form action="/organization/my-requests" method="post" style="display: flex; flex-direction: column; gap: 8px; align-items: flex-end;">
                            <input type="hidden" name="action" value="rateDonor"/>
                            <input type="hidden" name="pickupId" value="<%= r.getPickupId() %>"/>
                            <div style="display: flex; gap: 5px;">
                                <select name="rating" required style="padding: 4px; border-radius: 4px; border: 1px solid #d1d5db;">
                                    <option value="5">5 Stars</option>
                                    <option value="4">4 Stars</option>
                                    <option value="3">3 Stars</option>
                                    <option value="2">2 Stars</option>
                                    <option value="1">1 Star</option>
                                </select>
                                <button type="submit" class="btn-sm" style="background: #6366f1; color: white; border: none; padding: 4px 10px; border-radius: 4px; cursor: pointer;">Rate</button>
                            </div>
                            <input type="text" name="comment" placeholder="Optional comment" style="width: 150px; padding: 4px; border: 1px solid #d1d5db; border-radius: 4px; font-size: 0.8rem;">
                        </form>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } } else { %>
            <div class="empty-state" style="text-align: center; padding: 4rem; background: white; border-radius: 12px;">
                <div style="font-size: 3rem; margin-bottom: 1rem; color: var(--gray-300);"><i class="fas fa-clipboard-list"></i></div>
                <p style="color: #6b7280;">You haven't made any pickup requests yet.</p>
                <a href="/organization/browse" class="btn-primary" style="display: inline-block; margin-top: 1rem;">Browse Listings</a>
            </div>
            <% } %>
        </div>
    </main>
</div>
</body>
</html>