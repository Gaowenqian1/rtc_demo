<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/2/8
  Time: 21:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebRtcDemo</title>
    <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
    <script type="text/javascript" src="./js/index.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/index.css">
</head>
<body>
<div id="videoContainer">
    <video id="videoElement" autoplay playsinline></video>
    <button id="toggleButton" onclick="changeCamera()">切换摄像头</button>
    <canvas id="canvas" style="display: none;"></canvas>
    <button id="takePhoto" onclick="takePhoto()">拍照</button>
    <button id="sendImgToServer" onclick="sendImgToServer()">上传</button>
    <select id="changeDisplay" onchange="changeDisplay()">
        <option value="A">1280*720</option>
        <option value="B">1440*900</option>
        <option value="C">1600*900</option>
        <option value="D">1920*1080</option>
    </select>
    <img id="photo" src="#"/>
</div>
</body>
</html>
