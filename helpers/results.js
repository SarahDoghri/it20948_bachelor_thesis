function calculateResults(score) {
    let success = "green";
    if (score < 75 && score >= 50) {
        success = "orange";
    } else if (score < 50) {
        success = "red";
    }

    return success;
}