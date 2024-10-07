package com.pro.gyoumu.controller;


import jakarta.servlet.http.HttpServletRequest;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.core.codec.ByteArrayEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.support.StandardMultipartHttpServletRequest;

import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@Controller
@RequestMapping("/thumbnail")
public class Thumbnail {


    @RequestMapping("")
    public String index() {
        return "/thumbnail/index.jsp";
    }

    @RequestMapping("/uploadFile")
    @ResponseBody
    public String uploadFile(HttpServletRequest request) throws Exception {

        MultipartFile multipartFile = ((StandardMultipartHttpServletRequest) request).getFile("file");
        String quality = request.getParameter("quality");

        String fileName = multipartFile.getOriginalFilename();
        InputStream inputStream = multipartFile.getInputStream();

        FileOutputStream fileOutputStream = new FileOutputStream("E:/temp/" + quality + ".jpg");
        Thumbnails.of(inputStream).size(720,1280)
                .outputFormat("jpg")
                .outputQuality(Float.parseFloat(quality))
                .toOutputStream(fileOutputStream);
        fileOutputStream.close();
        return "success";
    }
}
