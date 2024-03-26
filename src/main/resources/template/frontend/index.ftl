<template>
  <div>
    <!-- <CommonTagsView title="${className}" /> -->
    <CommonContentContainer>
      <template #content>
        <${className}Search ref="${changeClassName}Search" />
      </template>
    </CommonContentContainer>
    <CommonContentContainer>
      <template #content>
        <${className}BtnGroup ref="${changeClassName}BtnGroup" />
      </template>
    </CommonContentContainer>
    <CommonContentContainer>
      <template #content>
        <${className}Table ref="${changeClassName}Table" :search-form="{}" />
      </template>
    </CommonContentContainer>
  </div>
</template>

<script setup lang="ts">
definePageMeta({
  layout: "default",
});

const data = reactive({});
</script>
