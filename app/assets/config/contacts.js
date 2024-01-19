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