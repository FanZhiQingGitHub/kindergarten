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

        String  img64Str = FaceRecognitionUtils.fileToBase64("F:\\kindergarten\\src\\main\\webapp\\image\\logo\\parent1.jpg");
//
        System.out.println(img64Str);
//
//        FaceRecognitionUtils.identify(img64Str,null);
//

        if ( FaceRecognitionUtils.faceRegister(img64Str,0)){

            System.out.println("成功");
        }else {
            System.out.println("失败");
        }


    }
}
