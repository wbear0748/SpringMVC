package spring.mvc.user.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.mvc.user.UserService;

@Controller
public class DuplicationController {

	@Autowired
	private UserService userService;
	
	
    @ResponseBody
    @RequestMapping("/checkId")
    public int checkId(HttpServletRequest request) {
        String userid = request.getParameter("userid");
        int count = userService.checkId(userid);
        return count;
    }
    
    @ResponseBody
    @RequestMapping("/checkNickname")
    public int checkNickname(HttpServletRequest request) {
        String nickname = request.getParameter("nickname");
        int count = userService.checkNickname(nickname);
        return count;
    }
}