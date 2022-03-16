package com.taeate.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
    private int id;
    private String regDate;
    private String updateDate;
    private int memberId;
    private int relId;
    private String relTypeCode;
    private String body;
    private int hitCount;
    private int goodReactionPoint;
    private int badReactionPoint;

    private String extra__writerName;
    private boolean extra__actorCanDelete;
    private boolean extra__actorCanModify;

    public String getRegDateForPrint() {
        return regDate.substring(2,16);
    }
    public String getUpdateDateForPrint() {
        return updateDate.substring(2,16);
    }
    public String getForPrintType1RegDate() {
        return regDate.substring(2,16).replace(" ","<br>");
    }
    public String getForPrintType1UpdateDate() {
        return regDate.substring(2,16).replace(" ","<br>");
    }
    public String getForPrintType2RegDate() {
        return regDate.substring(2,16);
    }
    public String getForPrintType2UpdateDate() {
        return regDate.substring(2,16);
    }
}

