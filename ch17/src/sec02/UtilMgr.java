package sec02;

public class UtilMgr {
	
	// pattern을 replace 로 바꿈
	public static String replace(String str, String pattern, String replace) {
		int s=0, e=0;
		StringBuffer result = new StringBuffer();
		
		// indexOf(searchValue, fromIndex)
		//: searchValue는 탐색하고 싶은 문자열, fromIndex는 fromIndex의 숫자부터 탐색시작
		// substring(from, to)
		//: from ~ to 사이 문자
		while((e = str.indexOf(pattern, s))>=0) {
			// pattern이 시작되기 전까지가 result에 저장
			result.append(str.substring(s,e));
			// pattern 대신 replace를 그 뒤에 붙여줌
			result.append(replace);
			//pattern의 길이 만큼 e 뒤에 붙여줌
			s = e + pattern.length();
		}
		// 뒤에 더 남아있는 것들
		result.append(str.substring(s));
		return result.toString();
	}
}
