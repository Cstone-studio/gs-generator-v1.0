<template>
  <el-form ref="form" :inline="true" :model="data.form">
    <div style="display: flex">
      <div style="flex: 1">
        <el-form-item label="关键字" size="small">
          <el-input
            v-model="data.form.keywords"
            style="width: 150px"
            size="small"
            <#if columns??>
              <#assign columnsString = "">
              <#assign baseColumns = ["id","deleted", "createTime", "createUser", "updateTime", "updateUser"]>
              <#assign filteredColumns = columns?filter(column -> !baseColumns?seq_contains(column.changeColumnName) && column.columnType != "BigDecimal" && column.columnType != "Timestamp" && !column.changeColumnName?ends_with("Id"))>
              <#list filteredColumns as column>
                <#if column.columnComment != ''>
                  <#assign columnsString = columnsString + column.columnComment>
                <#else>
                  <#assign columnsString = columnsString + "no comment in db">
                </#if>
                <#if (filteredColumns?size-1) != column?index>
                  <#assign columnsString = columnsString + "/">
                </#if>
              </#list>
placeholder="${columnsString}"
            </#if>
            clearable></el-input>
        </el-form-item>
      </div>
      <el-form-item style="margin-bottom: 0px">
        <el-button type="default" size="small" @click="onSubmit"
          >查询
        </el-button>
        <el-button type="info" size="small" @click="reset"
          >重置
        </el-button>
      </el-form-item>
    </div>
  </el-form>
</template>

<script setup lang="ts">
const data = reactive({
  form: {
   keywords:'',
  }
});

const ${changeClassName}Store = use${className}Store();

onMounted(() => {});

const onSubmit = (e: MouseEvent) => {
  ${changeClassName}Store.get${className}s(data.form);
}

const reset = () => {
  ${changeClassName}Store.resetParams();
  ${changeClassName}Store.get${className}s();
};
</script>

<style lang="scss" scoped>
@import "~/assets/sass/el/searchForm.scss";
</style>
