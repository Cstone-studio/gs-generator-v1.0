<template>
  <div>
    <el-button type="success" plain @click="data.dialogFormVisible = true" size="small"
      >Add</el-button
    >
  </div>
  <el-dialog v-model="data.dialogFormVisible" title="Add ${className}" width="500">
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
        <el-button @click="data.dialogFormVisible = false">Cancel</el-button>
        <el-button
          :loading="data.addBtnLoading"
          type="primary"
          @click.prevent="add${className}(formRef)"
        >
          Confirm
        </el-button>
      </div>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import type { FormInstance } from "element-plus";
import { resetForm } from "~/composables/resetForm";

const data = reactive({
  dialogFormVisible: false,
  addBtnLoading: false,
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

const ${changeClassName}Store = use${className}Store();

async function add${className}(formRef: FormInstance | undefined) {
  if (!formRef) return;
  await formRef.validate(async (valid, fields) => {
    if (valid) {
      try {
        data.addBtnLoading = true;
        await ${changeClassName}Store.add${className}(data.form);
        data.addBtnLoading = false;
        ElNotification({
          title: "Success",
          message: "Save successfully",
          type: "success",
        });
        data.dialogFormVisible = false;
        resetForm(data.form);
      } catch (error) {
        console.log("exception occur:", error);
      }
    }
  });
}
</script>
