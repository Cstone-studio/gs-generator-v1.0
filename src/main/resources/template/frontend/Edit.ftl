<template>
  <div>
    <el-dialog
      v-model="data.dialogFormVisible"
      title="Edit ${className}"
      width="500"
    >
      <el-form ref="formRef" :model="data.form" :rules="formRules" size="small">
        <#if columns??>
          <#list columns as column>
            <#assign baseColumns = ["id", "deleted", "createTime", "createUser", "updateTime", "updateUser"]>
            <#if !baseColumns?seq_contains(column.changeColumnName)>
        <el-form-item
          label="${column.changeColumnName}"
          :label-width="data.formLabelWidth"
          prop="${column.changeColumnName}"
        >
          <el-input v-model<#if column.changeColumnName?ends_with("Id")>.number</#if>="data.form.${column.changeColumnName}" autocomplete="off" />
        </el-form-item>
            </#if>
          </#list>
        </#if>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="closeDialog" size="small">Cancel</el-button>
          <el-button type="primary" @click.prevent="edit${className}(formRef)" size="small">
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
      <#if column.changeColumnName?ends_with("Id")>
      {
        type: "number",
        trigger: "blur",
        message: "${column.changeColumnName} must be number",
      },
      {
        type: "number",
        max: 999999999,
        trigger: "blur",
        message: "${column.changeColumnName} length must be less than 9 digits",
      },
      </#if>
  ],
      </#if>
    </#list>
  </#if>
};

const formRef = ref<FormInstance>();

const ${changeClassName}Store = use${className}Store();

const openDialog = async (row: ${className}) => {
  await ${changeClassName}Store.get${className}Detail(row.id);
  copyProperties(${changeClassName}Store.${changeClassName}Detail, data.form);
  data.dialogFormVisible = true;
};

const closeDialog = () => {
  ${changeClassName}Store.get${className}s();
  data.dialogFormVisible = false;
  resetForm(data.form);
};

const edit${className} = async (formRef: FormInstance | undefined) => {
  if (!formRef) return;
  await formRef.validate(async (valid, fields) => {
    if (valid) {
      try {
        await ${changeClassName}Store.add${className}(data.form);
        ElNotification({
          title: "Success",
          message: "Save successfully",
          type: "success",
        });
        closeDialog();
        reset(); // 编辑后清除检索条件并自动检索画面
      } catch (error) {
        console.log("exception occur:", error);
      }
    }
  });
};


const reset = () => {
  ${changeClassName}Store.resetParams();
  ${changeClassName}Store.get${className}s();
};

defineExpose({
  openDialog,
});
</script>
