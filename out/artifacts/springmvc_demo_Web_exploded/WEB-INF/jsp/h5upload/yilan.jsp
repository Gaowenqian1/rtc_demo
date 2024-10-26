<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/10/23
  Time: 11:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script>
    function zipai() {
        document.forms[0].submit();
    }
</script>
<body>
<h1>一览画面</h1>
<h2>自拍</h2>
<button onclick="zipai()">自拍</button>
<h2>其他部位</h2>
<button onclick="sheying()">摄影</button>
<input type="file" multiple />
<form method="post" action="zipai"></form>
<form method="post" action="sheying"></form>
</body>
</html>
