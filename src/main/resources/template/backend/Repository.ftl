package ${package}.repository.jpa.db1;

import ${package}.model.entity.jpa.db1.${className};
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import java.util.Optional;

/**
* author ${author}
* date ${date}
*/
public interface ${className}Repository extends JpaRepository<${className}, Integer>, JpaSpecificationExecutor<${className}>  {
}
