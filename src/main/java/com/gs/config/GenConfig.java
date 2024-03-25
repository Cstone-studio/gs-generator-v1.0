package com.gs.config;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
@Data
public class GenConfig {

    /** 包路径 **/
    @Value("${generator.pack}")
    private String pack;

    /** 模块名 **/
    @Value("${generator.moduleName}")
    private String moduleName;

    /** 前端文件路径 **/
    @Value("${generator.path}")
    private String path;

    /** 后端文件路径 **/
    @Value("${generator.apiPath}")
    private String apiPath;

    /** 作者 **/
    @Value("${generator.author}")
    private String author;

    /** 是否覆盖 **/
    @Value("${generator.cover}")
    private String cover;
}
