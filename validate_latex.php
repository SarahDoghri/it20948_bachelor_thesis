<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $target_dir = "uploads/quizzes/";
    $target_file = $target_dir . basename($_FILES["latex_file"]["name"]);
    $uploadOk = 1;
    $fileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

    // Check if it's a .tex file
    if ($fileType !== "tex") {
        echo "Επιτρέπονται μόνο αρχεία .tex.";
        $uploadOk = 0;
    }

    // Check if file already exists
    if (file_exists($target_file)) {
        echo "Το αρχείο υπάρχει ήδη.";
        $uploadOk = 0;
    }

    // Check file size (adjust this limit as needed)
    if ($_FILES["latex_file"]["size"] > 500000) {
        echo "Το αρχείο είναι πολύ μεγάλο.";
        $uploadOk = 0;
    }

    // Check if $uploadOk is set to 0 by an error
    if ($uploadOk == 0) {
        echo "</br>";
        echo "Το αρχείο δεν μεταφορτώθηκε.";
    } else {
        if (move_uploaded_file($_FILES["latex_file"]["tmp_name"], $target_file)) {
            // File was successfully uploaded, now validate it
            $output = shell_exec("pdflatex -interaction=nonstopmode -halt-on-error " . escapeshellarg($target_file));

            // Check if compilation was successful
            if (strpos($output, "Output written on") !== false) {
                echo "Το αρχείο LaTeX είναι έγκυρο.";
            } else {
                echo "Το αρχείο LaTeX περιέχει σφάλματα:<br>";
                echo nl2br(htmlspecialchars($output));
            }
        } else {
            echo "Σφάλμα κατά τη μεταφόρτωση του αρχείου.";
        }
    }
}
?>
