package org.jy.controller;

import java.io.InputStream;
import java.net.URL;
import java.util.List;

import org.jy.domain.BoardVO;
import org.jy.domain.PageMaker;
import org.jy.domain.SearchCriteria;
import org.jy.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/sboard/*")
public class SearchBoardController {

	private static final Logger logger = LoggerFactory.getLogger(SearchBoardController.class);
	
	
	@Autowired
	private BoardService service;
	
	@RequestMapping(value="/list1", method=RequestMethod.GET)
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
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public void listPage(SearchCriteria cri, Model model)throws Exception{
		
		logger.info("============================");
		logger.info("이제 검색도 하면서 페이징도 할것이다.");
		
		model.addAttribute("list", service.searchList(cri));
		
		logger.info("list 잘 가져왔다.");
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		logger.info("pageMaker에 total 값 잘 집어넣었당");
		
		model.addAttribute("pageMaker", pageMaker);
		
		model.addAttribute("cri", cri);
		
	}
	

	
	
	@RequestMapping(value="/remove",method=RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, SearchCriteria cri, RedirectAttributes rttr) throws Exception{
		
		logger.info("----------------이제 지울거임----------------");
		
		service.remove(bno);
		
		logger.info("---------------지웠다---------------");
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("msg", "DELETE");
		
		return "redirect:/sboard/list";
	}
	
	@RequestMapping(value="/modify",method=RequestMethod.GET)
	public void modifyGet(@RequestParam("bno") int bno, SearchCriteria cri, Model model) throws Exception{
		
		logger.info("-------------수정페이지 들어왔다------------");
		
		model.addAttribute("VO", service.view(bno));
		model.addAttribute("cri", cri);
	
	}

	
	@RequestMapping(value="/modify",method=RequestMethod.POST)
	public String modifyPost(BoardVO vo, SearchCriteria cri, RedirectAttributes rttr, int bno)throws Exception{
		
		logger.info("--------------수정이제 할거다-----------------");
		
		service.modify(vo);
		
		logger.info("------------어떻게 된걸까??: "+cri.toString());


		
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("bno", bno);
		
		logger.info("===================여기까진 됐을까");
		
		rttr.addFlashAttribute("msg", "MODIFY");
		
		return "redirect:/sboard/read";
	}
	
	@RequestMapping(value="/read",method=RequestMethod.GET)
	public void read(SearchCriteria cri, Model model, @RequestParam("bno") int bno) throws Exception{
		
		logger.info("==========================");
		logger.info("read 페이지에 잘들어옴");
		model.addAttribute("VO", service.view(bno));
		model.addAttribute("cri", cri);
		
		
		
	}
	
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public void register() throws Exception{
		
		logger.info("--------------등록페이지 가려고-------------");
	}
	
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public String registerPost(BoardVO vo, RedirectAttributes rttr)throws Exception{
		
		logger.info("------------등록 하려고------------");
		
		service.regist(vo);
		
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		int bno = service.getRegentBno();
		
		String path ="http://192.168.0.19:8082/"+bno;
	    
		logger.info("#####################"+path);
		
		URL url = new URL(path);      
	    
		logger.info("--------------------------일단 보내긴한ㄷ거");
		
        InputStream in = url.openStream();
		
        logger.info("---------------------------여기까진 되니?");
	    in.close();

	    logger.info("~~~~~~~~~~~~~~~~~~~~~~~연결끝");
		
		return "redirect:/sboard/list";
	}
	
	
	@RequestMapping(value="/test/{bno}")
	public ResponseEntity<BoardVO> getBoard(@PathVariable("bno")int bno){
		
		ResponseEntity<BoardVO> entity = null;
		System.out.println("--------------------------------객체 가져갈라고 들어옴");
		try {
		
			entity = new ResponseEntity<>(service.view(bno),HttpStatus.OK);
			System.out.println("--------------------------------가져와짐");
		} catch (Exception e) {
			
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.OK);
			System.out.println("--------------------------------에러남");
		}
		
		System.out.println("--------------------------------처리됨");
		return entity;
		
	}
	
}
