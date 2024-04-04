import { defineStore, acceptHMRUpdate } from "pinia";
import { resetForm } from "~/composables/resetForm";

export const use${className}Store = defineStore("${changeClassName}Store", {
  state: () => ({
    ${changeClassName}s: [] as ${className}[],
    totalElements: 0,
    page: 1,
    rows: 10,
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
      keywords: string,
    }) {
      if (params !== undefined) this.params = params;
      const { data: result } = await useQsRequest.get("/api/${changeClassName}", {
        ...this.params,
        page: this.page,
        rows: this.rows,
      });

      this.${changeClassName}s = (result as Ref<CommonListsResp>).value.result.records;
      this.totalElements = (
        result as Ref<CommonListsResp>
      ).value.result.total;
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

    resetParams() {
      resetForm(this.params);
      this.page = 1;
    },
  },
});

if (import.meta.hot) {
  import.meta.hot.accept(acceptHMRUpdate(use${className}Store, import.meta.hot));
}
