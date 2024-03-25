package ${package}.repository.jpa.db1.spec;

import jakarta.persistence.criteria.Predicate;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

/**
* @author ${author}
* @date ${date}
*/
@Component
public class ${className}Specification<T> {

    public org.springframework.data.jpa.domain.Specification<T> searchKey(String keyword) {
        return (root, query, builder) -> {
            if (StringUtils.isEmpty(keyword)) {
                return builder.conjunction();
            }
            Predicate[] predicates = {
            <#if columns??>
                <#list columns as column>
                    <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
                    <#if !baseColumns?seq_contains(column.changeColumnName)>
                    builder.like(root.get("${column.changeColumnName}"), "%" + keyword + "%"),

                    </#if>
                </#list>
            </#if>
            };

            return builder.or(predicates);
        };
    }

    <#if columns??>
        <#list columns as column>
            <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
            <#if !baseColumns?seq_contains(column.changeColumnName)>
    public org.springframework.data.jpa.domain.Specification<T> ${column.changeColumnName}Like(${column.columnType} ${column.changeColumnName}) {
        return (root, query, builder) -> StringUtils.isEmpty(${column.changeColumnName}) ? builder.conjunction() : builder.like(root.get("${column.changeColumnName}"), "%" + ${column.changeColumnName} + "%");
    }
            </#if>
        </#list>
    </#if>
}