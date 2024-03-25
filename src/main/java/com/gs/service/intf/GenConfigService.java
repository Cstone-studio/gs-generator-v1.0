package com.gs.service.intf;

import com.gs.model.entity.jpa.db1.GenConfig;

/**
 * @author guozy
 * @date 2019-01-14
 */
//@CacheConfig(cacheNames = "genConfig")
public interface GenConfigService {

    /**
     * find
     * @return
     */
   //@Cacheable(key = "'1'")
    GenConfig find();

    /**
     * update
     * @param genConfig
     */
    //@CachePut(key = "'1'")
    GenConfig update(GenConfig genConfig);
}
