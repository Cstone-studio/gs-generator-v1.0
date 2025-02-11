package ${package}.convert;

import ${package}.model.dto.request.${className}PageRequestDTO;
import ${package}.model.dto.request.${className}AddRequestDTO;
import ${package}.model.dto.request.${className}UpdateRequestDTO;
import ${package}.model.dto.response.${className}ResponseDTO;
import ${package}.model.entity.jpa.db1.${className};
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

/**
* author ${author}
* date ${date}
*/
@Mapper(componentModel = "spring" ,unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ${className}Convert {
    ${className}Convert INSTANCE = Mappers.getMapper( ${className}Convert.class );

    ${className}ResponseDTO toDto(${className} source);

    ${className} toEntity(${className}AddRequestDTO source);
}
