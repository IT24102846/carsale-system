package com.carsales.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;

import jakarta.annotation.PostConstruct;
import java.io.File;

@Configuration
public class AppConfig {

    /**
     * Configure multipart resolver for file uploads
     */
    @Bean
    public MultipartResolver multipartResolver() {
        return new StandardServletMultipartResolver();
    }

    /**
     * Init method to ensure directories exist
     * Using @PostConstruct instead of @Bean since we don't need to return anything
     */
    @PostConstruct
    public void ensureDirectoriesExist() {
        // Ensure upload directory exists
        String uploadDir = "src/main/resources/static/uploads";
        File uploads = new File(uploadDir);
        if (!uploads.exists()) {
            uploads.mkdirs();
        }

        // Ensure data directory exists
        String dataDir = "src/main/resources/data";
        File data = new File(dataDir);
        if (!data.exists()) {
            data.mkdirs();
        }
    }
}