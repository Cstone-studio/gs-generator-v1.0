<template>
  <el-form ref="form" :inline="true" :model="data.form">
    <div style="display: flex">
      <div style="flex: 1">
      <#if columns??>
        <#list columns as column>
          <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
          <#if !baseColumns?seq_contains(column.changeColumnName)>
        <el-form-item label="${column.changeColumnName}">
          <el-input
            v-model="data.form.${column.changeColumnName}"
            style="width: 170px"
            placeholder="Please input ${column.changeColumnName}"
            clearable
          />
        </el-form-item>
          </#if>
        </#list>
      </#if>
      </div>
      <el-form-item>
        <el-button type="default" style="margin-bottom: 0px" @click="onSubmit"
          >查询</el-button
        >
      </el-form-item>
    </div>
  </el-form>
</template>

<script setup lang="ts">
const data = reactive({
  form: {
    <#if columns??>
      <#list columns as column>
        <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
        <#if !baseColumns?seq_contains(column.changeColumnName)>
    ${column.changeColumnName}: "",
        </#if>
      </#list>
    </#if>
  }
});

const ${changeClassName}Store = use${className}Store();

onMounted(() => {
});

function onSubmit(e: MouseEvent) {
  ${changeClassName}Store.get${className}s(data.form);
}
</script>

<style lang="scss" scoped>
@import "~/assets/sass/el/searchForm.scss";
</style>
