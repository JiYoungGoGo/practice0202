package org.jy.persistence;

import java.util.List;

import org.jy.domain.BoardVO;
import org.jy.domain.Criteria;
import org.jy.domain.SearchCriteria;

public interface BoardMapper {
	
	
	public List<BoardVO> allList() throws Exception;

	public void create(BoardVO vo) throws Exception;

	public BoardVO read(int bno) throws Exception;

	public void update(BoardVO vo) throws Exception;

	public void delete(int bno) throws Exception;

	public List<BoardVO> listPage(int page) throws Exception;
	
	public List<BoardVO> listCri(Criteria cri) throws Exception;
	
	public int totalCount() throws Exception;
	
	public List<BoardVO> searchList(SearchCriteria cri) throws Exception;
	
	public int listSearchCount(SearchCriteria cri)throws Exception;
	
	public Integer maxBno() throws Exception;
	
}
