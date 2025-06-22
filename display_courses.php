<?php
// Database connection parameters
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'test';

// Create a database connection
$mysqli = new mysqli($host, $username, $password, $database);

// Check the connection
if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Function to toggle the 'active' column value
function toggleActiveValue($value) {
    return ($value == 1) ? 0 : 1;
}

// Check if a form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    foreach ($_POST["course_ids"] as $courseId) {
        // Check if a course-specific "Edit" button is clicked
        if (isset($_POST["edit_course_$courseId"])) {
            $newActiveValue = toggleActiveValue($_POST["active_$courseId"]);

            // Update the 'active' column in the database for the specific course
            $updateSql = "UPDATE courses SET active = $newActiveValue WHERE course_id = '$courseId'";
            $mysqli->query($updateSql);
        }
    }
    
}


// SQL query to retrieve data from the 'course' table
$sql = "SELECT * FROM courses";
$result = $mysqli->query($sql);

// Check if there are any rows returned
if ($result->num_rows > 0) {
    echo '<form method="post">';
    echo '<table border="1">';
    echo '<tr><th>Row ID</th><th>Course ID</th><th>Course Name</th><th>Exam Period</th><th>Latest Quiz</th><th>User ID</th><th>Active</th><th>Enable/Disable</th></tr>';

    // Output data of each row
    while ($row = $result->fetch_assoc()) {
        $courseId = $row['course_id'];
        $activeValue = $row['active'];
        $activeClass = 'enabled';
        if ($activeValue === "0") {
            $activeClass = 'disabled';
        }

        echo '<tr class="' . $activeClass . '">';
        echo '<td>' . $row['row_id'] . '</td>';
        echo '<td>' . $courseId . '</td>';
        echo '<td>' . $row['course_name'] . '</td>';
        echo '<td>' . $row['exam_period'] . '</td>';
        echo '<td>' . $row['latest_quiz'] . '</td>';
        echo '<td>' . $row['user_id'] . '</td>';
        echo '<td>' . $activeValue . '</td>';
        echo '<td><button type="submit" name="edit_course_' . $courseId . '">Επεξεργασία</button></td>';
        echo '<input type="hidden" name="course_ids[]" value="' . $courseId . '">';
        echo '<input type="hidden" name="active_' . $courseId . '" value="' . $activeValue . '">';
        echo '</tr>';
    }

    echo '</table>';
    echo '</form>';
} else {
    echo 'No records found.';
}

// Close the database connection
$mysqli->close();
?>
