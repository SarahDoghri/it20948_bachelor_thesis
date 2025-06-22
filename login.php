<?php
// Enable error reporting for debugging (disable in production)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Set JSON response header
header('Content-Type: application/json');

// Start or resume the session
session_start();

// Only accept POST requests
if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    http_response_code(405); // Method Not Allowed
    echo json_encode(["success" => false, "message" => "Μη έγκυρη μέθοδος αιτήματος."]);
    exit();
}

// Validate and sanitize inputs
$username = isset($_POST["username"]) ? trim($_POST["username"]) : '';
$password = isset($_POST["password"]) ? $_POST["password"] : '';
$adminStatus = isset($_POST["admin"]) ? $_POST["admin"] : 'false';

// Simple hardcoded credentials (for demonstration only)
$validUser = "sdoghri";
$validPass = "pwd";

// If admin flag is true, override valid credentials
if ($adminStatus === "true") {
    $validUser = "Admin";
    $validPass = "pwd";
}

// Authenticate user
if ($username === $validUser && $password === $validPass) {
    // Set session variable to store user info
    $_SESSION["username"] = $username;

    // Optionally, set other session variables like role, login time, etc.

    // Debug log
    error_log("User logged in: " . $_SESSION["username"]);

    // Return success response
    echo json_encode([
        "success" => true,
        "message" => "Η είσοδος πραγματοποιήθηκε με επιτυχία."
    ]);
    exit();
} else {
    // Invalid credentials
    echo json_encode([
        "success" => false,
        "message" => "Μη έγκυρο όνομα χρήστη ή κωδικός πρόσβασης."
    ]);
    exit();
}
?>
