package com.gs.controller;

import cn.hutool.core.util.PageUtil;
import com.gs.common.BadRequestException;
import com.gs.model.entity.jpa.db1.vo.ColumnInfo;
import com.gs.service.intf.GenConfigService;
import com.gs.service.intf.GeneratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api")
public class GeneratorController extends BaseController {

    @Autowired
    private GeneratorService generatorService;

    @Autowired
    private GenConfigService genConfigService;

    @Value("${generator.enabled}")
    private Boolean generatorEnabled;

    /**
     * 查询数据库元数据
     * @param name
     * @param page
     * @param size
     * @return
     */
    @GetMapping(value = "/generator/tables")
    public ResponseEntity getTables(@RequestParam(defaultValue = "") String name,
                                   @RequestParam(defaultValue = "0")Integer page,
                                   @RequestParam(defaultValue = "10")Integer size){
        int[] startEnd = PageUtil.transToStartEnd(page+1, size);
        return new ResponseEntity(generatorService.getTables(name,startEnd), HttpStatus.OK);
    }

    /**
     * 查询表内元数据
     * @param tableName
     * @return
     */
    @GetMapping(value = "/generator/columns")
    public ResponseEntity getTables(@RequestParam String tableName){
        return new ResponseEntity(generatorService.getColumns(tableName), HttpStatus.OK);
    }

    /**
     * 生成代码
     * @param columnInfos
     * @return
     */
    @PostMapping(value = "/generator")
    public ResponseEntity generator(@RequestBody List<ColumnInfo> columnInfos, @RequestParam String tableName){
        if(!generatorEnabled){
            throw new BadRequestException("此环境不允许生成代码！");
        }
        generatorService.generator(columnInfos,genConfigService.find(),tableName);
        return new ResponseEntity(HttpStatus.OK);
    }
}
