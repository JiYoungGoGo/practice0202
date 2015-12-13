package org.jy.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.jy.domain.BoardVO;
import org.jy.domain.Criteria;
import org.jy.domain.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
@Controller
public class BoardMapperImpl implements BoardMapper {

	@Autowired
	private SqlSession session;
	
	public static String namespace = "org.jy.persistence.BoardMapper";
	
	@Override
	public List<BoardVO> allList() throws Exception {
		List<BoardVO> list = session.selectList(namespace+".allList");
		
		return list;
	}

	@Override
	public void create(BoardVO vo) throws Exception {
		session.insert(namespace+".create", vo);

	}

	@Override
	public BoardVO read(int bno) throws Exception {
		BoardVO vo = session.selectOne(namespace+".read",bno);
		return vo;
	}

	@Override
	public void update(BoardVO vo) throws Exception {
		session.update(namespace+".update",vo);

	}

	@Override
	public void delete(int bno) throws Exception {
		session.delete(namespace+".delete",bno);

	}

	@Override
	public List<BoardVO> listPage(int page) throws Exception {
		
		if(page<=0){
			page=1;
		}
		System.out.println("---------page: "+page);
		return session.selectList(namespace+".listPage",page);
	}

	@Override
	public List<BoardVO> listCri(Criteria cri) throws Exception {

		System.out.println("--------page: "+cri.getPage());
		System.out.println("--------perPageNum: "+cri.getPerPageNum());
		
		
		return session.selectList(namespace+".listCri", cri);
	}

	@Override
	public int totalCount() throws Exception {
		
		return session.selectOne(namespace+".totalCount");
	}

	@Override
	public List<BoardVO> searchList(SearchCriteria cri) throws Exception {
		
		return session.selectList(namespace+".searchList", cri);
	}

	@Override
	public int searchCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(namespace+".searchCount", cri);
	}

}
