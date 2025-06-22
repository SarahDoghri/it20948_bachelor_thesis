<?php

file_put_contents('process_debug.log', $json_data);

header('Content-Type: application/json; charset=utf-8');

// Database connection
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'test';
$conn = new mysqli($host, $username, $password, $database);
if ($conn->connect_error) {
    die(json_encode(["success" => false, "message" => "Connection failed: " . $conn->connect_error]));
}

// Read JSON input
$json_data = file_get_contents("php://input");
$data = json_decode($json_data, true);

if (!$data || !isset($data['studentId'], $data['courseId'], $data['percent'])) {
    echo json_encode(["success" => false, "message" => "Missing required fields."]);
    exit;
}

$student_id = intval($data['studentId']);
$course_id = $conn->real_escape_string($data['courseId']);
$percent = intval($data['percent']);
$pass = ($percent >= 60) ? 1 : 0;

// Insert or update the results in the 'results' table
$sql = "INSERT INTO results (student_id, course_id, score, pass)
        VALUES (?, ?, ?, ?)
        ON DUPLICATE KEY UPDATE score = VALUES(score), pass = VALUES(pass)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("isii", $student_id, $course_id, $percent, $pass);

if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "Results stored for student ID: $student_id, course ID: $course_id"]);
} else {
    echo json_encode(["success" => false, "message" => "Error storing results: " . $stmt->error]);
}
$stmt->close();
$conn->close();
?>
