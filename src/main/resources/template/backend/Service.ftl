package ${package}.service.intf;

import ${package}.model.dto.base.IPageModel;
import ${package}.exception.IncorrectParameterException;
import ${package}.model.dto.request.${className}PageRequestDTO;
import ${package}.model.dto.request.${className}AddRequestDTO;
import ${package}.model.dto.request.${className}UpdateRequestDTO;
import ${package}.model.dto.response.${className}ResponseDTO;
import ${package}.model.entity.jpa.db1.${className};
import org.springframework.data.domain.Pageable;

/**
* @author ${author}
* @date ${date}
*/
public interface ${className}Service {

    /**
     * 创建
     */
    ${className}ResponseDTO create(${className}AddRequestDTO dto);

    /**
     * 更新
     */
    void update(${className}UpdateRequestDTO dto) throws IncorrectParameterException;

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
    IPageModel<${className}ResponseDTO> list(${className}PageRequestDTO param, Pageable pageable);

    /**
     * 根据id查找
     *
     * @param Integer id 主键id
     * @return ${className}DTO
     */
    ${className}ResponseDTO findById(Integer id);
}
