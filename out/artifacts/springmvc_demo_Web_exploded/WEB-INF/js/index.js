// 图片的URL
var imgDataUrl = "";
const displayObj_A = {
    width:1280,
    height:720
}
const displayObj_B = {
    width:1440,
    height:900
}
const displayObj_C = {
    width:1600,
    height:900
}
const displayObj_D = {
    width:1920,
    height:1080
}
const displayMap = {
    A:displayObj_A,
    B:displayObj_B,
    C:displayObj_C,
    D:displayObj_D
}
// 多个摄像头加载
// function loadCamera() {
//     var cameraList = document.getElementById('cameraList');
//     navigator.mediaDevices.enumerateDevices()
//         .then(function(devices) {
//             devices.forEach(function(device,index) {
//                 alert(index)
//                 if (device.kind === 'videoinput') {
//                     var option = document.createElement('option');
//                     option.value = device.deviceId;
//                     option.text = device.label || 'Camera ' + (cameraList.length + 1);
//                     cameraList.appendChild(option);
//                 }
//             });
//         })
//         .catch(function(err) {
//             console.log('获取媒体设备列表失败: ', err);
//         });
// }
// 默认开启后置摄像头
var backCamera = true;
// 切换摄像头
function changeCamera() {
    backCamera = !backCamera;
    startCamera();
}
// 开启摄像头
function startCamera () {
    // 检查浏览器是否支持getUserMedia
    navigator.getUserMedia = navigator.getUserMedia ||
        navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia ||
        navigator.msGetUserMedia;
    const constraint = {
        video: {
            facingMode: backCamera ? "user" : "environment",
        }
    }
    if (navigator.getUserMedia) {
        // 请求访问用户媒体设备
        navigator.getUserMedia(constraint, function(stream) {
            var video = document.getElementById("videoElement");
            var videoTrack = stream.getVideoTracks()[0];
            var settings = videoTrack.getSettings();
            video.style.display = "block";
            console.log('摄像头分辨率:', settings.width, 'x', settings.height);
            // 将流绑定到video元素上
            video.srcObject = stream;
        }, function(err) {
            console.log("访问用户媒体设备失败: ", err);
        });
    } else {
        console.log("抱歉，你的浏览器不支持 getUserMedia");
    }
}
// 拍照
function takePhoto() {
    var video = document.getElementById("videoElement");
    var canvas = document.getElementById("canvas");
    var photo = document.getElementById("photo");

    // 设置Canvas尺寸与视频流尺寸相同
    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    // 在Canvas上绘制当前视频帧
    var context = canvas.getContext("2d");
    context.drawImage(video, 0, 0, canvas.width, canvas.height);

    // 获取Canvas上的图像数据并设置给img标签
    var dataURL = imgDataUrl = canvas.toDataURL("image/png");
    photo.setAttribute("src", dataURL);
    photo.style.display = "block";
    video.style.display = "none";
}
// 上传图片
function sendImgToServer() {

    var xhr = new XMLHttpRequest();
    // 设置请求的类型及URL
    xhr.open('POST', 'uploadImg');
    // 设置请求头，表明我们要发送 JSON 数据
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    // 将我们的数据转换为 JSON 字符串
    var data = { image: imgDataUrl };
    var encodedData = Object.keys(data).map(function(key) {
        return encodeURIComponent(key) + '=' + encodeURIComponent(data[key]);
    }).join('&');
    // 设置响应类型
    xhr.responseType = 'json';
    // 添加onload事件监听器来处理请求成功的情况
    xhr.onload = function() {
        if (xhr.status === 200) {
            // 请求成功，处理响应数据
            console.log(xhr.response);
            alert("上传成功");
            var video = document.getElementById("videoElement");
            var photo = document.getElementById("photo");
            photo.setAttribute("src", "");
            photo.style.display = "none";
            video.style.display = "block";
        } else {
            // 请求失败，处理错误
            console.error('请求失败，状态码：' + xhr.status);
        }
    };
    // 发送请求
    xhr.send(encodedData);
}
// 画面加载时运行
startCamera();