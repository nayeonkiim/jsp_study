package com.board;

import java.io.File;

//게시판 유틸 관련 자바 파일
public class UtilMgr {
	public static String replace(String str, String pattern, String replace) {
		int s=0, e=0;
		//String인데 수정이 가능함.
		StringBuffer result = new StringBuffer();
	
		//s에서 시작해서 pattern을 str에서 존재한다면
		while((e = str.indexOf(pattern, s))>=0) {
			result.append(str.substring(s,e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));
		return result.toString();
	}
	
	public static void delete(String s) {
		File file = new File(s);
		if(file.isFile()) {
			file.delete();
		}
	}
	
	//첨부파일 다운로드시 파일에 대한 경로와 파일명이 필요한데 여기서 한글 깨지지 않도록 인코딩 방식 변경
	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"),"ksc5601");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}
