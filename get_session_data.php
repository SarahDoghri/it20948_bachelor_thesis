<?php
session_start();
$username = $_SESSION["username"];
echo "<script>var sessionUsername = '$username';</script>";

var_dump($_SESSION);
?>
