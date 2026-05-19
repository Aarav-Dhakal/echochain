<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.listing.model.Listing" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("donor")) {
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
    <title>My Listings - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/donor/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/listing/add"><i class="fas fa-plus-circle"></i> Add Listing</a>
            <a href="${pageContext.request.contextPath}/listing/my-listings" class="active"><i class="fas fa-list"></i> My Listings</a>
            <a href="${pageContext.request.contextPath}/donor/pickup-requests"><i class="fas fa-truck"></i> Pickup Requests</a>
            <a href="${pageContext.request.contextPath}/donor/history"><i class="fas fa-history"></i> History</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>My Food Listings</h1>
                <p class="sub">Manage your posted food items</p>
            </div>
            <div style="display: flex; align-items: center; gap: 16px;">
                <a href="/listing/add" class="btn-primary" style="padding:10px 22px;">+ Add Listing</a>
                <a href="/donor/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user-circle"></i></a>
            </div>
        </div>

        <div class="table-wrap">
            <table>
                <tr>
                    <th>Food Name</th>
                    <th>Category</th>
                    <th>Quantity</th>
                    <th>Expiry Date</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                <% if (listings != null && !listings.isEmpty()) {
                    for (Listing l : listings) { %>
                <tr>
                    <td><strong><%= l.getFoodName() %></strong></td>
                    <td><%= l.getCategoryName() %></td>
                    <td><%= l.getQuantity() %> <%= l.getUnit() %></td>
                    <td><%= l.getExpiryDate() %></td>
                    <td><span class="badge badge-<%= l.getStatus() %>"><%= l.getStatus() %></span></td>
                    <td>
                        <% if (l.getStatus().equals("available")) { %>
                        <form action="/listing/my-listings" method="post" style="display:inline">
                            <input type="hidden" name="action" value="deleteListing"/>
                            <input type="hidden" name="listingId" value="<%= l.getId() %>"/>
                            <button type="submit" class="btn-sm btn-delete" onclick="return confirm('Delete this listing?')">Delete</button>
                        </form>
                        <% } %>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="6">
                        <div class="empty-state">
                            <div class="empty-icon"><i class="fas fa-box-open" style="color: var(--gray-300);"></i></div>
                            <p>No listings found. <a href="/listing/add" style="color:#2e7d32;font-weight:600;">Add your first listing</a></p>
                        </div>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </main>
</div>
</body>
</html>