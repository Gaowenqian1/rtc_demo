function readFile() {


    var start = new Date();
    var input = event.target;
    if (input.files && input.files[0]) {
        if(input.files[0].name.endsWith(".heic") || input.files[0].name.endsWith(".HEIC")) {
            heic2any({
                blob:input.files[0],
                toType: 'image/jpeg',
                quality: 0.8}).then(function (resultBlob) {
                    var reader = new FileReader();
                    reader.readAsDataURL(resultBlob);
                    reader.onloadend = function () {
                        var base64 = reader.result;
                        document.querySelector("#pic").src = base64;

                        var end = new Date();
                        document.querySelector("#time").innerHTML = (end - start)/1000;
                    }
            })

        }else {
            var reader = new FileReader();
            reader.onload = function (e) {
                var data = e.target.result;
                document.querySelector("#pic").src = data;
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

}

function doupload() {

    var xhr = new XMLHttpRequest();
    // 设置请求的类型及URL
    xhr.open('POST', 'uploadImg_heic');
    // 设置请求头，表明我们要发送 JSON 数据
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    // 将我们的数据转换为 JSON 字符串
    var data = { image: document.querySelector("#pic").src};
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
        } else {
            // 请求失败，处理错误
            console.error('请求失败，状态码：' + xhr.status);
        }
    };
    // 发送请求
    xhr.send(encodedData);
}