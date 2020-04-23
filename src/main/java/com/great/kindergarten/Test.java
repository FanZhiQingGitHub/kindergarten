package com.great.kindergarten;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class Test
{
	public static void main(String[] args) throws UnknownHostException {
//		String x = "12:00";
//		System.out.println(x.compareTo("01:45"));
//		System.out.println(x.compareTo("12:00"));
//		System.out.println(x.compareTo("23:00"));

		InetAddress addr = InetAddress.getLocalHost();
		System.out.println("Local HostAddress:"+addr.getHostAddress());
		String hostname = addr.getHostName();
		System.out.println("Local host name: "+hostname);
	}

}