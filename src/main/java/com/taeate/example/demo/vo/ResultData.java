package com.taeate.example.demo.vo;

import lombok.Getter;
import lombok.ToString;

@ToString
public class ResultData {
	@Getter
	private String resultCode;
	@Getter
	private String msg;
	@Getter
	private String data1Name;
	@Getter
	private Object data1;
	@Getter
	private String data2Name;
	@Getter
	private Object data2;
	

	public static ResultData from(String resultCode, String msg) {
		return from(resultCode, msg, null, null);
	}

	public static ResultData from(String resultCode, String msg, String data1Name ,Object data1) {
		ResultData rd = new ResultData();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;
		
		return rd;
	}
	
	public boolean isSuccess() {
		return resultCode.startsWith("S-");
	}
	
	public boolean isFail() {
		return isSuccess() == false;
	}

    public static ResultData newData(ResultData oldRd, String data1Name, Object Data) {
        return from(oldRd.getResultCode(),oldRd.getMsg(), data1Name, Data);
    }

    public void setData2(String dataName, Object data) {
		data2Name = dataName;
		data2 = data;
	}

}