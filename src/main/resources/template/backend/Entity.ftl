package ${package}.model.entity.jpa.db1;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;
<#if hasTimestamp>
import java.sql.Timestamp;
</#if>
<#if hasBigDecimal>
import java.math.BigDecimal;
</#if>

import java.util.Collection;

/**
* author ${author}
* date ${date}
*/
@Entity
@Data
@ToString
@Table(name="${tableName}")
public class ${className} extends BaseEntity {
<#if columns??>
    <#list columns as column>
    <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
    <#if !baseColumns?seq_contains(column.changeColumnName)>
    <#if column.columnComment != ''>
    /**
     * ${column.columnComment}
     */
    </#if>
    <#if column.columnKey = 'PRI'>
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    </#if>
    @Column(name = "${column.columnName}"<#if column.columnKey = 'UNI'>,unique = true</#if><#if column.isNullable = 'NO' && column.columnKey != 'PRI'>,nullable = false</#if>)
    private ${column.columnType} ${column.changeColumnName};
    </#if>
    </#list>
</#if>
}
