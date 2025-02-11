package com.gs.service.intf;

import com.gs.config.GenConfig;
import com.gs.model.entity.jpa.db1.vo.ColumnInfo;

import java.sql.SQLException;
import java.util.List;

public interface GeneratorService {

    /**
     * 查询数据库元数据
     * @param name
     * @param startEnd
     * @return
     */
    Object getTables(String name, int[] startEnd);

    /**
     * 得到数据表的元数据
     * @param name
     * @return
     */
    List<ColumnInfo> getColumns(String name) throws SQLException;

    /**
     * 生成代码
     * @param genConfig
     * @param tableName
     */
    void generator(GenConfig genConfig, String tableName);
}
