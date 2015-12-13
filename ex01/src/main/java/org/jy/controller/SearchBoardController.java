package org.jy.controller;

import java.util.List;

import org.jy.domain.BoardVO;
import org.jy.domain.PageMaker;
import org.jy.domain.SearchCriteria;
import org.jy.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {

	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	
	@Autowired
	private BoardService service;
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void list(@ModelAttribute("cri")SearchCriteria cri, Model model) throws Exception{
		
		logger.info("===========list에 들어왔당.");
		logger.info("======page: "+cri.getPage());
		logger.info("======perPageNum: "+cri.getPerPageNum());
		logger.info("======searchType: "+cri.getSearchType());
		logger.info("======keyword: "+cri.getKeyword());
		
		 List<BoardVO> list = service.listCri(cri);
		
		logger.info("==========service에서 알맞은 list잘 가져옴===========");
		
		model.addAttribute("list", list);
		
		//하단 페이징 처리 부분을 위한 정보 
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
		
		pageMaker.setTotalCount(service.totalListCount());
		
		logger.info("=========전체 갯수도 잘 가져옴=========");
		
		model.addAttribute("pageMaker", pageMaker);
		
	
	}
	
	
}
