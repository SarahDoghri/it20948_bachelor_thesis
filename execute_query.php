<?php
header('Content-Type: application/json; charset=utf-8');

// Database connection parameters
$servername = "localhost";
$username = "root";
$password = ""; // Default XAMPP root password is empty
$dbname = "test";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Connection failed: " . $conn->connect_error
    ]);
    exit();
}

// Set UTF-8 encoding for the connection
$conn->set_charset('utf8');

// Get 'selectedOption' from URL query string
$selectedOption = '';
if (isset($_GET['selectedOption'])) {
    $selectedOption = trim($_GET['selectedOption']);
}

if (empty($selectedOption)) {
    http_response_code(400);
    echo json_encode([
        "success" => false,
        "message" => "Missing or empty selectedOption parameter."
    ]);
    $conn->close();
    exit();
}

// Sanitize selectedOption for SQL
$selectedOptionEscaped = $conn->real_escape_string($selectedOption);

// Query courses table to get latest_quiz for the given course_id
$sqlCourse = "SELECT latest_quiz FROM courses WHERE course_id = '$selectedOptionEscaped' LIMIT 1";
$resultCourse = $conn->query($sqlCourse);

if (!$resultCourse) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Error querying courses table: " . $conn->error
    ]);
    $conn->close();
    exit();
}

if ($resultCourse->num_rows === 0) {
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "No course found for course_id: $selectedOptionEscaped"
    ]);
    $conn->close();
    exit();
}

$rowCourse = $resultCourse->fetch_assoc();
$v_id = $rowCourse['latest_quiz'];

if (empty($v_id)) {
    http_response_code(404);
    echo json_encode([
        "success" => false,
        "message" => "No latest quiz found for course_id: $selectedOptionEscaped"
    ]);
    $conn->close();
    exit();
}

// Fetch all question IDs for this version (v_id)
// Quote $v_id assuming it is string; remove quotes if integer
$sql = "SELECT question_id FROM questions WHERE v_id = '$v_id'";
$result = $conn->query($sql);

if ($result === false) {
    http_response_code(500);
    echo json_encode([
        "success" => false,
        "message" => "Error executing query: " . $conn->error
    ]);
    $conn->close();
    exit();
}

$qIds = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $qIds[] = $row["question_id"];
    }
} else {
    // No questions found for this v_id
    echo json_encode([
        "success" => false,
        "message" => "No questions found for the quiz version."
    ]);
    $conn->close();
    exit();
}

shuffle($qIds);
$qIds = array_slice($qIds, 0, 5); // limit to 5 questions

$quizTotalScore = 0;
$obj = [];

foreach ($qIds as $el) {
    // Fetch question info including the JSON choices
    $sql = "SELECT question_id, question_text, question_weight, question_choices 
            FROM questions 
            WHERE v_id = '$v_id' AND question_id = '$el'";

    $result = $conn->query($sql);

    if ($result && $result->num_rows > 0) {
        $row = $result->fetch_assoc();

        $quizTotalScore += $row["question_weight"];

        $obj[$el]["text"] = $row["question_text"];
        $obj[$el]["weight"] = $row["question_weight"];

        // Decode the JSON choices
        $choicesArray = json_decode($row["question_choices"], true);

        // Prepare choices indexed by their id
        $obj[$el]["choices"] = [];
        if (is_array($choicesArray)) {
            foreach ($choicesArray as $choice) {
                $choiceId = $choice['id'];
                $obj[$el]["choices"][$choiceId] = [
                    "id" => $choiceId,
                    "text" => $choice['text'],
                    "score" => $choice['score'],
                    "status" => $choice['status']
                ];
            }
        }
    }
}

// Prepare final data structure
$data = [
    "success" => true,
    "totalScore" => $quizTotalScore,
    "questions" => $obj
];

// Close the database connection
$conn->close();

// Return data as JSON
echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
?>
