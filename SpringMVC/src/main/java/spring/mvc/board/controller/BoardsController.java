package spring.mvc.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import spring.mvc.board.AttachFile;
import spring.mvc.board.BoardService;
import spring.mvc.board.Comment;
import spring.mvc.board.Post;
import spring.mvc.commons.PagingHelper;
import spring.mvc.commons.WebContents;
import spring.mvc.user.User;

@Controller
@RequestMapping("/boards")
public class BoardsController {
	
	@Autowired
	private BoardService boardService;
	User user;
	
	@RequestMapping(value="/list", method={RequestMethod.GET, RequestMethod.POST})
	public String list(String boardcode, Integer curPage, String searchWord, Model model) throws Exception {
		if(boardcode == null) boardcode = "free";
		if (curPage == null) curPage = 1;
		if (searchWord == null) searchWord = "";

		int numPerPage = 10;// 페이지당 레코드 수 지정
		int pagePerBlock = 10;// 페이지 링크의 그룹(block)의 크기 지정

		int totalRecord = boardService.getTotalRecord(boardcode, searchWord);

		PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
		boardService.setPagingHelper(pagingHelper);

		int start = pagingHelper.getStartRecord();
		int end = pagingHelper.getEndRecord();

		ArrayList<Post> list = boardService.getPostList(boardcode, searchWord, start, end);
		String boardname = boardService.getBoardName(boardcode);
		Integer no = boardService.getListNo();
		Integer prevLink = boardService.getPrevLink();
		Integer nextLink = boardService.getNextLink();
		Integer firstPage = boardService.getFirstPage();
		Integer lastPage = boardService.getLastPage();
		int[] pageLinks = boardService.getPageLinks();
		
		model.addAttribute("list", list);
		model.addAttribute("boardname", boardname);
		model.addAttribute("boardcode", boardcode);
		
		model.addAttribute("no", no);
		model.addAttribute("prevLink", prevLink);
		model.addAttribute("nextLink", nextLink);
		model.addAttribute("firstPage", firstPage);
		model.addAttribute("lastPage", lastPage);
		model.addAttribute("pageLinks", pageLinks);
		model.addAttribute("curPage", curPage);// curPage는 null 값이면 1로 만들어야 하므로
		
		return "boards/list";
	}
	
	@RequestMapping(value="/writeForm", method=RequestMethod.POST)
    public String write(String boardcode, Model model) throws Exception {
       
        //게시판 이름
        String boardname = boardService.getBoardName(boardcode);
        model.addAttribute("boardname", boardname);
        return "boards/writeForm";
    }
   
    @RequestMapping(value="/write", method=RequestMethod.POST)
    public String write(Post post, MultipartHttpServletRequest mpRequest, HttpSession session) throws Exception {
    	User user = (User)session.getAttribute("check");
    	String nick = user.getNickname();
        post.setWriter(nick);
        boardService.insert(post);
        
        post.setPostno(boardService.getNewPost().getPostno());
        
        if(!mpRequest.getFile("upload").isEmpty()) {
	        List<MultipartFile> fileList = mpRequest.getFiles("upload");
	        for(MultipartFile mf : fileList){
	         String filename = mf.getOriginalFilename();
	         mf.transferTo(new File(WebContents.BASE_PATH + filename));
	        }
	        
	        int size = fileList.size();
	        for (int i = 0; i < size; i++) {
	         MultipartFile mpFile = fileList.get(i);
	         AttachFile attachFile = new AttachFile();
	         String filename = mpFile.getOriginalFilename();
	         attachFile.setFilename(filename);
	         attachFile.setFiletype(mpFile.getContentType());
	         attachFile.setFilesize(mpFile.getSize());
	         attachFile.setPostno(post.getPostno());
	         boardService.insertAttachFile(attachFile);
	        }
        }
        
        return "redirect:/boards/list?boardcode=" + post.getBoardcode();
    }
    
    @RequestMapping(value="/replyForm", method=RequestMethod.POST)
    public String reply(String boardcode, Model model) throws Exception {
       
        //게시판 이름
        String boardname = boardService.getBoardName(boardcode);
        model.addAttribute("boardname", boardname);
        return "boards/writeForm";
    }
    
    @RequestMapping(value="/reply", method=RequestMethod.POST)
    public String reply(Post post, Integer curPage, String searchWord, MultipartHttpServletRequest mpRequest, HttpSession session) throws Exception {
    	User user = (User)session.getAttribute("check");
    	String nick = user.getNickname();
        post.setWriter(nick);
        boardService.reply(post);
        
        post.setPostno(boardService.getNewPost().getPostno());
        
        if(!mpRequest.getFile("upload").isEmpty()) {
	        List<MultipartFile> fileList = mpRequest.getFiles("upload");
	        for(MultipartFile mf : fileList){
	         String filename = mf.getOriginalFilename();
	         mf.transferTo(new File(WebContents.BASE_PATH + filename));
	        }
	        
	        int size = fileList.size();
	        for (int i = 0; i < size; i++) {
	         MultipartFile mpFile = fileList.get(i);
	         AttachFile attachFile = new AttachFile();
	         String filename = mpFile.getOriginalFilename();
	         attachFile.setFilename(filename);
	         attachFile.setFiletype(mpFile.getContentType());
	         attachFile.setFilesize(mpFile.getSize());
	         attachFile.setPostno(post.getPostno());
	         boardService.insertAttachFile(attachFile);
	        }
        }
        return "redirect:/boards/list?boardcode=" + post.getBoardcode() + "&curPage=" + curPage + "&searchWord=" + searchWord;
    }

    @RequestMapping(value="/view", method=RequestMethod.GET)
    public String view(int postno, String boardcode, Integer curPage, String searchWord, Model model, HttpSession session) {
       
    	int numPerPage = 10;// 페이지당 레코드 수 지정
		int pagePerBlock = 10;// 페이지 링크의 그룹(block)의 크기 지정
		if (searchWord == null) searchWord = "";
    	
		// 목록보기
		int totalRecord = boardService.getTotalRecord(boardcode, searchWord);
		PagingHelper pagingHelper = new PagingHelper(totalRecord, curPage, numPerPage, pagePerBlock);
		boardService.setPagingHelper(pagingHelper);
		
		int start = pagingHelper.getStartRecord();
		int end = pagingHelper.getEndRecord();
		
		ArrayList<Post> list = boardService.getPostList(boardcode, searchWord, start, end);
		String boardname = boardService.getBoardName(boardcode);
		Integer no = boardService.getListNo();
        Integer prevLink = boardService.getPrevLink();
        Integer nextLink = boardService.getNextLink();
        Integer firstPage = boardService.getFirstPage();
        Integer lastPage = boardService.getLastPage();
        int[] pageLinks = boardService.getPageLinks();
        
		model.addAttribute("list", list);
		model.addAttribute("boardname", boardname);
		
		model.addAttribute("no", no);
        model.addAttribute("prevLink", prevLink);
        model.addAttribute("nextLink", nextLink);
        model.addAttribute("firstPage", firstPage);
        model.addAttribute("lastPage", lastPage);
        model.addAttribute("pageLinks", pageLinks);
        
    	Post thisPost = boardService.getPost(postno);
    	Post prevPost = boardService.getPrevPost(postno, boardcode, searchWord);
    	Post nextPost = boardService.getNextPost(postno, boardcode, searchWord);
    	ArrayList<AttachFile> attachFileList = boardService.getAttachFileList(postno);
    	ArrayList<Comment> commentList = boardService.getCommentList(postno);
        
    	String writer = thisPost.getWriter();
		if (session.getAttribute("check") != null) {
			User user = (User) session.getAttribute("check");
			String nick = user.getNickname();
			// 상세보기
			if (!nick.equals(writer)) {
				boardService.increaseHits(postno);
			}
		} else {
			boardService.increaseHits(postno);
		}
    	
        model.addAttribute("thisPost", thisPost);
        model.addAttribute("prevPost", prevPost);
        model.addAttribute("nextPost", nextPost);
        model.addAttribute("attachFileList", attachFileList);
        model.addAttribute("commentList", commentList);
        
        
        int del = thisPost.getDel();
        if(del == 1) {
        	model.addAttribute("msg", "삭제된 게시글입니다.");
    		model.addAttribute("url", "back");
        	return "redirect";
        } else {
        	return "boards/view";
        }
    }
    
    @RequestMapping(value="/delete", method={RequestMethod.GET, RequestMethod.POST})
    public String delete(int postno, String boardcode, Integer curPage, String searchWord) throws Exception {
       
    	Post post = boardService.getPost(postno);
    	int replyCheck = boardService.replyCheck(post);
    	if(replyCheck>=1) {
    		boardService.hidePost(post);
    	} else {
    		boardService.delete(postno);
    		boardService.deleteHidePost(post);
    	}
       
        return "redirect:/boards/list?boardcode=" + boardcode + "&curPage=" + curPage + "&searchWord=" + searchWord;
 
    }  
   
    @RequestMapping(value="/modifyForm", method=RequestMethod.POST)
    public String update(int postno, String boardcode, Model model) throws Exception {
       
        Post thisPost = boardService.getPost(postno);
        String boardname = boardService.getBoardName(boardcode);
         
        //수정페이지에서 보일 게시글 정보
        model.addAttribute("thisPost", thisPost);
        model.addAttribute("boardname", boardname);
       
        return "boards/modifyForm";
    }
   
    @RequestMapping(value="/modify", method=RequestMethod.POST)
    public String update(Post post, Integer curPage, String boardcode, String searchWord, Model model, MultipartHttpServletRequest mpRequest) throws Exception {
       
        boardService.update(post);
       
        if(!mpRequest.getFile("upload").isEmpty()) {
			List<MultipartFile> fileList = mpRequest.getFiles("upload");
			for (MultipartFile mf : fileList) {
				String filename = mf.getOriginalFilename();
				mf.transferTo(new File(WebContents.BASE_PATH + filename));
			}
			
			// 파일데이터 삽입
			int size = fileList.size();
			for (int i = 0; i < size; i++) {
				MultipartFile mpFile = fileList.get(i);
				AttachFile attachFile = new AttachFile();
				String filename = mpFile.getOriginalFilename();
				attachFile.setFilename(filename);
				attachFile.setFiletype(mpFile.getContentType());
				attachFile.setFilesize(mpFile.getSize());
				attachFile.setPostno(post.getPostno());
				boardService.insertAttachFile(attachFile);
			}
        }
        return "redirect:/boards/view?postno=" + post.getPostno() + "&boardcode=" + post.getBoardcode() + "&curPage=" + curPage + "&searchWord=" + searchWord;
    }
    
    @RequestMapping(value="/commentAdd", method=RequestMethod.POST)
    public String commentAdd(Integer postno, String boardcode, Integer curPage, String searchWord, String commentcontents, HttpSession session) throws Exception {
      
    	User user = (User)session.getAttribute("check");
    	String nick = user.getNickname();
    	
    boardService.increaseComment(postno);
     Comment comment = new Comment();
     comment.setCommentcontents(commentcontents);
     comment.setCommentwriter(nick);
     comment.setPostno(postno);
     boardService.insertComment(comment);
     
     //searchWord = URLEncoder.encode(searchWord,"UTF-8");
     
     return "redirect:/boards/view?postno=" + postno + "&boardcode=" + boardcode + "&curPage=" + curPage + "&searchWord=" + searchWord;

    }
    
    @RequestMapping(value="/commentReply", method=RequestMethod.POST)
    public String commentReply(Integer commentno, Integer postno, String boardcode, Integer curPage, String searchWord, String commentcontents, HttpSession session) throws Exception {
      
    	User user = (User)session.getAttribute("check");
    	String nick = user.getNickname();
    	
    boardService.increaseComment(postno);
     Comment comment = boardService.getComment(commentno);
     comment.setCommentcontents(commentcontents);
     comment.setCommentwriter(nick);
     comment.setPostno(postno);
     boardService.replyComment(comment);
     
     //searchWord = URLEncoder.encode(searchWord,"UTF-8");
     
     return "redirect:/boards/view?postno=" + postno + "&boardcode=" + boardcode + "&curPage=" + curPage + "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/commentUpdate", method=RequestMethod.POST)
    public String commentUpdate(Integer commentno, Integer postno, String boardcode, Integer curPage, String searchWord, String commentcontents) throws Exception {
      
     Comment comment = boardService.getComment(commentno);
     comment.setCommentcontents(commentcontents);
     boardService.updateComment(comment);
     //searchWord = URLEncoder.encode(searchWord, "UTF-8");
     
     return "redirect:/boards/view?postno=" + postno + "&boardcode=" + boardcode + "&curPage=" + curPage + "&searchWord=" + searchWord;

    }

    @RequestMapping(value="/commentDel", method=RequestMethod.POST)
    public String commentDel(Integer commentno, Integer postno, String boardcode, Integer curPage, String searchWord) throws Exception {
      
    boardService.decreaseComment(postno);
    Comment comment = boardService.getComment(commentno);
    int commentReplyCheck = boardService.commentReplyCheck(comment);
    int parentDelCheck = boardService.parentDelCheck(comment);
    if(comment.getDivision2() == null) {
    	if(commentReplyCheck >= 1) {
    		boardService.hideComment(comment);
    	} else {
    		boardService.deleteComment(commentno);
    	}
    	
    } else {
    	if(commentReplyCheck==1 && parentDelCheck==1) {
    		boardService.deleteHide(comment);
    	} else {
    		boardService.deleteComment(commentno);
    	}
    	
    }
     return "redirect:/boards/view?postno=" + postno + "&boardcode=" + boardcode + "&curPage=" + curPage + "&searchWord=" + searchWord;

    }

	@RequestMapping(value = "/download", method = RequestMethod.POST)
	public String download(String filename, Model model) {
		model.addAttribute("filename", filename);
		return "inc/download";
	}

	@RequestMapping(value = "/attachFileDel", method = RequestMethod.POST)
	public String attachFileDel(Integer attachFileNo, Integer postno, String boardcode, Integer curPage, String searchWord) throws Exception {
		boardService.deleteFile(attachFileNo);

		return "redirect:/boards/view?postno=" + postno + "&boardcode=" + boardcode + "&curPage=" + curPage + "&searchWord=" + searchWord;

	}
    
    
}
