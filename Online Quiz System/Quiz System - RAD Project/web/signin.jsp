<!DOCTYPE html>
<html>
    <head>
        <title>Sign In</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;

                background-size: cover;
                height: 100vh; 
                display: flex; 
                justify-content: center;
                align-items: center; 
                overflow: hidden;
            }

            header {
                display: flex;
                align-items: center;
                background-color: #333;
                height: 70px;
                padding: 0 20px;
            }

            header img {
                height: 50px;
                margin-right: 5px; 
            }

            h1 {
                font-size: 30px; 
                padding: 15px;
                margin-top: 10px; 
            }

            .row {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
            }

            .welcome-text {
                color: #0047AB; 
                font-size: 40px;
                font-weight: bold;
                margin-right: 10px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); 
                letter-spacing: 1px; 
            }

            .scholars-hub-text {
                color: #0047AB; 
                font-size: 30px;
                font-weight: bold;
                padding-bottom: 20px;
            }

            .outer-container {
                border: 2px solid transparent; 
                border-radius: 10px; 
                padding: 20px; 
                max-width: 900px; 
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
            }

            .container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                background-color: #f9f9f9;
                border-radius: 10px; 
            }

            .signin-box {
                flex: 1; 
                display: flex;
                flex-direction: column;
                padding: 20px; 
                background-color: #fff; 
                border-radius: 10px; 
                margin-top: 20px; 
                margin-left: 20px; 
                max-width: 400px; 
            }

            input[type="text"], input[type="password"] {
                padding: 15px;
                margin: 10px;
                font-size: 20px;
                border: 1px solid #ccc; 
                border-radius: 5px; 
            }

            .btn {
                display: inline-block;
                padding: 15px 30px; 
                background-color: #4CAF50;
                color: #fff;
                border: none;
                cursor: pointer;
                text-decoration: none;
                margin: 10px;
                font-size: 20px;
                border-radius: 5px; 
            }

            .btn:hover {
                background-color: #45a049;
            }

            input[type="radio"] {
                color: #000; 
            }

            p {
                margin-top: 20px;
            }

            p a {
                display: inline-block;
                padding: 10px 20px;
                color: #0047AB;
                text-decoration: none;
                border-radius: 5px; 
                font-weight: bold;
                transition: background-color 0.3s; 
            }

            p a:hover {
                background-color: #f0f0f0;
            }

            .image-container {
                flex: 1; 
                position: relative;
                max-width: 1500px; 
            }

            .image-container img {
                max-width: 100%;
                max-height: 100%;
            }
        </style>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const urlParams = new URLSearchParams(window.location.search);
                const errorMessage = urlParams.get('error');
                if (errorMessage) {
                    document.getElementById("error-message").innerText = errorMessage;
                }
            });
        </script>
    </head>
    <body>

        <div class="outer-container">
            <div class="container">
                <div class="image-container">
                    <img src="ImagesFolder/signInImage.jpg" alt="Image">
                </div>

                <div class="signin-box">
                    <div class="row">
                        <div class="welcome-text">Welcome to</div>
                        <div class="scholars-hub-text">Scholars' Hub</div>
                    </div>
                    <div id="error-message" style="color: red;"></div>
                    <form method="post" action="login">
                        <input type="radio" name="role" value="student" checked> <span style="color: #000;">Student</span>
                        <input type="radio" name="role" value="teacher"> <span style="color: #000;">Teacher</span>
                        <br><br>
                        <input type="text" name="username" placeholder="Username" required>
                        <br>
                        <input type="password" name="password" placeholder="Password" required>
                        <br><br>
                        <input type="submit" value="Sign In" class="btn">
                    </form>

                    <p><span style="color: #000;">Cannot Log In?</span> <a href="contactUs.html" class="contact-link">Contact Us</a></p>
                </div>
            </div>
        </div>
    </body>
</html>
