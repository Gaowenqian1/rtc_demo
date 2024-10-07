<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/7/15
  Time: 1:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Camera Rotation Angle</title>
    <style>
        #camera {
            width: 300px;
            height: 300px;
            border: 2px solid #000;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>
</head>
<body>
<h1>Camera Rotation Angle</h1>
<button id="requestPermissionButton">Request Permission</button>
<p>Rotation Angle (alpha): <span id="alpha">0</span>°</p>
<p>Rotation Angle (beta): <span id="beta">0</span>°</p>
<p>Rotation Angle (gamma): <span id="gamma">0</span>°</p>
<div id="camera">
    <p>Camera View</p>
</div>

<script>
    var lastEventTime = 0;
    // 定义一个时间间隔，例如500毫秒
    var throttleInterval = 2000;
    document.getElementById('requestPermissionButton').addEventListener('click', function() {
        if (typeof DeviceOrientationEvent.requestPermission === 'function') {
            DeviceOrientationEvent.requestPermission()
                .then(permissionState => {
                    if (permissionState === 'granted') {
                        window.addEventListener('deviceorientation', function(event) {
                            // 获取当前时间戳
                            var currentTime = new Date().getTime();
                            // 如果距离上次触发事件的时间间隔大于设定的时间间隔，则处理事件
                            if (currentTime - lastEventTime > throttleInterval) {
                                handleOrientation(event);
                                // 更新上次触发事件的时间戳
                                lastEventTime = currentTime;
                            }
                        });
                    } else {
                        alert("Permission to access device orientation was denied.");
                    }
                })
                .catch(console.error);
        } else {
            // Handle non-iOS 13+ devices
            window.addEventListener('deviceorientation', function(event) {
                // 获取当前时间戳
                var currentTime = new Date().getTime();
                // 如果距离上次触发事件的时间间隔大于设定的时间间隔，则处理事件
                if (currentTime - lastEventTime > throttleInterval) {
                    handleOrientation(event);
                    // 更新上次触发事件的时间戳
                    lastEventTime = currentTime;
                }
            });
        }
    });

    function handleOrientation(event) {
        let alpha = event.alpha.toFixed(2);
        let beta = event.beta.toFixed(2);
        let gamma = event.gamma.toFixed(2);
        document.getElementById('alpha').innerText = alpha;
        document.getElementById('beta').innerText = beta;
        document.getElementById('gamma').innerText = gamma;

        // Example: Rotate the camera view based on alpha angle
        <%--let cameraElement = document.getElementById('camera');--%>
        <%--cameraElement.style.transform = `rotate(${alpha}deg)`;--%>
    }
</script>
</body>
</html>