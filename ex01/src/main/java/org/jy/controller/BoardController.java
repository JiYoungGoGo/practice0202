package org.jy.controller;

import java.util.List;

import org.jy.domain.BoardVO;
import org.jy.domain.Criteria;
import org.jy.domain.PageMaker;
import org.jy.service.BoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardService service;
	
	@RequestMapping(value="/register",method=RequestMethod.GET)
	public void registerGet(BoardVO board, Model model) throws Exception{
		
		logger.info("등록 GET 페이지에 들어왔다. ");
		
	}
	
	@RequestMapping(value="/register",method=RequestMethod.POST)
	public String registerPost(BoardVO board, RedirectAttributes rttr) throws Exception{
		
		logger.info("등록 POST 페이지에 들어왔다. ");
		logger.info("보드: "+board.toString());
		
		service.regist(board);
		logger.info("서비스에 등록했다.");
		
		rttr.addFlashAttribute("msg", "SUCCESS");
		//model.addAttribute("result","SUCCESS");
		
		//return "/board/success";

		return "redirect:/board/listPage";
	}
	
	@RequestMapping(value="/listPage", method=RequestMethod.GET)
	public void listPage(@ModelAttribute("cri")Criteria cri, Model model) throws Exception{
		
		logger.info("==========pageMaker 쓰는 List");
		
		model.addAttribute("list", service.listCri(cri));
		
		//하단 페이징 처리 부분:
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
		//pageMaker.setTotalCount(1160);
		
		pageMaker.setTotalCount(service.totalListCount());
		
		model.addAttribute("pageMaker", pageMaker);
		
		
		
	}
	
	
	@RequestMapping(value="/listCri",method=RequestMethod.GET)
	public void listCriteria(Criteria cri, Model model) throws Exception{
		
		logger.info("Criteria로 페이징!! cri: "+cri);
		
		model.addAttribute("list", service.listCri(cri));
		

	}
	
	@RequestMapping(value="/list" , method=RequestMethod.GET)
	public void listGet(Model model) throws Exception{
		
		logger.info("리스트 페이지에 들어왔다. ");
	 	List<BoardVO> list= service.viewAll();
		logger.info("서비스에서 목록 받아왔당");
		
		model.addAttribute("list", list);
		
	}
	
	@RequestMapping(value="readPage", method=RequestMethod.GET)
	public void readPage(@RequestParam("bno")int bno,@ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		
		logger.info("================ cri 정보 물고 있는 read");
		logger.info("=========cri정보: "+cri.getPage() +" : "+cri.getPerPageNum());
		model.addAttribute("VO", service.view(bno));
		
		
	}
	
	
	
	@RequestMapping(value="/read", method=RequestMethod.GET)
	public void readGet(@RequestParam("bno") int bno, Model model) throws Exception{
		
		logger.info("게시물에 들어왔다. ");
		logger.info("들어온 파라메터: "+bno);
		
		BoardVO vo = service.view(bno);
		
		logger.info("서비스에서 받아왔다. bno보드");
		
		model.addAttribute("VO", vo);
		
		
	}
	
	@RequestMapping(value="/removePage", method=RequestMethod.POST)
	public String removePage(@RequestParam("bno")int bno, Criteria cri, RedirectAttributes rttr) throws Exception{
		
		logger.info("==================cri물고 있는 remove");
		service.remove(bno);
		logger.info("============지웠당 ");
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum",cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "DELETE");
		
		return "redirect:/board/listPage";
		
	}
	
	
	@RequestMapping(value="/remove", method=RequestMethod.POST)
	public String removePost(@RequestParam("bno") int bno, RedirectAttributes rttr)throws Exception{
		
		logger.info("삭제하러 왔다. ");
		
		service.remove(bno);
		
		logger.info("DB에서 삭제했다. ");
		
		rttr.addFlashAttribute("msg", "DELETE");
		
		return "redirect:/board/list";
		
	}
	
	@RequestMapping(value="/modifyPage",method=RequestMethod.GET)
	public void modifyPage(@RequestParam("bno")int bno, @ModelAttribute("cri")Criteria cri, Model model) throws Exception{
		
		logger.info("일단 Paging 하며 수정하는 페이지에 들어왔다. ");
		
		model.addAttribute("VO", service.view(bno));
		
		logger.info("========수정해야 하는 정보 받아왔다. ");
		
	}
	
	@RequestMapping(value="/modifyPage", method=RequestMethod.POST)
	public String modifyPagePost(BoardVO vo, Criteria cri, RedirectAttributes rttr) throws Exception{
		
		logger.info("수정 post 처리 하려고 들어왔당");
		service.modify(vo);
		logger.info("수정했당");
		
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "MODIFY");
		
		return "redirect:/board/listPage";
		
	}
	
	
	
	
	
	@RequestMapping(value="/modify", method=RequestMethod.GET)
	public void modifyGet( @RequestParam("bno") int bno,Model model) throws Exception{
		
		logger.info("수정하러 왔다. GET");
		
		BoardVO vo =service.view(bno);
		
		logger.info("수정하려는 내용 받아왔다. ");
		
		model.addAttribute("VO", vo);

	}
	
	@RequestMapping(value="/modify" , method=RequestMethod.POST)
	public String modifyPost(BoardVO vo,RedirectAttributes rttr) throws Exception{
		
		logger.info("수정처리할라고 들어왔다POST");
		
		service.modify(vo);
		
		logger.info("수정처리되었다. ");
		
		rttr.addFlashAttribute("msg", "MODIFY");
		
		return "redirect:/board/list";

	}
	
	
	
}
