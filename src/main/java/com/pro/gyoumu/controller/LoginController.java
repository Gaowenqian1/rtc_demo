package com.pro.gyoumu.controller;


import com.alibaba.fastjson.JSON;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.stream.ImageInputStream;
import java.awt.image.BufferedImage;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
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

    @RequestMapping("/fileApi")
    public String fileApi() {

        return "fileApiTest.jsp";
    }

    @RequestMapping("/choose")
    public String choose() {

        return "html5Demp.jsp";
    }

    @RequestMapping("/index1")
    public String index1() {

        return null;
    }

    @RequestMapping("/tttt")
    public String index3() {

        return "ttttt.jsp";
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
        FileOutputStream fileOutputStream = new FileOutputStream(uploadDir+"\\test.jpg");
        fileOutputStream.write(bytes);
        fileOutputStream.flush();
        fileOutputStream.close();
        return "照片已保存到服务器";

//        InputStream inputStream = request.getInputStream();
//        String uploadDir = "D:\\temp\\fileUpload\\test.jpg";
//        Files.copy(inputStream, Paths.get(uploadDir));
//        return "success";
    }

    @RequestMapping(value = "/uploadImg_heic")
    @ResponseBody
    public String uploadImg_heic(HttpServletRequest request) throws Exception {


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
        FileOutputStream fileOutputStream = new FileOutputStream(uploadDir+"\\test.jpg");
        fileOutputStream.write(bytes);
        fileOutputStream.flush();
        fileOutputStream.close();
        return "照片已保存到服务器";
    }
    @RequestMapping(value = "/gotoajaxHeic")
    public String gotoajaxHeic(HttpServletRequest request) throws Exception {

        return "ajaxHeic.jsp";
    }
//    @RequestMapping(value = "/ajaxHeic")
//    @ResponseBody
//    public String ajaxHeic(HttpServletRequest request) throws Exception {
//
//        Date start = new Date();
//        String dataUrl = request.getParameterMap().get("image")[0].split(",")[1];
//        // 获取HEIC文件的字节数组
//        byte[] heicImageData = Base64.getDecoder().decode(dataUrl);
//
//        HeicMetadata imgMetadata = (HeicMetadata) JDeli.getImageInfo(heicImageData);
//        byte[] outputData = JDeli.convert(heicImageData,"jpg");
//
//        Map res = new HashMap();
//        res.put("image", Base64.getEncoder().encodeToString(outputData));
//        Date end = new Date();
//
//        System.out.println("处理时间" + (start.getTime() - end.getTime())/1000);
//
//        return JSON.toJSONString(res);
//    }

    @RequestMapping(value = "/getPicInfo")
    @ResponseBody
    public String getPicInfo() throws Exception {


        File img = new File("D:\\temp\\fileUpload\\1.png");
        ImageInputStream iis = ImageIO.createImageInputStream(img);
        ImageReader reader = ImageIO.getImageReadersByFormatName("png").next();
        reader.setInput(iis,true);
        IIOMetadata metadata = reader.getImageMetadata(0);
        String[] names = metadata.getMetadataFormatNames();
        StringBuilder stringBuilder = new StringBuilder();
        for(String name : names) {

            stringBuilder.append("name" + name);
            stringBuilder.append(":");
            stringBuilder.append("property:"+metadata.getAsTree(name));

        }
        return stringBuilder.toString();
    }

    @RequestMapping(value = "/gotoHeic")
    public String gotoHeic() throws Exception {

        return "heictest.jsp";
    }

    @RequestMapping(value = "/takePhoto")
    public String takePhoto() throws Exception {

        return "takePhote.jsp";
    }
    @RequestMapping(value = "/heic")
    @ResponseBody
    public String heicTest() throws Exception {

        return "success";
    }
}
