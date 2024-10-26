<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/10/3
  Time: 7:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
</head>
<script>

    function initCamera(isPortrail) {

        const constraint = {
            video: {
                facingMode: "environment",
                width:{ideal:isPortrail?720:1280},
                height:{ideal:isPortrail?1280:720}
            }
        }

        navigator.mediaDevices = navigator.mediaDevices ||
            ((navigator.webkitGetUserMedia ||
                navigator.mozGetUserMedia ||
                navigator.msGetUserMedia) ? {
                    getUserMedia(c) {
                        return new Promise(function(y, n)
                        {
                        (navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia).call(navigator, c, y, n);
                    }
                )
                    ;
                }
            }:null);

        if (navigator.mediaDevices) {

            navigator.mediaDevices.getUserMedia(constraint).then(function(stream) {
                var video = document.getElementById("videoElement");
                var videoTrack = stream.getVideoTracks()[0];
                video.style.display = "block";
                // 将流绑定到video元素上
                video.srcObject = stream;
            }).catch(function(err) {
            });
        } else {
        }
    }

    function init() {

        var isPortrail = (screen.orientation.type === "portrait-primary" || screen.orientation.type === "portrait-secondary")


        initCamera(isPortrail);

    }

    function takePhoto() {
        var video = document.getElementById("videoElement");
        var canvas = document.getElementById("canvas");
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
        var dataURL = canvas.toDataURL('image/png');
        var base64Data = dataURL.split(",")[1];
        document.getElementById("uploadImg").value = base64Data;
        document.getElementById('photo').src = dataURL;
        document.getElementById('photo').style.display = "block";
        video.style.display = "none";
    }

    function sendImgToServer() {


        var param = {}; param.img = document.getElementById("uploadImg").value;

        document.getElementById("photo").src = "";
        $.ajax("upload",{
            type: 'post',
            data: JSON.stringify({ img: document.getElementById("uploadImg").value }),
            contentType: 'application/json',
            processData: false, // 必须设置为 false
            success: function (res) {
                document.getElementById("photo").src = "data:image/jpg;base64," + JSON.parse(res).img;
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert('File upload failed');
            }
        });


    }
</script>
<body onload="init();">
<video id="videoElement" autoplay playsinline style="width:100%;height:100%;"></video>
<img style="display: none;" src="" id="photo" alt="photo">
<button style="width:150px;position:absolute;top:20px;" onclick="takePhoto()">拍照</button>
<button style="width:150px;position:absolute;top:60px;" onclick="sendImgToServer()">上传</button>
<canvas id="canvas" style="display: none;"></canvas>
<input type="hidden" name="uploadImg" id="uploadImg"/>
</body>
</html>
