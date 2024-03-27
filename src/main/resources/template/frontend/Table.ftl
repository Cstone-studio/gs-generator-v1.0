<template>
  <div>
    <ElITable
      :table-data="${changeClassName}Store.${changeClassName}s"
      :total="${changeClassName}Store.totalElements"
      :current-page="${changeClassName}Store.page"
      :page-size="${changeClassName}Store.rows"
      :label-list="data.tableLabel"
      :table-loading="data.loading"
      :pagination="data.pagination"
      :selection="data.selection"
      table-max-height="70vh"
      table-height="70vh"
      @row-dblclick="goToDetail"
      @current-change="handleCurrentChange"
    >
      <el-table-column>
        <template #default="scope">
          <el-button @click="handleEdit(scope.$index, scope.row)"
            >Edit</el-button
          >

          <el-popconfirm
            confirm-button-text="Yes"
            cancel-button-text="No"
            icon-color="#626AEF"
            title="Are you sure to delete this?"
            @confirm="handleDelete(scope.$index, scope.row)"
          >
            <template #reference>
              <el-button type="danger">Delete</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </ElITable>
    <${className}Edit ref="editDialogRef" />
  </div>
</template>

<script setup lang="ts">
import type { FormInstance } from "element-plus";

const data = reactive({
  tableLabel: [
    <#if columns??>
      <#list columns as column>
        <#assign baseColumns = ["deleted", "createTime", "createUser", "updateTime", "updateUser"]>
        <#if !baseColumns?seq_contains(column.changeColumnName)>
    { prop: "${column.changeColumnName}", label: <#if column.columnComment != ''>"${column.columnComment}"<#else>"no comment in db"</#if> },
        </#if>
      </#list>
    </#if>
  ],
  loading: true,
  selection: false,
  pagination: true,
});

const editDialogRef = ref<FormInstance>();

const ${changeClassName}Store = use${className}Store();

onMounted(async () => {
  await ${changeClassName}Store.get${className}s();
  data.loading = false;
});

// @ts-ignore
function goToDetail(row) {}

function handleCurrentChange(value: number) {
  ${changeClassName}Store.page = value;
  ${changeClassName}Store.get${className}s();
}

const handleEdit = (index: number, row: ${className}) => {
  // @ts-ignore
  editDialogRef.value?.openDialog(row);
};

const handleDelete = async (index: number, row: ${className}) => {
  await ${changeClassName}Store.delete${className}(row.id);
  ${changeClassName}Store.get${className}s();
};
</script>

<style></style>
