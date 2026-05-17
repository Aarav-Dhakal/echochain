<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Contact Us - EcoChain</title>
</head>
<body>
<jsp:include page="/components/header.jsp"><jsp:param name="page" value="contact"/></jsp:include>

<main style="max-width: 1000px; margin: 4rem auto; padding: 0 2rem; display: grid; grid-template-columns: 1fr 1.5fr; gap: 4rem;">
    <div>
        <h1 style="font-size: 2.5rem; color: #1e293b; margin-bottom: 1rem;">Get in touch</h1>
        <p style="color: #64748b; margin-bottom: 2.5rem;">Have questions about how to join as a donor or an organization? Our team is here to help.</p>

        <div style="display: flex; flex-direction: column; gap: 2rem;">
            <div style="display: flex; gap: 1.5rem; align-items: center;">
                <div style="width: 48px; height: 48px; background: white; display: flex; align-items: center; justify-content: center; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); font-size: 1.5rem; color: #10b981;"><i class="fas fa-envelope"></i></div>
                <div>
                    <h4 style="margin: 0; color: #1e293b;">Email</h4>
                    <p style="margin: 0; color: #64748b;">support@ecochain.com</p>
                </div>
            </div>
            <div style="display: flex; gap: 1.5rem; align-items: center;">
                <div style="width: 48px; height: 48px; background: white; display: flex; align-items: center; justify-content: center; border-radius: 12px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); font-size: 1.5rem; color: #10b981;"><i class="fas fa-phone"></i></div>
                <div>
                    <h4 style="margin: 0; color: #1e293b;">Phone</h4>
                    <p style="margin: 0; color: #64748b;">+1 (555) 000-0000</p>
                </div>
            </div>
        </div>
    </div>

    <div style="background: white; padding: 3rem; border-radius: 20px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1);">
        <form style="display: flex; flex-direction: column; gap: 1.5rem;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div>
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #475569;">First Name</label>
                    <input type="text" style="width: 100%; padding: 0.75rem; border: 1px solid #e2e8f0; border-radius: 8px;">
                </div>
                <div>
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #475569;">Last Name</label>
                    <input type="text" style="width: 100%; padding: 0.75rem; border: 1px solid #e2e8f0; border-radius: 8px;">
                </div>
            </div>
            <div>
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #475569;">Email Address</label>
                <input type="email" style="width: 100%; padding: 0.75rem; border: 1px solid #e2e8f0; border-radius: 8px;">
            </div>
            <div>
                <label style="display: block; margin-bottom: 0.5rem; font-weight: 500; color: #475569;">Message</label>
                <textarea rows="4" style="width: 100%; padding: 0.75rem; border: 1px solid #e2e8f0; border-radius: 8px;"></textarea>
            </div>
            <button type="button" class="btn-primary" style="padding: 1rem; font-size: 1rem;">Send Message</button>
        </form>
    </div>
</main>

<jsp:include page="/components/footer.jsp"/>
</body>
</html>