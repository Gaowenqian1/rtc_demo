<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/4/16
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>thumbnail index</title>
    <script type="text/javascript" src="./js/thumbnail/index.js"></script>
</head>
<body>
<%--    <img src="#" alt="pic" id="photo"/>--%>
    <form action="thumbnail/uploadFile" method="post" enctype="multipart/form-data">
        <input type="file" name="file" accept="image/png,jpg,jpeg" onchange="chooseFile()"/>
        <input type="submit" value="upload" />
        <select name="quality">
            <option value="1">1</option>
            <option value="0.5">0.5</option>
            <option value="0.1">0.1</option>
        </select>
    </form>
</body>
</html>
