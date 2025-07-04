<!-- #include file="db_conn.asp" -->
<%
Dim book_id, rs
book_id = Request.QueryString("id")

' --- Handle Form Submission for UPDATE ---
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    Dim title, author, isbn, pub_year, genre, quantity
    ' Get the ID from the hidden form field
    book_id = Request.Form("book_id")
    title = Request.Form("title")
    author = Request.Form("author")
    isbn = Request.Form("isbn")
    pub_year = Request.Form("publication_year")
    genre = Request.Form("genre")
    quantity = Request.Form("quantity")

    ' Use Parameterized Query to prevent SQL Injection
    Dim cmd, sql
    sql = "UPDATE books SET title=?, author=?, isbn=?, publication_year=?, genre=?, quantity=? WHERE id=?"
    
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("title", 200, 1, 255, title)
    cmd.Parameters.Append cmd.CreateParameter("author", 200, 1, 255, author)
    cmd.Parameters.Append cmd.CreateParameter("isbn", 200, 1, 20, isbn)
    cmd.Parameters.Append cmd.CreateParameter("publication_year", 3, 1, , pub_year)
    cmd.Parameters.Append cmd.CreateParameter("genre", 200, 1, 100, genre)
    cmd.Parameters.Append cmd.CreateParameter("quantity", 3, 1, , quantity)
    cmd.Parameters.Append cmd.CreateParameter("id", 3, 1, , book_id)

    cmd.Execute
    
    Set cmd = Nothing
    conn.Close
    Set conn = Nothing
    
    Response.Redirect "index.asp"
End If


' --- Fetch book data to populate the form ---
If IsNumeric(book_id) And book_id > 0 Then
    Dim fetch_sql
    fetch_sql = "SELECT * FROM books WHERE id = " & book_id
    Set rs = conn.Execute(fetch_sql)
    If rs.EOF Then
        Response.Write "Book not found!"
        Response.End
    End If
Else
    Response.Write "Invalid Book ID."
    Response.End
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Book</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Edit Book: <%=Server.HTMLEncode(rs("title"))%></h1>
        <form action="edit_book.asp" method="post">
            <input type="hidden" name="book_id" value="<%=rs("id")%>">
            <div>
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" value="<%=Server.HTMLEncode(rs("title"))%>" required>
            </div>
            <div>
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" value="<%=Server.HTMLEncode(rs("author"))%>" required>
            </div>
            <div>
                <label for="isbn">ISBN:</label>
                <input type="text" id="isbn" name="isbn" value="<%=Server.HTMLEncode(rs("isbn"))%>">
            </div>
            <div>
                <label for="publication_year">Publication Year:</label>
                <input type="number" id="publication_year" name="publication_year" value="<%=rs("publication_year")%>" min="1000" max="9999">
            </div>
            <div>
                <label for="genre">Genre:</label>
                <input type="text" id="genre" name="genre" value="<%=Server.HTMLEncode(rs("genre"))%>">
            </div>
            <div>
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" value="<%=rs("quantity")%>" min="0">
            </div>
            <div>
                <button type="submit" class="btn btn-primary">Update Book</button>
                <a href="index.asp" class="btn btn-back">Cancel</a>
            </div>
        </form>
    </div>
<%
rs.Close
Set rs = Nothing
conn.Close
Set conn = Nothing
%>
</body>
</html>
