package com.gs.service.impl;

import com.gs.config.GenConfig;
import com.gs.model.entity.jpa.db1.vo.ColumnInfo;
import com.gs.model.entity.jpa.db1.vo.TableInfo;
import com.gs.service.intf.GeneratorService;
import com.gs.utils.GenUtils;
import com.gs.utils.PageUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import java.io.IOException;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

@Service
@Transactional(propagation = Propagation.SUPPORTS, transactionManager = "transactionManager" , readOnly = true, rollbackFor = Exception.class)
public class GeneratorServiceImpl implements GeneratorService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Object getTables(String name, int[] startEnd) {
        StringBuilder sql = new StringBuilder("select table_name tableName,create_time createTime from information_schema.tables where table_schema = (select database()) ");
        if(!ObjectUtils.isEmpty(name)){
            sql.append("and table_name like '%"+name+"%' ");
        }
        sql.append("order by table_name");
        Query query = em.createNativeQuery(sql.toString());
        query.setFirstResult(startEnd[0]);
        query.setMaxResults(startEnd[1]);

        System.out.println(sql.toString());
        List<Object[]> result = query.getResultList();
        List<TableInfo> tableInfos = new ArrayList<>();
        for (Object[] obj : result) {
            tableInfos.add(new TableInfo(obj[0],obj[1]));
        }
        Query query1 = em.createNativeQuery("SELECT COUNT(*) from information_schema.tables where table_schema = (select database())");
        Object totalElements = query1.getSingleResult();
        return PageUtils.toPage(tableInfos,totalElements);
    }

    @Override
    public List<ColumnInfo> getColumns(String name) throws SQLException {

        AtomicReference<String> databaseProductName = new AtomicReference<>("");
        Session session = em.unwrap(Session.class);
        session.doWork(connection -> {
            DatabaseMetaData metaData = connection.getMetaData();
            databaseProductName.set(metaData.getDatabaseProductName().toLowerCase());
        });

        StringBuilder sql = new StringBuilder();

        if (databaseProductName.toString().equals("mysql")) {
            sql.append("select column_name, is_nullable, data_type, column_comment, column_key from information_schema.columns where ");
            if(!ObjectUtils.isEmpty(name)){
                sql.append("table_name = '"+name+"' ");
            }
            sql.append("and table_schema = (select database()) order by ordinal_position");
        } else if (databaseProductName.toString().equals("postgresql")) {
            sql.append("SELECT column_name, is_nullable, data_type, COALESCE(col_description(pg_attribute.attrelid, pg_attribute.attnum), '') AS column_comment,\n" +
                    "CASE \n" +
                    "           WHEN pg_attribute.attnum = any(pg_index.indkey) THEN 'PRI' \n" +
                    "           ELSE '' \n" +
                    "       END AS column_key\n" +
                    "from information_schema.columns \n" +
                    "LEFT JOIN pg_attribute ON pg_attribute.attrelid = (SELECT oid FROM pg_class WHERE relname = '" + name + "') and column_name = pg_attribute.attname\n" +
                    "LEFT JOIN pg_index ON pg_index.indrelid = pg_attribute.attrelid\n" +
                    "where table_name = '" + name + "' \n" +
                    "AND table_schema = current_schema()\n" +
                    "ORDER BY ordinal_position;");
        }

        Query query = em.createNativeQuery(sql.toString());
        List<Object[]> result = query.getResultList();
        List<ColumnInfo> columnInfos = new ArrayList<>();
        for (Object[] obj : result) {
            columnInfos.add(new ColumnInfo(obj[0],obj[1],obj[2],obj[3],obj[4],null,"true"));
        }
        return columnInfos;
    }

    @Override
    public void generator(GenConfig genConfig, String tableName) {
        try {
            GenUtils.generatorCode(getColumns(tableName), genConfig, tableName);
        } catch (IOException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
