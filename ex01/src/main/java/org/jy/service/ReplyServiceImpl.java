package org.jy.service;

import java.util.List;

import javax.inject.Inject;

import org.jy.domain.Criteria;
import org.jy.domain.ReplyVO;
import org.jy.persistence.ReplyDAO;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;
	
	
	@Override
	public List<ReplyVO> listReply(int bno,Criteria cri) throws Exception {
		
		return dao.listpage(bno,cri);
	}

	@Override
	public void addReply(ReplyVO vo) throws Exception {
	
		dao.create(vo);

	}

	@Override
	public void modifyReply(ReplyVO vo) throws Exception {
		
		dao.modify(vo);

	}

	@Override
	public void removeReply(int rno) throws Exception {
		
		dao.delete(rno);

	}

	@Override
	public int count(int bno) throws Exception {
		
		return dao.count(bno);
	}

	@Override
	public List<ReplyVO> listAll(int bno) throws Exception {
		
		return dao.list(bno);
	}

}
