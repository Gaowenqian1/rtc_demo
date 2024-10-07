<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Capture and Correct Photo Orientation</title>
    <style>
        #camera {
            width: 100%;
            height: auto;
            border: 2px solid #000;
        }
        #snapshot {
            display: none;
        }
        #result {
            display: block;
            width: 100%;
            height: auto;
            margin-top: 20px;
            border: 2px solid #000;
        }
        button {
            margin: 10px;
        }
    </style>
</head>
<body>
<h1>Capture and Correct Photo Orientation</h1>
<button id="requestPermissionButton">Request Permission</button>
<button id="captureButton">Capture Photo</button>
<p>Rotation Angle (alpha): <span id="alpha">0</span>°</p>
<video id="camera" autoplay></video>
<canvas id="snapshot"></canvas>
<img id="result" />

<script>
    let alpha = 0;

    document.getElementById('requestPermissionButton').addEventListener('click', function() {
        if (typeof DeviceOrientationEvent.requestPermission === 'function') {
            DeviceOrientationEvent.requestPermission()
                .then(permissionState => {
                    if (permissionState === 'granted') {
                        window.addEventListener('deviceorientation', handleOrientation, false);
                    } else {
                        alert("Permission to access device orientation was denied.");
                    }
                })
                .catch(console.error);
        } else {
            // Handle non-iOS 13+ devices
            window.addEventListener('deviceorientation', handleOrientation, false);
        }
    });

    function handleOrientation(event) {
        alpha = event.alpha.toFixed(2);
        document.getElementById('alpha').innerText = alpha;
    }

    // Access the camera and start video stream
    const video = document.getElementById('camera');
    const constraints = {
        video: {
            facingMode: "environment"
        }
    };

    navigator.mediaDevices.getUserMedia(constraints)
        .then((stream) => {
            video.srcObject = stream;
        })
        .catch((err) => {
            console.error("Error accessing the camera: " + err);
        });

    // Capture the photo
    document.getElementById('captureButton').addEventListener('click', function() {
        const canvas = document.getElementById('snapshot');
        const context = canvas.getContext('2d');

        // Set canvas dimensions to match video
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;

        // Draw video frame to canvas
        context.drawImage(video, 0, 0, canvas.width, canvas.height);

        // Rotate the image based on the alpha angle
        const rotatedCanvas = document.createElement('canvas');
        const rotatedContext = rotatedCanvas.getContext('2d');

        // Calculate the new canvas size and translation needed for rotation
        const diagonal = Math.sqrt(canvas.width * canvas.width + canvas.height * canvas.height);
        rotatedCanvas.width = diagonal;
        rotatedCanvas.height = diagonal;

        rotatedContext.save();
        rotatedContext.translate(diagonal / 2, diagonal / 2);
        rotatedContext.rotate((alpha * Math.PI) / 180);
        rotatedContext.drawImage(canvas, -canvas.width / 2, -canvas.height / 2);
        rotatedContext.restore();

        // Crop the image to the original size
        const croppedCanvas = document.createElement('canvas');
        const croppedContext = croppedCanvas.getContext('2d');
        croppedCanvas.width = canvas.width;
        croppedCanvas.height = canvas.height;
        const offsetX = (diagonal - canvas.width) / 2;
        const offsetY = (diagonal - canvas.height) / 2;
        croppedContext.drawImage(rotatedCanvas, -offsetX, -offsetY);

        // Show the rotated and cropped image
        const img = document.getElementById('result');
        img.src = croppedCanvas.toDataURL('image/png');
    });
</script>
</body>
</html>