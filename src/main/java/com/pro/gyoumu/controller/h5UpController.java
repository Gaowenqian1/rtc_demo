package com.pro.gyoumu.controller;


import com.drew.imaging.ImageMetadataReader;
import com.drew.metadata.Metadata;
import com.drew.metadata.exif.ExifIFD0Directory;
import com.pro.gyoumu.utils.ImageUtils;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.commons.imaging.formats.tiff.write.TiffOutputSet;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileOutputStream;
import java.util.Base64;
import java.util.Date;

@Controller
public class h5UpController {


    @RequestMapping("/h5/index")
    public String index(HttpServletRequest request) {

        request.setAttribute("uploadFileSts", "no file");
        return "/h5upload/yilan.jsp";
    }

    @RequestMapping("/h5/zipai")
    public String zipai(HttpServletRequest request) {

        request.setAttribute("uploadFileSts", "no file");
        return "/h5upload/tongzhi.jsp";
    }


    @RequestMapping("/h5/upload")
    public String upload(HttpServletRequest request) throws Exception{

        try {
            if(request instanceof MultipartHttpServletRequest) {

                System.out.println("lastModified:"+ request.getParameter("lastField"));
                System.out.println("photo edit:"+ new Date());
                MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
                MultipartFile multipartFile = multipartHttpServletRequest.getFile("file");

                FileOutputStream fos1 = new FileOutputStream("D:\\original\\test.jpg");
                fos1.write(multipartFile.getBytes());
                fos1.flush();
                fos1.close();
                Metadata metadata = ImageMetadataReader.readMetadata(multipartFile.getInputStream());

                // 获取 EXIF IFD0 Directory (其中包含 Orientation 信息)
                ExifIFD0Directory directory = metadata.getFirstDirectoryOfType(ExifIFD0Directory.class);

                // 读取 Orientation 标签
//                int orientation = directory.getInt(ExifIFD0Directory.TAG_ORIENTATION);
//                System.out.println("Orientation: " + orientation);
                BufferedImage image = ImageIO.read(multipartFile.getInputStream());
                int width, height;
                if(image.getHeight() > image.getWidth()) {
                    width = 450;
                    height = 600;
                }else {
                    width = 600;
                    height = 450;
                }
                TiffOutputSet metaData = ImageUtils.getExifData(multipartFile.getBytes());
                ByteArrayOutputStream byteArrayOutputStream = ImageUtils.resizeImage(image,width,height);
                byte[] bytes1 = byteArrayOutputStream.toByteArray();
                ByteArrayOutputStream byteArrayOutputStream1 = ImageUtils.restoreExifMetadata(bytes1,metaData);
                byte[] bytes = byteArrayOutputStream1.toByteArray();

                FileOutputStream fos = new FileOutputStream("D:\\test\\test.jpg");
                fos.write(bytes);
                fos.flush();
                fos.close();
                request.setAttribute("uploadFileSts","success");
                request.setAttribute("img", Base64.getEncoder().encodeToString(bytes));
            }
        }catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("uploadFileSts", "faild");
        }

        return "/h5upload/caozuo.jsp";
    }
}
