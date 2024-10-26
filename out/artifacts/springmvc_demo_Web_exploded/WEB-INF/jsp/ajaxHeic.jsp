<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/4/10
  Time: 22:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="./js/ajaxHeic.js"></script>
</head>
<body>

<input type="file" name="file" id="file" onchange="readFile()"/>
<img src="#" style="width:150px;" alt="pic" id="pic" />
<h2 id="time"></h2>
<button onclick="doupload()">upload</button>

</body>
</html>
