function goBack() {
    if (typeof currentRole !== "undefined" && currentRole === "admin") {
        window.location.href = "admin.phtml?username=" + encodeURIComponent(currentUsername);
    } else if (typeof currentUsername !== "undefined" && currentUsername) {
        window.location.href = "loggedin.phtml?username=" + encodeURIComponent(currentUsername);
    } else {
        window.location.href = "index.html";
    }
}
