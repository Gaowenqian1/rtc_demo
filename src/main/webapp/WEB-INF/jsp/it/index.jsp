<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/4/28
  Time: 23:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>camera test</title>
</head>
<script>
    function selectFile() {
        var input = event.target;
        if(input.files && input.files[0]) {

            var reader = new FileReader();
            reader.onload = function (loadEvent) {
                document.querySelector("#image").src = loadEvent.target.result;
            }
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>
<body>

<img src="" alt="" id="image" style="width:30%;"/>
<input type="file" accept="image/*" id="file" onchange="selectFile()"/>

</body>
</html>
