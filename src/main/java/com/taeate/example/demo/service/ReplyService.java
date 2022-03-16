package com.taeate.example.demo.service;

import java.util.List;

import com.taeate.example.demo.Repository.ReplyRepository;
import com.taeate.example.demo.util.Ut;
import com.taeate.example.demo.vo.Member;
import com.taeate.example.demo.vo.Reply;
import com.taeate.example.demo.vo.ResultData;

import org.springframework.stereotype.Service;

@Service
public class ReplyService {
	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	public ResultData writeReply(int actorId, String relTypeCode, int relId, String body) {
		replyRepository.writeReply(actorId, relTypeCode, relId, body);
		int id = replyRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 댓글이 생성되었습니다.", id), "id", id);
	}

    public List<Reply> getForPrintReplies(Member actor, String relTypeCode, int relId) {
       return replyRepository.getForPrintReplies(relTypeCode,relId);
    }
}
