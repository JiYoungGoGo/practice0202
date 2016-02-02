package org.jy.persistence;

import java.util.List;

import org.jy.domain.Criteria;
import org.jy.domain.ReplyVO;

public interface ReplyDAO {

	public List<ReplyVO> listpage(int bno,Criteria cri) throws Exception;
	
	public List<ReplyVO> list(int bno) throws Exception;
	
	public int count(int bno)throws Exception;
	
	public void create(ReplyVO vo) throws Exception;
	
	public void modify(ReplyVO vo) throws Exception;
	
	public void delete(int rno) throws Exception;
	
}
