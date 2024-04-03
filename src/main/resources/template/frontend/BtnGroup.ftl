<template>
  <div>
    <el-button type="success" plain @click="data.dialogFormVisible = true" size="small"
      >Add</el-button
    >
  </div>
  <el-dialog v-model="data.dialogFormVisible" title="Add ${className}" width="500">
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
            <#if column.columnType == "BigDecimal">
              <el-input-number v-model="data.form.${column.changeColumnName}" :precision="2" :step="0.1" autocomplete="off" />
            <#elseif column.columnType == "Timestamp">
              <el-date-picker v-model="data.form.${column.changeColumnName}" type="datetime" placeholder="Select date and time" autocomplete="off" />
            <#else>
              <el-input v-model<#if column.changeColumnName?ends_with("Id")>.number</#if>="data.form.${column.changeColumnName}" autocomplete="off" />
            </#if>
            </el-form-item>
          </#if>
        </#list>
      </#if>
    </el-form>

    <template #footer>
      <div class="dialog-footer">
        <el-button @click="data.dialogFormVisible = false" size="small">Cancel</el-button>
        <el-button
          :loading="data.addBtnLoading"
          type="primary"
          @click.prevent="add${className}(formRef)"
          size="small"
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
        reset(); // 新增后清除检索条件并自动检索画面
      } catch (error) {
        console.log("exception occur:", error);
      }
    }
  });
}

  const reset = () => {
    ${changeClassName}Store.resetParams();
    ${changeClassName}Store.get${className}s();
  };

</script>
