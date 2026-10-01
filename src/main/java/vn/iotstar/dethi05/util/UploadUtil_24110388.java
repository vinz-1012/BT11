package vn.iotstar.dethi05.util;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class UploadUtil_24110388 {

    public static String saveUploadFile(Part part, ServletContext context) {
        if (part == null || part.getSize() <= 0) {
            return null;
        }

        String submittedFileName = part.getSubmittedFileName();
        if (submittedFileName == null || submittedFileName.trim().isEmpty()) {
            return null;
        }

        String extension = "";
        int dotIndex = submittedFileName.lastIndexOf('.');
        if (dotIndex >= 0) {
            extension = submittedFileName.substring(dotIndex);
        }

        String newFileName = System.currentTimeMillis() + "_" + UUID.randomUUID().toString().substring(0, 8) + extension;

        try {

            File sourceDir = new File(Constant_24110388.UPLOAD_DIRECTORY);
            if (!sourceDir.exists()) {
                sourceDir.mkdirs();
            }
            File sourceFile = new File(sourceDir, newFileName);
            try (InputStream input = part.getInputStream()) {
                Files.copy(input, sourceFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            if (context != null) {
                String deployPath = context.getRealPath("/uploads");
                if (deployPath != null) {
                    File deployDir = new File(deployPath);
                    if (!deployDir.exists()) {
                        deployDir.mkdirs();
                    }
                    File deployFile = new File(deployDir, newFileName);
                    Files.copy(sourceFile.toPath(), deployFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
            }

            System.out.println(">> Đã upload ảnh thành công: " + sourceFile.getAbsolutePath());
            return newFileName;
        } catch (IOException e) {
            System.err.println(">> Lỗi khi lưu file upload: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
