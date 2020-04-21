package com.great.kindergarten;

public class Test
{
	public static void main(String[] args)
	{
		String x = "12:00";
		System.out.println(x.compareTo("01:45"));
		System.out.println(x.compareTo("12:00"));
		System.out.println(x.compareTo("23:00"));
	}

}