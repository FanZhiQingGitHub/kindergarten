package com.great.kindergarten.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 时间日期工具类
 */
public class DateUtil {

    /**
     * 根据日期确定对应星期是多少
     * @param dt
     * @return
     */
    public static String getWeekOfDate(Date dt) {
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return weekDays[w];
    }

    /**
     * 得到本周周一日期
     *
     * @return yyyy-MM-dd
     */
    public static String getMondayOfThisWeek(int startdays) {
        SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
        Calendar c = Calendar.getInstance();
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (day_of_week == 0)
            day_of_week = 7;
        c.add(Calendar.DATE, -day_of_week + startdays);//获取本周一，下周一就是+7，上周一就是-7
        return format.format(c.getTime());
    }

    /**
     * 得到本周周日日期
     *
     * @return yyyy-MM-dd
     */
    public static String getSundayOfThisWeek(int lastdays) {
        int days = 7;
        SimpleDateFormat format = new SimpleDateFormat("YYYY-MM-dd");
        Calendar c = Calendar.getInstance();
        int day_of_week = c.get(Calendar.DAY_OF_WEEK) - 1;
        if (day_of_week == 0)
            day_of_week = 7;
        c.add(Calendar.DATE, -day_of_week + lastdays);//获取本周日，下周日就是+7，上周日就是-7
        return format.format(c.getTime());
    }

}
