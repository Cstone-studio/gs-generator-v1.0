package ${package}.model.dto.request;

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
* author ${author}
* date ${date}
*/
@Data
@ToString
public class ${className}PageRequestDTO extends BasePage {

    @Schema(name = "keywords")
    private String keywords;
<#if columns??>
    <#list columns as column>
        <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
        <#if !baseColumns?seq_contains(column.changeColumnName) && column.columnType != "BigDecimal" && column.columnType != "Timestamp">
            <#if column.columnComment != ''>
    /**
     * ${column.columnComment}
     */
            </#if>
    @Schema(name = "${column.changeColumnName}")
    private ${column.columnType} ${column.changeColumnName};
        </#if>
    </#list>
</#if>
}