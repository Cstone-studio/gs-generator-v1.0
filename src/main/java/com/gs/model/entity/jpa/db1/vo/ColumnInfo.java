package com.gs.model.entity.jpa.db1.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 列的数据信息
 * @author guozy
 * @date 2019-01-02
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ColumnInfo {

    /** 数据库字段名称 **/
    private Object columnName;

    /** 允许空值 **/
    private Object isNullable;

    /** 数据库字段类型 **/
    private Object columnType;

    /** 数据库字段注释 **/
    private Object columnComment;

    /** 数据库字段键类型 **/
    private Object columnKey;

    /** 查询 1:模糊 2：精确 **/
    private String columnQuery;

    /** 是否在列表显示 **/
    private String columnShow;
}
