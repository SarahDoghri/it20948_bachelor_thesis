<?php
$latexFile = "latex/question_pool.tex";
$outputDir = "output";

// Compile LaTeX to PDF
$command = "pdflatex -output-directory={$outputDir} {$latexFile}";
shell_exec($command);

// Additional compilation steps (e.g., BibTeX, makeindex)
// Uncomment and modify as per your requirements
/*
$command = "bibtex {$outputDir}/file.aux";
shell_exec($command);

$command = "makeindex {$outputDir}/file.idx";
shell_exec($command);

$command = "pdflatex -output-directory={$outputDir} {$latexFile}";
shell_exec($command);
*/

// Move the output PDF to a publicly accessible location
$pdfFile = "{$outputDir}/file.pdf";
// $destination = "path/to/publicly/accessible/location/output.pdf";
$destination = "output.pdf";
rename($pdfFile, $destination);

// Optionally, you can delete the temporary files
// Uncomment if desired
/*
$auxFile = "{$outputDir}/file.aux";
$logFile = "{$outputDir}/file.log";
$idxFile = "{$outputDir}/file.idx";
// ...
unlink($auxFile);
unlink($logFile);
unlink($idxFile);
// ...
?>
*/
