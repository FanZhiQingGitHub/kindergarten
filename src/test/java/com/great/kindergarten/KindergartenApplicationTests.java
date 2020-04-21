package com.great.kindergarten;

import com.great.kindergarten.util.FaceRecognitionUtils;
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

        String  img64Str = FaceRecognitionUtils.fileToBase64("C:\\Users\\JK\\Documents\\WeChat Files\\All Users\\liu.png");
//
        System.out.println(img64Str);
//
//        FaceRecognitionUtils.identify(img64Str,null);
//
        FaceRecognitionUtils.faceRegister(img64Str,"testPhoto1");

    }
}
