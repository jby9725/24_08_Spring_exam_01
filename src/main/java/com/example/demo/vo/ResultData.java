package com.example.demo.vo;

import lombok.Getter;

public class ResultData<DT> {
	// 성공S/실패F
	@Getter
	private String ResultCode;
	// 자세한 메세지
	@Getter
	private String msg;
	// 함께 처리할 데이터, 여기서는 Article, Member, List 여러 형태가 있음.
	@Getter
	private DT data1;

	private String data1Name;

	// data가 없는 경우
	public static <DT> ResultData<DT> from(String ResultCode, String msg) {
		return from(ResultCode, msg, null, null);
	}

	// data가 있는 경우
	// rd 객체를 생성하여 가져온 정보를 담고 리턴
	public static <DT> ResultData<DT> from(String ResultCode, String msg, String data1Name, Object data1) {
		ResultData rd = new ResultData();
		rd.ResultCode = ResultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;

		return rd;
	}

	public boolean isSuccess() {
		return ResultCode.startsWith("S-");
	}

	public boolean isFail() {
		return isSuccess() == false;
	}

	// 뒤의 data를 newData로 갱신.
	public static <DT> ResultData<DT> newData(ResultData rd, String data1Name, DT newData) {
		return from(rd.getResultCode(), rd.getMsg(), data1Name, newData);
	}

}