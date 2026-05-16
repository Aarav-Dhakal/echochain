<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
    List<String> categories = (List<String>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Category Management - EcoChain</title>
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
            <a href="/admin/categories" class="active"><i class="fas fa-folder"></i> Categories</a>
            <a href="/admin/listings"><i class="fas fa-clipboard-list"></i> Listings</a>
            <a href="/admin/impact"><i class="fas fa-chart-bar"></i> Impact Report</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Category Management</h1>
                <p class="sub">Manage food categories for listings</p>
            </div>
            <div class="user-avatar"><i class="fas fa-user-shield"></i></div>
        </div>

        <!-- Add Category Form -->
        <div class="form-card" style="margin-bottom:28px;max-width:600px;">
            <form action="/admin/categories" method="post" style="display:flex;gap:12px;align-items:flex-end;">
                <input type="hidden" name="action" value="addCategory"/>
                <div class="form-group" style="flex:1;margin-bottom:0;">
                    <label for="catName">New Category</label>
                    <input type="text" id="catName" name="name" placeholder="Enter category name" required/>
                </div>
                <button type="submit" class="btn-submit" style="height:42px;">Add Category</button>
            </form>
        </div>

        <div class="table-wrap">
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Action</th>
                </tr>
                <% if (categories != null && !categories.isEmpty()) {
                    for (String cat : categories) {
                        String[] parts = cat.split(":");
                        int id = Integer.parseInt(parts[0]);
                        String name = parts[1];
                %>
                <tr>
                    <td><%= id %></td>
                    <td><strong><%= name %></strong></td>
                    <td>
                        <form action="/admin/categories" method="post" style="display:inline">
                            <input type="hidden" name="action" value="deleteCategory"/>
                            <input type="hidden" name="categoryId" value="<%= id %>"/>
                            <button type="submit" class="btn-sm btn-delete" onclick="return confirm('Delete?')">Delete</button>
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