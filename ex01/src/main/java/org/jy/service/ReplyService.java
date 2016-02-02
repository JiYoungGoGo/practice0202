package org.jy.service;

import java.util.List;

import org.jy.domain.Criteria;
import org.jy.domain.ReplyVO;

public interface ReplyService {

	
	public List<ReplyVO> listReply(int bno,Criteria cri) throws Exception;
	
	public List<ReplyVO> listAll(int bno) throws Exception;
	
	public int count(int bno) throws Exception;
	
	public void addReply(ReplyVO vo) throws Exception;
	
	public void modifyReply(ReplyVO vo)throws Exception;
	
	public void removeReply(int rno) throws Exception;
	
}
