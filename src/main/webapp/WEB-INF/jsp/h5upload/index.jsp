<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/10/4
  Time: 12:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>


<form action="upload" enctype="multipart/form-data" method="post">

    <h1><%= request.getAttribute("uploadFileSts")%></h1>
    <input type="file" name="file"/>
    <input type="submit" value="upload"/>
    <% if(request.getAttribute("img") != null) { %>
    <img src="data:image/jpg;base64,<%=request.getAttribute("img")%>"/>
    <% } %>
</form>

</body>
</html>
