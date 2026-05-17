<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content="EcoChain - Reducing food waste by connecting donors with community organizations. Join us to make an impact."/>
    <title>EcoChain - Reducing Food Waste, Feeding Communities</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css"/>
</head>
<body>
<jsp:include page="/components/header.jsp"><jsp:param name="page" value="home"/></jsp:include>

<!-- Hero Section -->
<section class="hero" id="hero-section" style="background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('${pageContext.request.contextPath}/assets/images/hero.jpg'); background-size: cover; background-position: center; padding: 120px 24px;">
    <h1>Reducing Food Waste,<br/>Feeding Communities</h1>
    <p>EcoChain connects surplus food from restaurants and stores with shelters and food banks who need it most.</p>
    <div class="hero-actions">
        <a href="${pageContext.request.contextPath}/register" class="btn-hero btn-hero-white">Get Started</a>
        <a href="${pageContext.request.contextPath}/about" class="btn-hero btn-hero-outline">Learn More</a>
    </div>
</section>

<!-- Feature Dots -->
<div class="feature-dots">
    <span class="dot active"></span>
    <span class="dot"></span>
    <span class="dot"></span>
    <span class="dot"></span>
</div>

<!-- Section 1: Donors -->
<section class="alt-section" id="donors-section">
    <div class="alt-section-img">
        <img src="${pageContext.request.contextPath}/assets/images/donor.png" alt="Restaurant chef packing surplus food for donation"/>
    </div>
    <div class="alt-section-text">
        <h2>For Food Donors</h2>
        <p>Whether you run a restaurant, bakery, or grocery store, EcoChain makes it easy to post your surplus food and connect with organizations that can put it to good use.</p>
        <p>Reduce waste, get tax benefits, and build a reputation as a socially responsible business &mdash; all through one simple platform.</p>
    </div>
</section>

<!-- Section 2: Organizations -->
<div class="section-gray">
    <section class="alt-section reverse" id="organizations-section">
        <div class="alt-section-img">
            <img src="${pageContext.request.contextPath}/assets/images/organization.png" alt="Community shelter receiving food donations"/>
        </div>
        <div class="alt-section-text">
            <h2>For Community Organizations</h2>
            <p>Shelters, food banks, and NGOs can browse available food donations in real time, request pickups, and track deliveries &mdash; all in one place.</p>
            <p>No more phone calls or guesswork. EcoChain streamlines the entire process so you can focus on serving your community.</p>
        </div>
    </section>
</div>

<!-- Section 3: Impact -->
<section class="alt-section" id="impact-section">
    <div class="alt-section-img">
        <img src="${pageContext.request.contextPath}/assets/images/impact.png" alt="Sustainable green farmland and city"/>
    </div>
    <div class="alt-section-text">
        <h2>Make a Real Impact</h2>
        <p>Every food donation counts. Track your environmental impact with real-time metrics: meals served, CO&#x2082; emissions reduced, and food waste diverted from landfills.</p>
        <p>Join a growing community of conscious businesses and organizations working together toward a more sustainable food system.</p>
    </div>
</section>

<!-- Section 4: Tracking -->
<div class="section-gray">
    <section class="alt-section reverse" id="tracking-section">
        <div class="alt-section-img">
            <img src="${pageContext.request.contextPath}/assets/images/tracking.png" alt="Analytics dashboard for food donation tracking"/>
        </div>
        <div class="alt-section-text">
            <h2>Smart Tracking &amp; Analytics</h2>
            <p>Our platform provides detailed reports and analytics so donors and organizations can measure their contribution and optimize their operations.</p>
            <p>From pickup coordination to impact reports, EcoChain gives you the tools to make data-driven decisions for greater social impact.</p>
        </div>
    </section>
</div>

<jsp:include page="/components/footer.jsp"/>
</body>
</html>