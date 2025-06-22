<?php
// Check if the form was submitted
if (isset($_POST["submit"])) {
    $targetDirectory = "uploads/students/"; // Specify the directory where files will be uploaded
    $targetFile = $targetDirectory . basename($_FILES["fileToUpload"]["name"]);
    $uploadOk = 1;
    $fileType = strtolower(pathinfo($targetFile, PATHINFO_EXTENSION));

    // Check if the file is a text file
    if ($fileType != "txt") {
        echo "Επιτρέπονται μόνο αρχεία TXT.";
        $uploadOk = 0;
    }

    // Check if the file was uploaded successfully
    if ($uploadOk == 1) {
        if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $targetFile)) {
            // File uploaded successfully, now insert into database
            $db = new mysqli("localhost", "root", "", "test");

            if ($db->connect_error) {
                die("Connection failed: " . $db->connect_error);
            }

            // Retrieve the selected course option from the form
            $selectedOption = $_POST['selectedOption'];

            $fileName = $_FILES["fileToUpload"]["name"];
            $fileContent = file_get_contents($targetFile);

            $sql = "INSERT INTO text_files (course_id, file_name, file_content) VALUES (?, ?, ?)";
            $stmt = $db->prepare($sql);
            $stmt->bind_param("sss", $selectedOption, $fileName, $fileContent);

            if ($stmt->execute()) {
                echo "File '$selectedOption $fileName' uploaded and stored in the database.";
            } else {
                echo "Error: " . $sql . "<br>" . $db->error;
            }

            $stmt->close();
            $db->close();
        } else {
            echo "Σφάλμα κατά τη μεταφόρτωση του αρχείου σας.";
        }
    }
}
?>
