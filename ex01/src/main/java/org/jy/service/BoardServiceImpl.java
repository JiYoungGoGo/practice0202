package org.jy.service;

import java.util.List;

import org.jy.domain.BoardVO;
import org.jy.domain.Criteria;
import org.jy.domain.SearchCriteria;
import org.jy.persistence.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class BoardServiceImpl implements BoardService {

	@Autowired
	//impl 인가 아닌가(12.06)
	BoardMapper bomap;
	
	@Override
	public List<BoardVO> viewAll() throws Exception {
		
		return bomap.allList();
	}

	@Override
	public void regist(BoardVO vo) throws Exception {
		bomap.create(vo);
		
	}

	@Override
	public BoardVO view(int bno) throws Exception {
		
		return bomap.read(bno);
	}

	@Override
	public void modify(BoardVO vo) throws Exception {
		
		bomap.update(vo);
		
	}

	@Override
	public void remove(int bno) throws Exception {
		
		bomap.delete(bno);
	}

	@Override
	public List<BoardVO> listCri(Criteria cri) throws Exception {
		System.out.println("boardServiceImpl에 들어왔다. ");
		return bomap.listCri(cri);
	}

	@Override
	public int totalListCount() throws Exception {
		
		return bomap.totalCount();
	}

	@Override
	public List<BoardVO> searchList(SearchCriteria cri) throws Exception {
		
		return bomap.searchList(cri);
	}

	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		
		return bomap.listSearchCount(cri);
	}

	@Override
	public Integer getRegentBno() throws Exception {
		
		return bomap.maxBno();
	}


}
