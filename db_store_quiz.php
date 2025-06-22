<?php
mb_internal_encoding("UTF-8");
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Read the JSON data from the request
$json_data = file_get_contents("php://input");
file_put_contents('json_data.log', $json_data);
error_log("Received JSON data: " . $json_data);

// Decode the JSON data into a PHP object or associative array
$myData = json_decode($json_data);

if (json_last_error() !== JSON_ERROR_NONE) {
    echo "JSON decoding error: " . json_last_error_msg();
} else {
    if (isset($myData->courseId) && isset($myData->studentId)) {
        $course_id = $myData->courseId;
        $student_id = $myData->studentId;
        $quiz_data = $json_data;

        $servername = "localhost";
        $username = "root";
        $password = "";
        $dbname = "test";
        $conn = new mysqli($servername, $username, $password, $dbname);

        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        $sql = "INSERT INTO quizzes (student_id, course_id, date, quiz_data) VALUES (?, ?, NOW(), ?)";
        $stmt = $conn->prepare($sql);
        if (!$stmt) {
            die("Prepare failed: " . $conn->error);
        }
        // Make sure $student_id is int, $course_id and $quiz_data are strings
        $stmt->bind_param("iss", $student_id, $course_id, $quiz_data);

        if ($stmt->execute()) {
            echo "Quiz data inserted successfully.";
        } else {
            echo "Error: " . $stmt->error;
            error_log("SQL Error: " . $stmt->error);
        }

        $stmt->close();
        $conn->close();
    } else {
        echo "Error: 'courseId' or 'studentId' property is missing in JSON data.";
    }
}
?>
