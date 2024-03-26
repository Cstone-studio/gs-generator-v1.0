<template>
  <div>
    <el-dialog
      v-model="data.dialogFormVisible"
      title="Edit ${className}"
      width="500"
    >
      <el-form ref="formRef" :model="data.form" :rules="formRules">
        <#if columns??>
          <#list columns as column>
            <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
            <#if !baseColumns?seq_contains(column.changeColumnName)>
        <el-form-item
          label="${column.changeColumnName}"
          :label-width="data.formLabelWidth"
          prop="${column.changeColumnName}"
        >
          <el-input v-model="data.form.${column.changeColumnName}" autocomplete="off" />
        </el-form-item>
            </#if>
          </#list>
        </#if>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="closeDialog">Cancel</el-button>
          <el-button type="primary" @click.prevent="edit${className}(formRef)">
            Confirm
          </el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import type { FormInstance } from "element-plus";
import { resetForm } from "~/composables/resetForm";

const data = reactive({
  dialogFormVisible: false,
  formLabelWidth: "140px",
  form: {
    <#if columns??>
      <#list columns as column>
        <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
        <#if !baseColumns?seq_contains(column.changeColumnName)>
      ${column.changeColumnName}: "",
        </#if>
      </#list>
    </#if>
  },
});

const formRules = {
  <#if columns??>
    <#list columns as column>
      <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
      <#if !baseColumns?seq_contains(column.changeColumnName)>
  ${column.changeColumnName}: [
    { required: true, trigger: "blur", message: "${column.changeColumnName} cannot be empty" },
  ],
      </#if>
    </#list>
  </#if>
};

const formRef = ref<FormInstance>();

const use${className}Store = use${className}Store();

const openDialog = async (row: ${className}) => {
  await use${className}Store.get${className}Detail(row.id);
  copyProperties(use${className}Store.${changeClassName}Detail, data.form);
  data.dialogFormVisible = true;
};

const closeDialog = () => {
  use${className}Store.get${className}s();
  data.dialogFormVisible = false;
  resetForm(data.form);
};

const edit${className} = async (formRef: FormInstance | undefined) => {
  if (!formRef) return;
  await formRef.validate(async (valid, fields) => {
    if (valid) {
      try {
        await use${className}Store.add${className}(data.form);
        ElNotification({
          title: "Success",
          message: "Save successfully",
          type: "success",
        });
        closeDialog();
      } catch (error) {
        console.log("exception occur:", error);
      }
    }
  });
};

defineExpose({
  openDialog,
});
</script>
