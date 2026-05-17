<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.organization.model.Organization" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Organization Profile - EcoChain</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<div class="dash-layout">
    <aside class="sidebar">
        <div class="sidebar-logo"><i class="fas fa-leaf"></i><span>EcoChain</span></div>
        <nav>
            <a href="${pageContext.request.contextPath}/organization/dashboard"><i class="fas fa-chart-line"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/organization/browse"><i class="fas fa-search"></i> Browse Listings</a>
            <a href="${pageContext.request.contextPath}/organization/my-requests"><i class="fas fa-tasks"></i> My Requests</a>
        </nav>
        <div class="sidebar-footer"><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></div>
    </aside>

    <main class="dash-main">
        <div class="dash-header">
            <div>
                <h1>Profile Settings</h1>
                <p class="sub">Manage your organization details and security</p>
            </div>
            <a href="${pageContext.request.contextPath}/organization/profile" class="user-avatar active" title="Profile Settings"><i class="fas fa-user"></i></a>
        </div>

        <% if (request.getAttribute("success") != null) { %>
        <div class="alert alert-success" style="background: #f0fdf4; color: #16a34a; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid #bbf7d0;">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-error" style="background: #fef2f2; color: #dc2626; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid #fecaca;">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 24px;">
            <div class="card" style="background: white; padding: 2rem; border-radius: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin-bottom: 1.5rem; color: #1e293b; display: flex; align-items: center; gap: 10px;"><i class="fas fa-building"></i> Organization Details</h3>
                <form action="${pageContext.request.contextPath}/organization/profile" method="post">
                    <input type="hidden" name="action" value="updateProfile"/>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                        <div class="form-group">
                            <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Contact Person</label>
                            <input type="text" name="fullName" value="${sessionScope.user.fullName}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                        </div>
                        <div class="form-group">
                            <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Contact Email</label>
                            <input type="email" name="email" value="${sessionScope.user.email}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                        </div>
                    </div>

                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Organization Name</label>
                        <input type="text" name="orgName" value="${org.orgName}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Office Address</label>
                        <input type="text" name="address" value="${org.address}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1rem;">
                        <div class="form-group">
                            <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Phone Number</label>
                            <input type="text" name="phone" value="${org.phone}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                        </div>
                        <div class="form-group">
                            <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Area of Service</label>
                            <input type="text" name="areaOfService" value="${org.areaOfService}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                        </div>
                    </div>
                    <div class="form-group" style="margin-bottom: 2rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Registration Number</label>
                        <input type="text" name="regCertificate" value="${org.regCertificate}" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                    </div>

                    <button type="submit" class="btn-primary" style="width: 100%; padding: 12px; border-radius: 8px; font-weight: 600;">Update Profile</button>
                </form>
            </div>

            <div class="card" style="background: white; padding: 2rem; border-radius: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                <h3 style="margin-bottom: 1.5rem; color: #1e293b; display: flex; align-items: center; gap: 10px;"><i class="fas fa-lock"></i> Security</h3>
                <form action="${pageContext.request.contextPath}/organization/profile" method="post">
                    <input type="hidden" name="action" value="changePassword"/>
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Current Password</label>
                        <input type="password" name="currentPassword" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">New Password</label>
                        <input type="password" name="newPassword" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    <div class="form-group" style="margin-bottom: 2rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #64748b;">Confirm New Password</label>
                        <input type="password" name="confirmPassword" required style="width: 100%; padding: 10px; border: 1px solid #e2e8f0; border-radius: 8px;">
                    </div>
                    <button type="submit" class="btn-primary" style="width: 100%; padding: 12px; border-radius: 8px; font-weight: 600;">Change Password</button>
                </form>
            </div>
        </div>
    </main>
</div>
</body>
</html>