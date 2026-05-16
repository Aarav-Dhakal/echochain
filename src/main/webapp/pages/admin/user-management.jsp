<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.admin.model.Admin" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
    List<Admin> users = (List<Admin>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>User Management - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="/admin/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="/admin/users" class="active"><i class="fas fa-users"></i> Users</a>
            <a href="/admin/categories"><i class="fas fa-folder"></i> Categories</a>
            <a href="/admin/listings"><i class="fas fa-clipboard-list"></i> Listings</a>
            <a href="/admin/impact"><i class="fas fa-chart-bar"></i> Impact Report</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>User Management</h1>
                <p class="sub">Approve, suspend, or remove user accounts</p>
            </div>
            <div class="user-avatar"><i class="fas fa-user-shield"></i></div>
        </div>

        <div class="table-wrap">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                <% if (users != null && !users.isEmpty()) {
                    for (Admin u : users) { %>
                <tr>
                    <td><%= u.getId() %></td>
                    <td><strong><%= u.getFullName() %></strong></td>
                    <td><%= u.getEmail() %></td>
                    <td><%= u.getRole() %></td>
                    <td><span class="badge badge-<%= u.getStatus() %>"><%= u.getStatus() %></span></td>
                    <td style="display:flex;gap:6px;flex-wrap:wrap;">
                        <% if (u.getStatus().equals("pending") || u.getStatus().equals("suspended")) { %>
                        <form action="/admin/users" method="post" style="display:inline">
                            <input type="hidden" name="action" value="approve"/>
                            <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                            <button type="submit" class="btn-sm btn-approve">Approve</button>
                        </form>
                        <% } %>
                        <% if (u.getStatus().equals("active")) { %>
                        <form action="/admin/users" method="post" style="display:inline">
                            <input type="hidden" name="action" value="suspend"/>
                            <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                            <button type="submit" class="btn-sm btn-suspend">Suspend</button>
                        </form>
                        <% } %>
                        <form action="/admin/users" method="post" style="display:inline">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                            <button type="submit" class="btn-sm btn-delete" onclick="return confirm('Delete this user?')">Delete</button>
                        </form>
                    </td>
                </tr>
                <% } } %>
            </table>
        </div>
    </main>
</div>
</body>
</html>