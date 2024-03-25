package ${package}.model.dto;

import ${package}.model.dto.base.BasePage;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.ToString;
<#if hasTimestamp>
import java.sql.Timestamp;
</#if>
<#if hasBigDecimal>
import java.math.BigDecimal;
</#if>

/**
* @author ${author}
* @date ${date}
*/
@Data
@ToString
public class ${className}PageDTO extends BasePage {
<#if columns??>
    <#list columns as column>
        <#if column.columnComment != ''>
    /**
    * ${column.columnComment}
    */
        </#if>
    @Schema(name = "${column.changeColumnName}")
    private ${column.columnType} ${column.changeColumnName};
    </#list>
</#if>
}
