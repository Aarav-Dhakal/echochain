<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
<header class="navbar" id="main-header">
    <a href="${pageContext.request.contextPath}/" class="logo">
        <i class="fas fa-leaf"></i>
        EcoChain
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/" class="${param.page == 'home' ? 'active' : ''}">Home</a>
        <a href="${pageContext.request.contextPath}/about" class="${param.page == 'about' ? 'active' : ''}">About</a>
        <a href="${pageContext.request.contextPath}/contact" class="${param.page == 'contact' ? 'active' : ''}">Contact</a>
    </div>
    <div class="nav-actions">
        <a href="${pageContext.request.contextPath}/login" class="btn-outline">Login</a>
        <a href="${pageContext.request.contextPath}/register" class="btn-primary">Signup</a>
    </div>
</header>