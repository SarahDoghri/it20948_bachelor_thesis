// Wait until the DOM content is fully loaded before running the script
document.addEventListener("DOMContentLoaded", function() {
    // Attach a submit event listener to the form with id "loginForm"
    document.getElementById("loginForm").addEventListener("submit", function(event) {
        event.preventDefault(); // Prevent the default form submission behavior
        
        // Get the trimmed username value from the input field
        const username = document.getElementById("username").value.trim();
        // Get the password value from the input field
        const password = document.getElementById("password").value;
        // Determine if the user is admin by checking if username equals "admin" (case-insensitive)
        const adminStatus = (username.toLowerCase() === "admin") ? "true" : "false";
        
        // Create a new XMLHttpRequest object for AJAX
        // Perform AJAX request to login.php
        const xhr = new XMLHttpRequest();
        // Initialize a POST request to "login.php"
        xhr.open("POST", "login.php", true);
        // Set the request header to send form data in URL-encoded format
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        
        // Define a callback function to handle the response when readyState changes
        xhr.onreadystatechange = function() {
            // Check if the request is complete
            if (xhr.readyState === XMLHttpRequest.DONE) {
                // Check if the HTTP status code is 200 (OK)
                if (xhr.status === 200) {
                    // Parse the JSON response from the server
                    const response = JSON.parse(xhr.responseText);
                    // console.log(response); // Log the response for debugging
                    
                    // Get the element to display messages to the user
                    const messageEl = document.getElementById("message");
                    // Set the text content to the message from the server response
                    messageEl.textContent = response.message;
                    // Remove any existing 'error' or 'success' classes
                    messageEl.classList.remove('error', 'success');
                    
                    // Add 'error' class if login failed, 'success' if login succeeded
                    if (!response.success) {
                        messageEl.classList.add('error');
                    } else {
                        messageEl.classList.add('success');
                    }
                    
                    // If login was successful, redirect after a short delay
                    if (response.success) {
                        setTimeout(() => {
                            // Redirect admins to admin.phtml with username as query parameter
                            if (adminStatus === "true") {
                                window.location.href = `admin.phtml?username=${encodeURIComponent(username)}`;
                            } else {
                                // Redirect regular users to loggedin.phtml with username as query parameter
                                window.location.href = `loggedin.phtml?username=${encodeURIComponent(username)}`;
                            }
                        }, 500); // 500ms delay for user to see the message
                    }
                } else {
                    // Log an error if the request failed
                    console.error("Login request failed.");
                }
            }
        };
        
        // Prepare the URL-encoded data string to send in the POST request
        const data = "username=" + encodeURIComponent(username) + 
                     "&password=" + encodeURIComponent(password) + 
                     "&admin=" + encodeURIComponent(adminStatus);
        // Send the AJAX request with the login data
        // console.log("Sending login request with:", username, password, adminStatus);
        xhr.send(data);
    });
});
