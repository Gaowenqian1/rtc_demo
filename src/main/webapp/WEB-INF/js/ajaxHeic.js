function readFile() {


    var start = new Date();
    var input = event.target;
    var reader = new FileReader();
    if(input.files[0].name.endsWith(".heic") || input.files[0].name.endsWith(".HEIC")) {
        reader.onload = function (e) {
            var start = new Date();
            var src = e.target.result;
            var data = {image: src};
            var encodedData = Object.keys(data).map(function(key) {
                return encodeURIComponent(key) + '=' + encodeURIComponent(data[key]);
            }).join('&');
            var xhr = new XMLHttpRequest();
            // 设置请求的类型及URL
            xhr.open('POST', 'ajaxHeic');
            // 设置请求头，表明我们要发送 JSON 数据
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            // 设置响应类型
            xhr.responseType = 'json';
            // 添加onload事件监听器来处理请求成功的情况
            xhr.onload = function() {
                if (xhr.status === 200) {
                    // 请求成功，处理响应数据
                    console.log(xhr.response);
                    document.querySelector("#pic").src = "data:image/jgp;base64,"+xhr.response.image;
                    var end = new Date();
                    console.log("经过"+(end.getTime()-start.getTime())/1000+"ms");
                } else {
                    // 请求失败，处理错误
                    console.error('请求失败，状态码：' + xhr.status);
                }
            };
            // 发送请求
            xhr.send(encodedData);
        };
    }else{
        reader.onload = function (e) {
            var data = e.target.result;
            document.querySelector("#pic").src = data;
        }
    }
    reader.readAsDataURL(input.files[0]);
}