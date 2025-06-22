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

if (isset($_GET['selectedOption'])) {
    $selectedOption = $_GET['selectedOption'];
    // echo "<p>You selected: $selectedOption</p>";
} else {
    echo "<p>No option selected.</p>";
}

// SQL query to fetch the data using prepared statements
$sql = "SELECT results.student_id, students.user_name, results.score, results.pass
        FROM results
        JOIN students ON results.student_id = students.student_id
        WHERE results.course_id = ?";

// Prepare the statement
$stmt = $mysqli->prepare($sql);

if ($stmt) {
    // Bind the parameter
    $stmt->bind_param("s", $selectedOption);

    // Execute the statement
    $stmt->execute();

    // Get the result
    $result = $stmt->get_result();

    // Check if there are any rows returned
    if ($result->num_rows > 0) {
        echo '<table border="1">';
        echo '<tr><th>Student ID</th><th>User Name</th><th>Score</th><th>Pass</th></tr>';

        // Output data of each row
        while ($row = $result->fetch_assoc()) {
            $pass = ($row['pass'] === 1) ? 'passed' : 'failed';

            echo "<tr class='" . $pass . "'>";
            echo "<td>" . $row['student_id'] . "</td>";
            echo "<td>" . $row['user_name'] . "</td>";
            echo "<td>" . $row['score'] . "</td>";
            echo "<td>" . $pass . "</td>";
            echo "</tr>";
        }

        echo '</table>';
    } else {
        echo 'No records found.';
    }

    // Close the statement
    $stmt->close();
} else {
    echo 'Error in preparing the statement.';
}

// Close the database connection
$mysqli->close();
?>
