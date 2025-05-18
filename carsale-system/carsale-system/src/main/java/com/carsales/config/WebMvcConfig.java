package com.carsales.config;

import org.apache.catalina.Context;
import org.apache.tomcat.util.scan.StandardJarScanner;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.servlet.server.ConfigurableServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.io.File;

@Configuration
@EnableWebMvc
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/");  // Look for views in the WEB-INF/views directory
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        return resolver;
    }

    @Bean
    public ConfigurableServletWebServerFactory webServerFactory() {
        TomcatServletWebServerFactory factory = new TomcatServletWebServerFactory() {
            @Override
            protected void postProcessContext(Context context) {
                // Disable TLD scanning to improve startup time
                ((StandardJarScanner) context.getJarScanner()).setScanManifest(false);
            }
        };

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

        return factory;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // Handle static resources from both classpath and webapp
        registry.addResourceHandler("/resources/**")
                .addResourceLocations("/resources/", "classpath:/static/resources/");

        registry.addResourceHandler("/css/**")
                .addResourceLocations("/css/", "classpath:/static/css/");

        registry.addResourceHandler("/js/**")
                .addResourceLocations("/js/", "classpath:/static/js/");

        registry.addResourceHandler("/images/**")
                .addResourceLocations("/images/", "classpath:/static/images/");

        // Configure uploads directory properly
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("/uploads/", "classpath:/static/uploads/", "file:src/main/resources/static/uploads/");

        registry.addResourceHandler("/assets/**")
                .addResourceLocations("/assets/", "classpath:/static/assets/");
    }

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Add simple automated controllers pre-configured with status code, view name, etc.
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/register").setViewName("register");
        registry.addViewController("/").setViewName("index");
    }
}
