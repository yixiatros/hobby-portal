function collapse() {
    const coll = document.getElementById("collapse-uncollapse");

    coll.classList.toggle("active");
    const content = document.getElementById("contacts-info");
    const preview = document.getElementById("Contacts");
    const list = document.getElementById("contact-list");
    if (content.style.display === "block") {
        preview.style.display = "block";
        content.style.display = "none";
        coll.innerHTML = "▲"
        list.focused = true;
    } else {
        preview.style.display = "none";
        content.style.display = "block";
        coll.innerHTML = "▼"
        list.focused = false;
    }
}

function addUser() {
    const coll = document.getElementById("add-user-button");

    coll.classList.toggle("active");
    const content = document.getElementById("add-user-content");
    if (content.style.display === "block") {
        content.style.display = "none";
        content.style.hidden
    } else {
        content.style.display = "block";
    }
}