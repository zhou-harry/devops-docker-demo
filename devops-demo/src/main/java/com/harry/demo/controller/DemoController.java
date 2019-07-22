package com.harry.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author zhouhong
 * @version 1.0
 * @title: DemoController
 * @description: TODO
 * @date 2019/7/22 11:27
 */
@RestController
public class DemoController {

    @GetMapping("index")
    public String index() {
        return "welcome...";
    }

}
