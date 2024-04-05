<%--
  Created by IntelliJ IDEA.
  User: 65379
  Date: 2024/3/12
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HTML5 DEMO</title>
    <script type="text/javascript" src="./js/heic2any/heic2any.min.js"></script>
    <script>
        function previewImage(event) {
            var input = event.target;
            var preview = document.querySelector('#preview');
            if(input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</head>
<body>

    <input type="file" accept="image/*" onchange="previewImage(event)"/>
    <img id="preview" src="#" alt="预览" style="max-width:300px;max-height:300px;">




</body>
</html>
