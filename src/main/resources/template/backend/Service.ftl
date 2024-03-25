package ${package}.service.intf;

import ${package}.model.dto.base.IPageModel;
import ${package}.model.dto.${className}DTO;
import ${package}.model.dto.${className}PageDTO;
import ${package}.model.entity.jpa.db1.${className};
import org.springframework.data.domain.Pageable;

/**
* @author ${author}
* @date ${date}
*/
public interface ${className}Service {

    /**
     * 创建
     *
     * @param ${className}DTO dto ${className}dto
     * @return ${className}DTO 创建成功后的dto
     */
    ${className}DTO create(${className}DTO dto);

    /**
     * 更新
     *
     * @param ${className}DTO dto ${className}dto
     */
    void update(${className}DTO dto);

    /**
     * 删除
     *
     * @param Integer id ${className} id
     */
    void delete(Integer id);

    /**
     * 分页查询
     *
     * @param param ${className}PageDTO
     */
    IPageModel<${className}DTO> list(${className}PageDTO param, Pageable pageable);

    /**
     * 根据id查找
     *
     * @param Integer id 主键id
     * @return ${className}DTO
     */
    ${className}DTO findById(Integer id);
}
