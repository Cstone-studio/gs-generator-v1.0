import { defineStore } from "pinia";

export const use${className}Store = defineStore("${changeClassName}Store", {
  state: () => ({
    ${changeClassName}s: [] as ${className}[],
    totalElements: 0,
    page: 1,
    rows: 20,
    params: {
      <#if columns??>
        <#list columns as column>
          <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
          <#if !baseColumns?seq_contains(column.changeColumnName)>
      ${column.changeColumnName}: "",
          </#if>
        </#list>
      </#if>
    },
    ${changeClassName}Detail: {} as ${className},
  }),

  actions: {
    async get${className}s(params?: {
      <#if columns??>
        <#list columns as column>
          <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
          <#if !baseColumns?seq_contains(column.changeColumnName)>
      ${column.changeColumnName}: string;
          </#if>
        </#list>
      </#if>
    }) {
      if (params !== undefined) this.params = params;
      const { data: result } = await useQsRequest.get("/api/${changeClassName}", {
        ...this.params,
        page: this.page,
        rows: this.rows,
      });

      this.${changeClassName}s = (result as Ref<CommonListsResp>).value.result.content;
      this.totalElements = (
        result as Ref<CommonListsResp>
      ).value.result.totalElements;
    },

    async add${className}(params: {
      <#if columns??>
        <#list columns as column>
          <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
          <#if !baseColumns?seq_contains(column.changeColumnName)>
      ${column.changeColumnName}: string;
          </#if>
        </#list>
      </#if>
    }) {
      await useQsRequest.post("/api/${changeClassName}", {
        ...params,
      });
    },

    async get${className}Detail(id: number) {
      const { data } = await useQsRequest.get("/api/${changeClassName}/detail", {
        id,
      });
      this.${changeClassName}Detail = (data as Ref<CommonResp<${className}>>).value.result;
    },

    async edit${className}(params: {
      <#if columns??>
        <#list columns as column>
          <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
          <#if !baseColumns?seq_contains(column.changeColumnName)>
      ${column.changeColumnName}: string;
          </#if>
        </#list>
      </#if>
    }) {
      await useQsRequest.put("/api/${changeClassName}", {
        ...params,
      });
    },

    async delete${className}(id: number) {
      await useQsRequest.delete("/api/${changeClassName}", {
        id,
      });
    },
  },
});
interface ${className} {
<#if columns??>
  <#list columns as column>
    <#assign baseColumns = ["deleted", "createTime", "createUser", "updateTime", "updateUser"]>
    <#if !baseColumns?seq_contains(column.changeColumnName)>
  ${column.changeColumnName}:<#if column.columnType == "String"> string<#elseif column.columnType == "Integer"> number</#if>;
    </#if>
  </#list>
</#if>
}
