<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>About Us - EcoChain</title>
</head>
<body>
<jsp:include page="/components/header.jsp"><jsp:param name="page" value="about"/></jsp:include>

<main style="max-width: 800px; margin: 4rem auto; padding: 0 2rem;">
    <h1 style="font-size: 3rem; color: #1e293b; margin-bottom: 1.5rem;">Our Mission</h1>
    <p style="font-size: 1.25rem; color: #64748b; line-height: 1.8; margin-bottom: 3rem;">
        EcoChain was born from a simple realization: while millions go hungry, billions of pounds of perfectly edible food are wasted every year. Our platform bridges this gap by connecting food-surplus businesses with the community groups that need them most.
    </p>

    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 4rem;">
        <div style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);">
            <div style="font-size: 2rem; margin-bottom: 1rem; color: #10b981;"><i class="fas fa-seedling"></i></div>
            <h3 style="margin-bottom: 0.5rem; color: #1e293b;">Sustainability</h3>
            <p style="color: #64748b;">Reducing landfill waste and lowering CO2 emissions by ensuring food is consumed, not discarded.</p>
        </div>
        <div style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);">
            <div style="font-size: 2rem; margin-bottom: 1rem; color: #10b981;"><i class="fas fa-users"></i></div>
            <h3 style="margin-bottom: 0.5rem; color: #1e293b;">Community</h3>
            <p style="color: #64748b;">Empowering local shelters, food banks, and NGOs with a reliable stream of high-quality donations.</p>
        </div>
    </div>

    <section>
        <h2 style="color: #1e293b; margin-bottom: 1rem;">Why It Matters</h2>
        <p style="color: #64748b; line-height: 1.6; margin-bottom: 1.5rem;">
            Food waste is not just a social problem; it's an environmental crisis. When food rots in a landfill, it produces methane—a greenhouse gas even more potent than CO2. By facilitating rapid redistribution, EcoChain turns a liability into a vital community asset.
        </p>
    </section>
</main>

<jsp:include page="/components/footer.jsp"/>
</body>
</html>