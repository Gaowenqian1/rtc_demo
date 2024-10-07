package com.pro.gyoumu.controller;


import jakarta.servlet.http.HttpServletRequest;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import javax.swing.plaf.multi.MultiToolTipUI;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Base64;

@Controller
public class h5UpController {


    @RequestMapping("/h5/index")
    public String index(HttpServletRequest request) {

        request.setAttribute("uploadFileSts", "no file");
        return "/h5upload/index.jsp";
    }


    @RequestMapping("/h5/upload")
    public String upload(HttpServletRequest request) throws Exception{

        try {
            if(request instanceof MultipartHttpServletRequest) {
                MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
                MultipartFile multipartFile = multipartHttpServletRequest.getFile("file");
                BufferedImage image = ImageIO.read(multipartFile.getInputStream());
                int width, height;
                if(image.getHeight() > image.getWidth()) {
                    width = 450;
                    height = 600;
                }else {
                    width = 600;
                    height = 450;
                }
                ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                Thumbnails.of(image).size(width, height).outputFormat("jpg").outputQuality(0.7).toOutputStream(byteArrayOutputStream);
                byte[] bytes = byteArrayOutputStream.toByteArray();

                request.setAttribute("uploadFileSts","success");
                request.setAttribute("img", Base64.getEncoder().encodeToString(bytes));
            }
        }catch (Exception e) {
            request.setAttribute("uploadFileSts", "faild");
        }

        return "/h5upload/index.jsp";
    }
}
