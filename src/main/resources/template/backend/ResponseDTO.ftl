package ${package}.model.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.ToString;
<#if hasTimestamp>
    import java.sql.Timestamp;
</#if>
<#if hasBigDecimal>
    import java.math.BigDecimal;
</#if>
import java.io.Serializable;

/**
* @author ${author}
* @date ${date}
*/
@Data
@ToString
public class ${className}ResponseDTO implements Serializable {
<#if columns??>
    <#list columns as column>
        <#assign baseColumns = ["deleted", "createTime", "createUser", "updateTime", "updateUser"]>
        <#if !baseColumns?seq_contains(column.changeColumnName)>
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
