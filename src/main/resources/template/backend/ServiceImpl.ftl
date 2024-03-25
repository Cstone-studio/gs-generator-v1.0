package ${package}.service.impl;

import ${package}.convert.${className}Convert;
import ${package}.model.dto.base.IPageModel;
import ${package}.model.dto.${className}DTO;
import ${package}.model.dto.${className}PageDTO;
import ${package}.model.entity.jpa.db1.${className};
import ${package}.repository.jpa.db1.${className}Repository;
import ${package}.repository.jpa.db1.spec.${className}Specification;
import ${package}.service.intf.${className}Service;
import ${package}.utils.GsUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.util.Optional;

@Service
@Transactional(propagation = Propagation.SUPPORTS, transactionManager = "transactionManager" , readOnly = true, rollbackFor = Exception.class)
public class ${className}ServiceImpl implements ${className}Service {

    @Autowired
    private ${className}Repository ${changeClassName}Repository;

    @Autowired
    private ${className}Specification<${className}> ${changeClassName}Specification;

    @Autowired
    private ${className}Convert ${changeClassName}Convert;

    @Override
    public ${className}DTO create(${className}DTO dto) {
        ${className} ${changeClassName} = ${changeClassName}Repository.save(${changeClassName}Convert.toEntity(dto));
        return ${changeClassName}Convert.toDto(${changeClassName});
    }

    @Override
    public void update(${className}DTO dto) {

        ${className} ${changeClassName} = ${changeClassName}Convert.toEntity(dto);
        ${changeClassName}Repository.save(${changeClassName});
    }

    @Override
    public void delete(Integer id) {
        Optional<${className}> optionalNews = ${changeClassName}Repository.findById(id);
        if(optionalNews.isPresent()){
            ${className} ${changeClassName} = optionalNews.get();
            ${changeClassName}.setDeleted(true);
            ${changeClassName}Repository.save(${changeClassName});
            // ${changeClassName}Repository.deleteById(id);
        }
    }

    @Override
    public IPageModel<${className}DTO> list(${className}PageDTO param, Pageable pageable) {
        Page<${className}> ${changeClassName}Page = ${changeClassName}Repository.findAll(
                Specification.where(${changeClassName}Specification.mobileLike(param.getMobile()))
                        .and(${changeClassName}Specification.userNameEqualsTo(param.getUserName())
                        .and(${changeClassName}Specification.emailNotEqualsTo(param.getEmail()))), pageable
        );

        return GsUtils.pageConvert(${changeClassName}Page.map(entity -> ${changeClassName}Convert.toDto(entity)));
    }

    @Override
    public ${className}DTO findById(Integer id) {
        return ${changeClassName}Repository.findById(id).map(${changeClassName} -> ${changeClassName}Convert.toDto(${changeClassName})).orElse(null);
    }
}
