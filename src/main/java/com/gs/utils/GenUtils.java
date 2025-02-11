package com.gs.utils;

import cn.hutool.core.io.FileUtil;
import cn.hutool.extra.template.*;
import com.gs.config.GenConfig;
import com.gs.model.entity.jpa.db1.vo.ColumnInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.ObjectUtils;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 代码生成
 * @author guozy
 * @date 2019-01-02
 */
@Slf4j
public class GenUtils {

    private static final String TIMESTAMP = "Timestamp";

    private static final String BIGDECIMAL = "BigDecimal";

    private static final String PK = "PRI";

    /**
     * 获取后端代码模板名称
     * @return
     */
    public static List<String> getAdminTemplateNames() {
        List<String> templateNames = new ArrayList<>();
        templateNames.add("Entity");
        templateNames.add("Convert");
        templateNames.add("Repository");
        templateNames.add("Service");
        templateNames.add("ServiceImpl");
        templateNames.add("Specification");
        templateNames.add("Controller");
        templateNames.add("PageRequestDTO");
        templateNames.add("AddRequestDTO");
        templateNames.add("UpdateRequestDTO");
        templateNames.add("ResponseDTO");
        return templateNames;
    }

    /**
     * 获取前端代码模板名称
     * @return
     */
    public static List<String> getFrontTemplateNames() {
        List<String> templateNames = new ArrayList<>();
        templateNames.add("BtnGroup");
        templateNames.add("Edit");
        templateNames.add("Search");
        templateNames.add("Table");
        templateNames.add("index");
        templateNames.add("Store");
        templateNames.add("Type");
        return templateNames;
    }

    /**
     * 生成代码
     * @param columnInfos 表元数据
     * @param genConfig 生成代码的参数配置，如包路径，作者
     */
    public static void generatorCode(List<ColumnInfo> columnInfos, GenConfig genConfig, String tableName) throws IOException {
        Map<String,Object> map = new HashMap();
        map.put("package",genConfig.getPack());
        map.put("moduleName",genConfig.getModuleName());
        map.put("author",genConfig.getAuthor());
        map.put("date", LocalDate.now().toString());
        map.put("tableName",tableName);
        String className = StringUtils.toCapitalizeCamelCase(tableName);
        map.put("className", className);
        map.put("changeClassName", StringUtils.toCamelCase(tableName));
        map.put("hasTimestamp",false);
        map.put("hasBigDecimal",false);
        map.put("hasQuery",false);

        List<Map<String,Object>> columns = new ArrayList<>();
        List<Map<String,Object>> queryColumns = new ArrayList<>();
        for (ColumnInfo column : columnInfos) {
            Map<String,Object> listMap = new HashMap();
            listMap.put("columnComment",column.getColumnComment());
            listMap.put("columnKey",column.getColumnKey());

            String colType = ColUtils.cloToJava(column.getColumnType().toString().replace(" ", ""));
            if(PK.equals(column.getColumnKey())){
                map.put("pkColumnType",colType);
            }
            if(TIMESTAMP.equals(colType)){
                map.put("hasTimestamp",true);
            }
            if(BIGDECIMAL.equals(colType)){
                map.put("hasBigDecimal",true);
            }
            listMap.put("columnType",colType);
            listMap.put("columnName",column.getColumnName());
            listMap.put("isNullable",column.getIsNullable());
            listMap.put("columnShow",column.getColumnShow());
            listMap.put("changeColumnName",StringUtils.toCamelCase(column.getColumnName().toString()));
            listMap.put("capitalColumnName",StringUtils.toCapitalizeCamelCase(column.getColumnName().toString()));

            if(!StringUtils.isBlank(column.getColumnQuery())){
                listMap.put("columnQuery",column.getColumnQuery());
                map.put("hasQuery",true);
                queryColumns.add(listMap);
            }
            columns.add(listMap);
        }
        map.put("columns",columns);
        map.put("queryColumns",queryColumns);
        TemplateEngine engine = TemplateUtil.createEngine(new TemplateConfig("template", TemplateConfig.ResourceMode.CLASSPATH));

        // 生成后端代码
        List<String> templates = getAdminTemplateNames();
        for (String templateName : templates) {
            Template template = engine.getTemplate("backend/"+templateName+".ftl");
            String filePath = getAdminFilePath(templateName,genConfig,className);

            File file = new File(filePath);

            // 如果非覆盖生成
            if(genConfig.getCover().equals("false")){
                if(FileUtil.exist(file)){
                    continue;
                }
            }
            // 生成代码
            genFile(file, template, map);
        }

        // 生成前端代码
        templates = getFrontTemplateNames();
        for (String templateName : templates) {
            Template template = engine.getTemplate("frontend/"+templateName+".ftl");
            String filePath = getFrontFilePath(templateName,genConfig,map.get("changeClassName").toString(), className);

            File file = new File(filePath);

            // 如果非覆盖生成
            if(genConfig.getCover().equals("false")){
                if(FileUtil.exist(file)){
                    continue;
                }
            }
            // 生成代码
            genFile(file, template, map);
        }
    }

    /**
     * 定义后端文件路径以及名称
     */
    public static String getAdminFilePath(String templateName, GenConfig genConfig, String className) {
        String ProjectPath = System.getProperty("user.dir") + File.separator + genConfig.getModuleName();
        String packagePath = ProjectPath + File.separator + "src" +File.separator+ "main" + File.separator + "java" + File.separator;
        if (!ObjectUtils.isEmpty(genConfig.getPack())) {
            packagePath += genConfig.getPack().replace(".", File.separator) + File.separator;
        }

        if ("Entity".equals(templateName)) {
            return packagePath + "model" + File.separator + "entity" + File.separator + "jpa" + File.separator + "db1" + File.separator + className + ".java";
        }
        if ("Controller".equals(templateName)) {
            return packagePath + "controller" + File.separator + className + "Controller.java";
        }

        if ("Service".equals(templateName)) {
            return packagePath + "service" + File.separator + "intf" + File.separator + className + "Service.java";
        }

        if ("ServiceImpl".equals(templateName)) {
            return packagePath + "service" + File.separator + "impl" + File.separator + className + "ServiceImpl.java";
        }

        if ("Convert".equals(templateName)) {
            return packagePath + "convert" + File.separator + className + "Convert.java";
        }

        if ("Specification".equals(templateName)) {
            return packagePath + "repository" + File.separator + "jpa" + File.separator + "db1" + File.separator + "spec" + File.separator + className + "Specification.java";
        }

        if ("Repository".equals(templateName)) {
            return packagePath + "repository" + File.separator + "jpa" + File.separator + "db1" + File.separator + className + "Repository.java";
        }

        if ("PageRequestDTO".equals(templateName)) {
            return packagePath + "model" + File.separator + "dto" + File.separator + "request" + File.separator + className + "PageRequestDTO.java";
        }

        if ("AddRequestDTO".equals(templateName)) {
            return packagePath + "model" + File.separator + "dto" + File.separator + "request" + File.separator + className + "AddRequestDTO.java";
        }

        if ("UpdateRequestDTO".equals(templateName)) {
            return packagePath + "model" + File.separator + "dto" + File.separator + "request" + File.separator + className + "UpdateRequestDTO.java";
        }

        if ("ResponseDTO".equals(templateName)) {
            return packagePath + "model" + File.separator + "dto" + File.separator + "response" + File.separator + className + "ResponseDTO.java";
        }

        return null;
    }

    /**
     * 定义前端文件路径以及名称
     */
    public static String getFrontFilePath(String templateName, GenConfig genConfig, String apiName, String className) {
        String path = genConfig.getPath();

        if ("BtnGroup".equals(templateName)) {
            return path + File.separator + "components" + File.separator + apiName + File.separator + className + "BtnGroup.vue";
        }

        if ("Edit".equals(templateName)) {
            return path + File.separator + "components" + File.separator + apiName + File.separator + className + "Edit.vue";
        }

        if ("Search".equals(templateName)) {
            return path + File.separator + "components" + File.separator + apiName + File.separator + className + "Search.vue";
        }

        if ("Table".equals(templateName)) {
            return path + File.separator + "components" + File.separator + apiName + File.separator + className + "Table.vue";
        }

        if ("index".equals(templateName)) {
            return path + File.separator + "pages" + File.separator + apiName + "Index.vue";
        }

        if ("Store".equals(templateName)) {
            return path  + File.separator + "stores" + File.separator + apiName + "Store.ts";
        }

        if ("Type".equals(templateName)) {
            return path  + File.separator + "types" + File.separator + className + ".d.ts";
        }

        return null;
    }

    public static void genFile(File file,Template template,Map<String,Object> map) throws IOException {
        // 生成目标文件
        Writer writer = null;
        try {
            FileUtil.touch(file);
            writer = new FileWriter(file);
            template.render(map, writer);
        } catch (TemplateException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            writer.close();
        }
    }

    public static void main(String[] args){
        System.out.println(FileUtil.exist("E:\\1.5.txt"));
    }
}
