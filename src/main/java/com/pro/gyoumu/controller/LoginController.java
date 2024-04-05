package com.pro.gyoumu.controller;


import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Base64;
import java.util.Map;

@Controller
public class LoginController {

    @RequestMapping("/")
    public String index() {

        return "index.jsp";
    }

    @RequestMapping("/file")
    public String file() {

        return "file.jsp";
    }

    @RequestMapping("/choose")
    public String choose() {

        return "html5Demp.jsp";
    }

    @RequestMapping("/index1")
    public String index1() {

        return null;
    }


    @RequestMapping(value = "/uploadImg")
    @ResponseBody
    public String uploadImg(HttpServletRequest request) throws Exception {


        String dataUrl = request.getParameterMap().get("image")[0].split(",")[1];
        byte[] bytes = Base64.getDecoder().decode(dataUrl);
        // 获取服务器存储文件的路径
        String uploadDir = "D:\\temp\\fileUpload";

        // 确保目录存在，如果不存在则创建
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        // 将文件写入服务器
        FileOutputStream fileOutputStream = new FileOutputStream(uploadDir+"\\test.png");
        fileOutputStream.write(bytes);
        fileOutputStream.flush();
        fileOutputStream.close();
        return "照片已保存到服务器";
    }
}
