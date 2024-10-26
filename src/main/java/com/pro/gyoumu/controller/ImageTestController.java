package com.pro.gyoumu.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;
import jakarta.servlet.http.HttpServletRequest;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Base64;

@Controller
@RequestMapping("/it")
public class ImageTestController {

    @RequestMapping("")
    public String image_test() {

        return "/it/index.jsp";

    }

    @RequestMapping("/zhuan")
    public String zhuan() {

        return "/orientation.jsp";

    }

    @RequestMapping("/upload")
    @ResponseBody
    public String upload(HttpServletRequest request, @RequestBody String img) throws MetadataException {
        JSONObject jsonObject = new JSONObject();
        try {
            // upload
            if(request instanceof MultipartHttpServletRequest) {
                MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
                MultipartFile multipartFile = multipartHttpServletRequest.getFile("file");

                BufferedImage image = ImageIO.read(multipartFile.getInputStream());
                Metadata metadata = ImageMetadataReader.readMetadata(multipartFile.getInputStream());

                // 获取 EXIF IFD0 Directory (其中包含 Orientation 信息)
                ExifIFD0Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);

                // 读取 Orientation 标签
                int orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
                System.out.println("Orientation: " + orientation);
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
                jsonObject.put("img", Base64.getEncoder().encodeToString(bytes));
            }

            // base64


            if(img != null) {
                JSONObject json = JSON.parseObject(img);
                String iii = (String)json.get("img");
                byte[] bytes = Base64.getDecoder().decode(iii);
                BufferedImage image = ImageIO.read(new ByteArrayInputStream(bytes));
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
                byte[] bytes1 = byteArrayOutputStream.toByteArray();
                jsonObject.put("img", Base64.getEncoder().encodeToString(bytes1));


            }
        }catch (Exception e) {

            jsonObject.put("sts", "error");
            return jsonObject.toString();
        }
        jsonObject.put("sts", "success");

        return jsonObject.toString();


    }
}
