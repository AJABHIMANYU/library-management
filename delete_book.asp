<!-- #include file="db_conn.asp" -->
<%
Dim book_id
book_id = Request.QueryString("id")

If IsNumeric(book_id) And book_id > 0 Then
    ' Use a parameterized query for security
    Dim cmd, sql
    sql = "DELETE FROM books WHERE id = ?"

    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = conn
    cmd.CommandText = sql
    cmd.Parameters.Append cmd.CreateParameter("id", 3, 1, , book_id) ' adInteger

    cmd.Execute
    
    Set cmd = Nothing
Else
    ' Handle invalid ID - you could show an error message
    ' For simplicity, we just redirect.
End If

conn.Close
Set conn = Nothing

Response.Redirect "index.asp"
%>
