<!-- #include file="db_conn.asp" -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Library Book Management System</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="js/script.js"></script>
</head>
<body>
    <div class="container">
        <h1>Library Book Management System</h1>
        <a href="add_book.asp" class="btn btn-primary">Add New Book</a>

        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>ISBN</th>
                    <th>Year</th>
                    <th>Genre</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                Dim rs, sql
                sql = "SELECT * FROM books ORDER BY title ASC"
                Set rs = conn.Execute(sql)

                If Not rs.EOF Then
                    Do While Not rs.EOF
                %>
                <tr>
                    <td><%=Server.HTMLEncode(rs("title"))%></td>
                    <td><%=Server.HTMLEncode(rs("author"))%></td>
                    <td><%=Server.HTMLEncode(rs("isbn"))%></td>
                    <td><%=rs("publication_year")%></td>
                    <td><%=Server.HTMLEncode(rs("genre"))%></td>
                    <td><%=rs("quantity")%></td>
                    <td class="actions">
                        <a href="edit_book.asp?id=<%=rs("id")%>" class="btn btn-edit">Edit</a>
                        <a href="#" onclick="return confirmDelete(<%=rs("id")%>);" class="btn btn-delete">Delete</a>
                    </td>
                </tr>
                <%
                        rs.MoveNext
                    Loop
                Else
                %>
                <tr>
                    <td colspan="7">No books found in the library.</td>
                </tr>
                <%
                End If
                rs.Close
                Set rs = Nothing
                conn.Close
                Set conn = Nothing
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
