package com.pro.gyoumu.utils;

import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.imaging.Imaging;
import org.apache.commons.imaging.common.ImageMetadata;
import org.apache.commons.imaging.formats.jpeg.JpegImageMetadata;
import org.apache.commons.imaging.formats.jpeg.exif.ExifRewriter;
import org.apache.commons.imaging.formats.tiff.write.TiffOutputSet;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class ImageUtils {

    public static TiffOutputSet getExifData(byte[] imageFile) throws Exception {
        // 获取原图的元数据
        ImageMetadata metadata = Imaging.getMetadata(imageFile);

        // 将元数据转为可编辑的TiffOutputSet
        if (metadata instanceof JpegImageMetadata) {
            JpegImageMetadata jpegMetadata = (JpegImageMetadata) metadata;
            // 转换为可写的 TiffOutputSet
            return jpegMetadata.getExif().getOutputSet();
        } else {
            return null;  // 如果没有 EXIF 数据或格式不支持
        }
    }


    public static ByteArrayOutputStream resizeImage(BufferedImage inputFile, int width, int height) throws IOException {

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        Thumbnails.of(inputFile)
                .size(width, height)
                .outputFormat("jpg")  // 或者你需要的格式
         .outputQuality(0.7).toOutputStream(byteArrayOutputStream);

        return byteArrayOutputStream;
    }

    public static ByteArrayOutputStream restoreExifMetadata(byte[] resizedFile, TiffOutputSet exifData) throws Exception {
        if (exifData != null) {
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            // 将 EXIF 数据重新写入缩放后的图片
            new ExifRewriter().updateExifMetadataLossless(resizedFile, byteArrayOutputStream, exifData);

            return byteArrayOutputStream;
        }
        return null;
    }
}
