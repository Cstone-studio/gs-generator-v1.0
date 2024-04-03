interface ${className} {
<#if columns??>
    <#list columns as column>
        <#assign baseColumns = ["deleted", "createTime", "createUser", "updateTime", "updateUser"]>
        <#if !baseColumns?seq_contains(column.changeColumnName)>
  ${column.changeColumnName}:<#if column.columnType == "String"> string<#elseif ["Integer", "BigDecimal"]?seq_contains(column.columnType)> number<#elseif column.columnType == "Timestamp"> Date</#if>;
        </#if>
    </#list>
</#if>
}
