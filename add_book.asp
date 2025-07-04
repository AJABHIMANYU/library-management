<!-- #include file="db_conn.asp" -->
<%
' --- Handle Form Submission ---
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
    Dim title, author, isbn, pub_year, genre, quantity
    title = Request.Form("title")
    author = Request.Form("author")
    isbn = Request.Form("isbn")
    pub_year = Request.Form("publication_year")
    genre = Request.Form("genre")
    quantity = Request.Form("quantity")

    ' Basic Validation
    If Trim(title) = "" Or Trim(author) = "" Then
        Response.Write "Title and Author are required."
    Else
        ' Use Parameterized Query to prevent SQL Injection
        Dim cmd, sql
        sql = "INSERT INTO books (title, author, isbn, publication_year, genre, quantity) VALUES (?, ?, ?, ?, ?, ?)"
        
        Set cmd = Server.CreateObject("ADODB.Command")
        cmd.ActiveConnection = conn
        cmd.CommandText = sql
        cmd.Parameters.Append cmd.CreateParameter("title", 200, 1, 255, title) ' adVarChar
        cmd.Parameters.Append cmd.CreateParameter("author", 200, 1, 255, author)
        cmd.Parameters.Append cmd.CreateParameter("isbn", 200, 1, 20, isbn)
        cmd.Parameters.Append cmd.CreateParameter("publication_year", 3, 1, , pub_year) ' adInteger
        cmd.Parameters.Append cmd.CreateParameter("genre", 200, 1, 100, genre)
        cmd.Parameters.Append cmd.CreateParameter("quantity", 3, 1, , quantity)

        cmd.Execute
        
        Set cmd = Nothing
        conn.Close
        Set conn = Nothing
        
        Response.Redirect "index.asp"
    End If
End If
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="container">
        <h1>Add a New Book</h1>
        <form action="add_book.asp" method="post">
            <div>
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div>
                <label for="author">Author:</label>
                <input type="text" id="author" name="author" required>
            </div>
            <div>
                <label for="isbn">ISBN:</label>
                <input type="text" id="isbn" name="isbn">
            </div>
            <div>
                <label for="publication_year">Publication Year:</label>
                <input type="number" id="publication_year" name="publication_year" min="1000" max="9999">
            </div>
            <div>
                <label for="genre">Genre:</label>
                <input type="text" id="genre" name="genre">
            </div>
            <div>
                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" value="1" min="0">
            </div>
            <div>
                <button type="submit" class="btn btn-primary">Add Book</button>
                <a href="index.asp" class="btn btn-back">Back to List</a>
            </div>
        </form>
    </div>
</body>
</html>
