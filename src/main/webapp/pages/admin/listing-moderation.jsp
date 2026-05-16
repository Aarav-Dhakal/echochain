<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.listing.model.Listing" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
    List<Listing> listings = (List<Listing>) request.getAttribute("listings");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Listing Moderation - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="/admin/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="/admin/users"><i class="fas fa-users"></i> Users</a>
            <a href="/admin/categories"><i class="fas fa-folder"></i> Categories</a>
            <a href="/admin/listings" class="active"><i class="fas fa-clipboard-list"></i> Listings</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Listing Moderation</h1>
                <p class="sub">Monitor and remove inappropriate or expired food listings</p>
            </div>
            <div class="user-avatar"><i class="fas fa-user-shield"></i></div>
        </div>

        <div class="table-wrap" style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1);">
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr style="text-align: left; border-bottom: 2px solid #f3f4f6;">
                    <th style="padding: 1rem;">Food Item</th>
                    <th style="padding: 1rem;">Category</th>
                    <th style="padding: 1rem;">Quantity</th>
                    <th style="padding: 1rem;">Expiry</th>
                    <th style="padding: 1rem;">Status</th>
                    <th style="padding: 1rem;">Action</th>
                </tr>
                </thead>
                <tbody>
                <% if (listings != null && !listings.isEmpty()) {
                    for (Listing l : listings) { %>
                <tr style="border-bottom: 1px solid #f3f4f6;">
                    <td style="padding: 1rem; font-weight: 500;"><%= l.getFoodName() %></td>
                    <td style="padding: 1rem;"><%= l.getCategoryName() %></td>
                    <td style="padding: 1rem;"><%= l.getQuantity() %> <%= l.getUnit() %></td>
                    <td style="padding: 1rem;"><%= l.getExpiryDate() %></td>
                    <td style="padding: 1rem;">
                            <span class="badge" style="background: <%= l.getStatus().equals("available") ? "#d1fae5" : "#fef3c7" %>; color: <%= l.getStatus().equals("available") ? "#065f46" : "#92400e" %>; padding: 4px 12px; border-radius: 9999px; font-size: 0.8rem; font-weight: 600;">
                                <%= l.getStatus().toUpperCase() %>
                            </span>
                    </td>
                    <td style="padding: 1rem;">
                        <form action="/admin/listings" method="post">
                            <input type="hidden" name="action" value="deleteListing"/>
                            <input type="hidden" name="listingId" value="<%= l.getId() %>"/>
                            <button type="submit" class="btn-sm" style="background: #ef4444; color: white; border: none; padding: 6px 12px; border-radius: 6px; cursor: pointer;" onclick="return confirm('Delete this listing permanently?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="6" style="padding: 3rem; text-align: center; color: #6b7280;">No listings found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>
