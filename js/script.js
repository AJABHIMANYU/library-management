// script.js

function confirmDelete(bookId) {
    if (confirm("Are you sure you want to delete this book? This action cannot be undone.")) {
        // If user confirms, redirect to the delete script
        window.location.href = 'delete_book.asp?id=' + bookId;
    }
    // If user cancels, do nothing
    return false;
}
