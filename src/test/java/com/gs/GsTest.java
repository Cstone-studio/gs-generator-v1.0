package com.gs;

import com.gs.config.GenConfig;
import com.gs.service.intf.GeneratorService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class GsTest {

    @Autowired
    private GeneratorService generatorService;

    @Autowired
    private GenConfig genConfig;

    @Test
    public void test() {
        generatorService.generator(genConfig, "user");
    }
}
