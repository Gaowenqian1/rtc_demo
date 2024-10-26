<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/10/23
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<script>
    var jing;
    var wei;
    function chooseFile() {
        document.getElementById("file").click();
    }
    function init() {
        document.querySelector("#file").onchange = function (e) {
            alert('event fired')
            document.querySelector("[name=jing]").value = jing;
            document.querySelector("[name=wei]").value = wei;
            document.querySelector("[name=shijian]").value = new Date();
            document.forms[0].submit();
        }
        document.querySelector("#file").oncancel = function (e) {
            document.forms[1].submit();
        }
        navigator.geolocation.watchPosition(success,error);
    }
    function success(e) {
        jing = e.coords.longitude;
        wei = e.coords.latitude;
    }
    function error(e) {
        console.log(e);
    }

</script>
<body>
<form action="upload" enctype="multipart/form-data" method="post">
    <h1>操作画面</h1>
    <% if(request.getAttribute("img") != null) { %>
    <img src="data:image/jpg;base64,<%=request.getAttribute("img")%>"/>
    <% } %>
    <input type="file" style="display: none;" name="file" id="file" accept="image/*" capture="environment"/>
    <button type="button" onclick="chooseFile()">重拍</button>
    <input type="hidden" value="" name="jing"/>
    <input type="hidden" value="" name="wei"/>
    <input type="hidden" value="" name="shijian"/>
</form>
</body>
</html>
