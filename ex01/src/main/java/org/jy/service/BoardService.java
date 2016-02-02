package org.jy.service;

import java.util.List;

import org.jy.domain.BoardVO;
import org.jy.domain.Criteria;
import org.jy.domain.SearchCriteria;

public interface BoardService {

	public List<BoardVO> viewAll()throws Exception;
	
	public void regist(BoardVO vo) throws Exception;

	public BoardVO view(int bno) throws Exception;

	public void modify(BoardVO vo) throws Exception;

	public void remove(int bno) throws Exception;
	
	public List<BoardVO> listCri(Criteria cri) throws Exception; 
	
	public int totalListCount() throws Exception;
	
	public List<BoardVO> searchList(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	public Integer getRegentBno() throws Exception;
}
