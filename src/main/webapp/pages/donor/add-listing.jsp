<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("donor")) {
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
    <title>Add Listing - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf" style="color: var(--primary); font-size: 20px;"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/donor/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/listing/add" class="active"><i class="fas fa-plus-circle"></i> Add Listing</a>
            <a href="${pageContext.request.contextPath}/listing/my-listings"><i class="fas fa-list"></i> My Listings</a>
            <a href="${pageContext.request.contextPath}/donor/pickup-requests"><i class="fas fa-truck"></i> Pickup Requests</a>
            <a href="${pageContext.request.contextPath}/donor/history"><i class="fas fa-history"></i> History</a>
        </nav>
        <div class="sidebar-footer"><a href="/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Add New Food Listing</h1>
                <p class="sub">Post surplus food for donation</p>
            </div>
            <a href="/donor/profile" class="user-avatar" title="Profile Settings"><i class="fas fa-user-circle"></i></a>
        </div>

        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error"><%= request.getAttribute("error") %></div>
        <% } %>

        <div class="form-card" style="max-width:700px;">
            <form action="/listing/add" method="post">
                <input type="hidden" name="action" value="addListing"/>

                <div class="form-group">
                    <label for="foodName">Food Name</label>
                    <input type="text" id="foodName" name="foodName" placeholder="e.g., Fresh Bread" required/>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="categoryId">Category</label>
                        <select id="categoryId" name="categoryId" required>
                            <option value="">-- Select Category --</option>
                            <% if (categories != null) {
                                for (String cat : categories) {
                                    String[] parts = cat.split(":");
                                    int id = Integer.parseInt(parts[0]);
                                    String name = parts[1];
                            %>
                            <option value="<%= id %>"><%= name %></option>
                            <% } } %>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="number" step="0.01" id="quantity" name="quantity" placeholder="e.g., 10" required/>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="unit">Unit</label>
                        <input type="text" id="unit" name="unit" placeholder="e.g., kg, pieces" required/>
                    </div>
                    <div class="form-group">
                        <label for="expiryDate">Expiry Date</label>
                        <input type="date" id="expiryDate" name="expiryDate" required/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="storageNotes">Storage Notes</label>
                    <textarea id="storageNotes" name="storageNotes" placeholder="e.g., Keep refrigerated"></textarea>
                </div>

                <div class="form-group">
                    <label for="allergens">Allergens</label>
                    <input type="text" id="allergens" name="allergens" placeholder="e.g., Nuts, Dairy"/>
                </div>

                <div class="form-actions">
                    <a href="/donor/dashboard" class="btn-cancel">Cancel</a>
                    <button type="submit" class="btn-submit">Add Listing</button>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>