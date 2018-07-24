package spring.mvc.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.mvc.user.User;
import spring.mvc.user.UserService;

@Controller
@RequestMapping("/users")
public class UsersController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/memberInfo", method=RequestMethod.GET)
    public String memberInfo() {
        return "users/memberInfo";
    }
	
	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public String signUp() {
		return "users/signUp";
	}

	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public String signUp(User user) throws Exception {
		userService.insert(user);
		return "users/welcome";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login() {
		return "users/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String userid, String pwd, HttpSession session, Model model) throws Exception {
		model.addAttribute("msg", "아이디와 비밀번호를 확인해주세요.");
		model.addAttribute("url", "/users/login");
		
		User loginUser = userService.login(userid, pwd);
		if (loginUser != null) {
			session.setAttribute("check", loginUser);
			return "index";
		} else {
			return "redirect";
		}
	}
	
	@RequestMapping(value="/editAccount", method=RequestMethod.GET)
    public String editAccount() {
        return "users/editAccount";
    }
   
    @RequestMapping(value="/editAccount", method=RequestMethod.POST)
    public String editAccount(User user, HttpSession session) throws Exception {
        User loginUser = (User) session.getAttribute("check");
        String userid = loginUser.getUserid(); //세션에 저장된 사용자 정보로부터 이메일을 알아낸다.
       
        if (user.getName() == null) {
            user.setName(loginUser.getName());
        }
        if (user.getNickname() == null) {
            user.setNickname(loginUser.getNickname());
        }
        if (user.getEmail() == null) {
            user.setEmail(loginUser.getEmail());
        }
        if (user.getPhone() == null) {
            user.setPhone(loginUser.getPhone());
        }
       
        user.setUserid(userid);
        int check = userService.modify(user);
        if (check == 1) {
            session.setAttribute("check",user);
        }
       
        return "users/memberInfo";
       
    }
   
    @RequestMapping(value="/changePwd", method=RequestMethod.GET)
    public String changePwd() {
        return "users/changePwd";
    }
   
    @RequestMapping(value="/changePwd", method=RequestMethod.POST)
    public String changePwd(String pwd, HttpSession session) throws Exception {
        String userid = ((User)session.getAttribute("check")).getUserid();
       
        User user = new User();
        user.setUserid(userid);
        user.setPwd(pwd);
       
        userService.changePwd(user);
       
        return "users/confirm";
    }
   
    @RequestMapping(value="/bye", method=RequestMethod.GET)
    public String bye(HttpSession session) {
        User user = (User)session.getAttribute("check");
        userService.byeMember(user);
        session.invalidate();
       
        return "users/login";
    }
   
    @RequestMapping(value="/logout", method=RequestMethod.GET)
    public String logout(HttpSession session) {
        session.removeAttribute("check");
 
        return "users/login";
 
    }
    
    
}