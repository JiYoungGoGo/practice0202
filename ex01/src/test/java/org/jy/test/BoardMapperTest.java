package org.jy.test;

import java.util.Iterator;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.jy.domain.BoardVO;
import org.jy.domain.Criteria;
import org.jy.domain.SearchCriteria;
import org.jy.persistence.BoardMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/*.xml" })
public class BoardMapperTest {

	private static final Logger logger = LoggerFactory.getLogger(BoardMapperTest.class);

	@Autowired
	private BoardMapper mapper;

	
	@Test
	public void createTest() throws Exception {

		for (int i = 0; i < 38; i++) {

			BoardVO vo = new BoardVO();

			vo.setTitle("제목" + i);
			vo.setText("내용내용" + i);
			vo.setWriter("사람" + i);

			mapper.create(vo);

		}

	}

	@Test
	public void pagingTest() throws Exception {

		logger.info(mapper.listPage(8).toString());

	}

	@Test
	public void criPagingTest() throws Exception {

		Criteria cri = new Criteria();

		cri.setPage(1);
		cri.setPerPageNum(20);
		logger.info(mapper.listCri(cri).toString());

	}

	@Test
	public void totalCount() throws Exception {

		logger.info("=================");
		mapper.totalCount();
		logger.info("=================");
	}

	@Test
	public void testUri() throws Exception {

		UriComponents uriComponents = UriComponentsBuilder.newInstance().path("/board/read").queryParam("bno", 12)
				.queryParam("perPageNum", 20).build();

		logger.info("==========" + uriComponents.toString());

	}

	@Test
	public void testDynamic1() throws Exception {

		SearchCriteria cri = new SearchCriteria();

		cri.setPage(1);
		cri.setSearchType("tcw");
		cri.setKeyword("꼬");

		logger.info("===========================");

		List<BoardVO> list = mapper.searchList(cri);

		for (BoardVO boardVO : list) {
			logger.info(boardVO.getBno() + " : " + boardVO.getTitle());
		}

		logger.info("============================");

	}

	@Test
	public void testCount() throws Exception {
		SearchCriteria cri = new SearchCriteria();

		cri.setPage(1);
		cri.setSearchType("tcw");
		cri.setKeyword("꼬");

		logger.info("COUNT: " + mapper.listSearchCount(cri));
	}

	@Test
	public void testMax() throws Exception{
		logger.info("==================");
		logger.info("------------------"+mapper.maxBno());
		
		
	}
	
}
