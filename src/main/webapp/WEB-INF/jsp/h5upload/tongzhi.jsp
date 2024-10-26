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
    <script type="text/javascript" src="../js/Exif.js"></script>

</head>
<script>
    var jing;
    var wei;
    function chooseFile() {
        // navigator.geolocation.watchPosition(success,error);
        document.getElementById("file").click();
    }
    function init() {

        var device;
        var u_a = navigator.userAgent;
        if(u_a.includes("Android")) {
            device = "Android";
        }else if(u_a.includes("iPad")) {
            device = "ipad mini";
        }else if(u_a.includes("iPhone")) {
            device = "iPhone";
        }else if(u_a.includes("Mac")) {
            if('ontouchstart' in window || navigator.maxTouchPoints > 0) {
                device = "ipad pro / ipad air";
            }else {
                device = "mac book";
            }
        }
        alert("设备"+device);
        document.querySelector("#file").onchange = function (e) {

            var file = e.target.files[0];

            // document.getElementById("count").value = e.target.files.length;
            if (file) {
                // document.getElementById("last").value = file.lastModifiedDate;
                var d = new Date(file.lastModified);
                document.getElementById("lastField").value =
                    (d.getFullYear() + '-' +(d.getMonth() + 1) + '-' + d.getDate() + ' ' + d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds());
                // 使用 FileReader 读取文件
                // var reader = new FileReader();
                // reader.onload = function (e) {
                //     // 读取EXIF数据
                //     EXIF.getData(file, function () {
                //         var dateTaken = EXIF.getTag(this, "DateTimeOriginal");
                //         document.getElementById('output').value = dateTaken ?
                //             "拍摄日期: " + dateTaken :
                //             "无法找到拍摄日期";
                //     });
                // };
                // reader.readAsDataURL(file);
            }
            document.querySelector("[name=jing]").value = jing;
            document.querySelector("[name=wei]").value = wei;
            document.querySelector("[name=shijian]").value = new Date();
            document.forms[0].submit();
        }
        document.querySelector("#file").oncancel = function (e) {
            document.forms[1].submit();
        }
    }
    function success(e) {
        jing = e.coords.longitude;
        wei = e.coords.latitude;
    }
    function error(e) {
        console.log(e);
    }

</script>
<body onload="init()">
<form action="upload" enctype="multipart/form-data" method="post">

    <h1><%= request.getAttribute("uploadFileSts")%></h1>
    <input type="file" style="display: none;" name="file" id="file" multiple/>
    <button type="button" onclick="chooseFile()">OK!</button>
    <input type="hidden" value="" name="jing"/>
    <input type="hidden" value="" name="wei"/>
    <input type="hidden" value="" name="shijian"/>
    <br>
<%--    <label>摄影日期：</label><input type="text" value="" id="output"/><br>--%>
<%--    <label>上次修改日期：</label><input type="text" value="" id="last"/><br>--%>
    <label>上次修改：</label><input type="text" value="" id="lastField" name="lastField"/><br>
<%--    <label>文件数量：</label><input type="text" value="" id="count"/>--%>
</form>
<form action="index"></form>
</body>
</html>
