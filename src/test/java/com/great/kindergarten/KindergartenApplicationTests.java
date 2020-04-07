package com.great.kindergarten;

import com.great.kindergarten.util.MD5Utils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class KindergartenApplicationTests {

    @Test
    void contextLoads() {


    }

    public static void main(String[] args)
    {
        System.out.println(MD5Utils.md5("123456"));
    }
}
