package com.gs;

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

    @Test
    public void test() {

        Object object = generatorService.getColumns("user");

        System.out.println("test start");
    }
}
