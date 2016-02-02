package org.jy.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.jy.domain.Criteria;
import org.jy.domain.ReplyVO;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	
	@Inject
	private SqlSession session;
	
	
	private static String namespace = "org.jy.persistence.ReplyDAO";
	
	@Override
	public List<ReplyVO> listpage(int bno,Criteria cri) throws Exception {
		
		Map<String,Object> paramMap = new HashMap<>();
		
		paramMap.put("bno", bno);
		
		paramMap.put("cri", cri);
		
		return session.selectList(namespace+".listpage", paramMap);
	}

	@Override
	public void create(ReplyVO vo) throws Exception {
		
		session.insert(namespace+".create", vo);
	}

	@Override
	public void modify(ReplyVO vo) throws Exception {
		
		session.update(namespace+".modify", vo);

	}

	@Override
	public void delete(int rno) throws Exception {
		
		session.delete(namespace+".delete", rno);

	}

	@Override
	public int count(int bno) throws Exception {
		
		return session.selectOne(namespace+".count", bno);
	}

	@Override
	public List<ReplyVO> list(int bno) throws Exception {
		
		return session.selectList(namespace+".list", bno);
	}

}
