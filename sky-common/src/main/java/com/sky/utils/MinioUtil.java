package com.sky.utils;

import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import java.io.ByteArrayInputStream;

@Data
@AllArgsConstructor
@Slf4j
public class MinioUtil {

    private String endpoint;
    private String accessKey;
    private String secretKey;
    private String bucketName;

    /**
     * 文件上传
     * @param bytes 文件字节数组
     * @param objectName 存储在桶中的名称（包含后缀）
     * @return 文件的访问路径
     */
    public String upload(byte[] bytes, String objectName) {
        try {
            // 1. 创建 MinioClient 客户端
            MinioClient minioClient = MinioClient.builder()
                    .endpoint(endpoint)
                    .credentials(accessKey, secretKey)
                    .build();

            // 2. 上传文件
            ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
            minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucketName)
                            .object(objectName)
                            .stream(bais, bais.available(), -1)
                            .build()
            );

            // 3. 拼接并返回文件访问路径
            // 注意：因为你的图片是需要外部访问的，返回的完整URL格式为：http://IP:端口/桶名/文件名
            return String.format("%s/%s/%s", endpoint, bucketName, objectName);
        } catch (Exception e) {
            log.error("MinIO上传文件失败: {}", e.getMessage());
            return null;
        }
    }
}