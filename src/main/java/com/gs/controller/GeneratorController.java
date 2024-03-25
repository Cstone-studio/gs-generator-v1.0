package com.gs.controller;

import com.gs.common.BadRequestException;
import com.gs.config.GenConfig;
import com.gs.service.intf.GeneratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api")
public class GeneratorController extends BaseController {

    @Autowired
    private GeneratorService generatorService;

    @Value("${generator.enabled}")
    private Boolean generatorEnabled;

    @Autowired
    private GenConfig genConfig;

//    /**
//     * 查询数据库元数据
//     * @param name
//     * @param page
//     * @param size
//     * @return
//     */
//    @GetMapping(value = "/generator/tables")
//    public ResponseEntity getTables(@RequestParam(defaultValue = "") String name,
//                                   @RequestParam(defaultValue = "0")Integer page,
//                                   @RequestParam(defaultValue = "10")Integer size){
//        int[] startEnd = PageUtils.transToStartEnd(page+1, size);
//        return new ResponseEntity(generatorService.getTables(name,startEnd), HttpStatus.OK);
//    }
//
//    /**
//     * 查询表内元数据
//     * @param tableName
//     * @return
//     */
//    @GetMapping(value = "/generator/columns")
//    public ResponseEntity getTables(@RequestParam String tableName){
//        return new ResponseEntity(generatorService.getColumns(tableName), HttpStatus.OK);
//    }

    @PostMapping(value = "/generator")
    public ResponseEntity generator(@RequestParam String tableName){
        if(!generatorEnabled){
            throw new BadRequestException("此环境不允许生成代码！");
        }
        generatorService.generator(genConfig, tableName);
        return new ResponseEntity(HttpStatus.OK);
    }
}
