<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/3/12
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebRTC Video Call Example</title>
</head>
<body>
<video id="localVideo" autoplay muted></video>
<video id="remoteVideo" autoplay></video>
<button id="startButton">开始通话</button>
<button id="endButton">结束通话</button>

<script>
    let localStream;
    let remoteStream;
    let peerConnection;

    const localVideo = document.getElementById('localVideo');
    const remoteVideo = document.getElementById('remoteVideo');
    const startButton = document.getElementById('startButton');
    const endButton = document.getElementById('endButton');

    startButton.addEventListener('click', startCall);
    endButton.addEventListener('click', endCall);

    async function startCall() {
        try {
            // 获取本地视频流
            localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
            localVideo.srcObject = localStream;

            // 创建对等连接
            peerConnection = new RTCPeerConnection();
            peerConnection.addEventListener('icecandidate', handleICECandidate);
            peerConnection.addEventListener('track', handleTrack);

            // 将本地流添加到对等连接中
            localStream.getTracks().forEach(track => {
                peerConnection.addTrack(track, localStream);
            });

            // 创建offer并设置本地描述
            const offer = await peerConnection.createOffer();
            await peerConnection.setLocalDescription(offer);

            // TODO: 发送offer到信令服务器，待远程端应答

        } catch (error) {
            console.error('发生错误:', error);
        }
    }

    async function endCall() {
        try {
            // 关闭连接并释放资源
            peerConnection.close();
            localStream.getTracks().forEach(track => track.stop());
            localStream = null;
            remoteStream = null;
        } catch (error) {
            console.error('发生错误:', error);
        }
    }

    async function handleICECandidate(event) {
        try {
            // 发送ICE候选到信令服务器，待远程端接收
            const candidate = event.candidate;
            // TODO: 发送candidate到信令服务器
        } catch (error) {
            console.error('发生错误:', error);
        }
    }

    async function handleTrack(event) {
        try {
            // 接收到远程媒体流，显示在remoteVideo元素上
            remoteStream = event.streams[0];
            remoteVideo.srcObject = remoteStream;
        } catch (error) {
            console.error('发生错误:', error);
        }
    }
</script>
</body>
</html>
