<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/4/10
  Time: 0:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <script type="text/javascript" src="./js/heic2any/heic2any.js"></script>
    <script type="text/javascript" src="./js/heictest.js"></script>
</head>
<body>


<form action="heic" method="post" enctype="multipart/form-data">
    <input type="file" name="file" id="file" onchange="readFile()"/>
    <img src="#" style="width:150px;" alt="pic" id="pic" />
    <h2 id="time"></h2>
    <button onclick="doupload()">upload</button>
</form>

</body>
</html>
