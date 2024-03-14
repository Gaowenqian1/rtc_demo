<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/3/12
  Time: 17:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <script>
        function uploadFile() {

        }
        function sendTest() {
            var param = document.getElementById("tx1");
            var paramMap = {
                tx1:param
            }
            var xhr = new XMLHttpRequest();
            // 设置请求的类型及URL
            xhr.open('POST', 'uploadImg');
            // 设置请求头，表明我们要发送 JSON 数据
            xhr.setRequestHeader('Content-Type', 'application/json');
            // 将我们的数据转换为 JSON 字符串
            var jsonString = JSON.stringify(paramMap);
            // 设置响应类型
            xhr.responseType = 'json';
            // 添加onload事件监听器来处理请求成功的情况
            xhr.onload = function() {
                if (xhr.status === 200) {
                    // 请求成功，处理响应数据
                    console.log(xhr.response);
                } else {
                    // 请求失败，处理错误
                    console.error('请求失败，状态码：' + xhr.status);
                }
            };
            // 发送请求
            xhr.send(jsonString);
            alert("send end")
        }
    </script>
    <button onclick="uploadFile()">upload</button>
    <button onclick="sendTest()">sendTest</button>
    <input type="file" />
    <input id="tx1" type="text" />

<form method="post" action="uploadImg">

    <input type="text" name="txt"/>
    <input type="submit" value="sub"/>


</form>



</body>
</html>
