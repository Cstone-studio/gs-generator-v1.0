package ${package}.controller;

import ${package}.controller.demo.BaseController;
import ${package}.exception.IncorrectParameterException;
import ${package}.convert.${className}Convert;
import ${package}.model.dto.${className}DTO;
import ${package}.model.dto.${className}PageDTO;
import ${package}.model.entity.jpa.db1.${className};
import ${package}.repository.jpa.db1.${className}Repository;
import ${package}.service.intf.${className}Service;
import ${package}.utils.R;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
* @author ${author}
* @date ${date}
*/
@Tag(name = "${className}")
@RestController
@RequestMapping("api/${changeClassName}")
@AllArgsConstructor
@Validated
public class ${className}Controller extends BaseController {

    @Autowired
    private ${className}Service ${changeClassName}Service;

    @Autowired
    private ${className}Repository ${changeClassName}Repository;

    @Autowired
    private ${className}Convert ${changeClassName}Convert;

    @Operation(summary = "add ${changeClassName}")
    @PostMapping
    public R add(@Validated @RequestBody ${className}DTO dto) {
        ${changeClassName}Service.create(dto);
        return R.success();
    }

    @Operation(summary = "edit ${changeClassName}")
    @PutMapping
    public R update(@Validated @RequestBody ${className}DTO dto) throws IncorrectParameterException {
        ${changeClassName}Service.update(dto);
        return R.success();
    }

    @Operation(summary = "delete ${changeClassName}")
    @DeleteMapping
    public R del(@RequestParam("id") Integer id) {
        ${changeClassName}Service.delete(id);
        return R.success();
    }

    @Operation(summary = "search ${changeClassName}")
    @GetMapping("/detail")
    public R<${className}> detail(Integer id) {
        return R.success(${changeClassName}Service.findById(id));
    }

    @Operation(summary = "paging query ${changeClassName}")
    @GetMapping
    public R list(${className}PageDTO params) {
        return R.success(${changeClassName}Service.list(params, PageRequest.of(
                params.getPage() - 1,
                params.getRows(),
                Sort.by("id").descending()))
        );
    }
}
