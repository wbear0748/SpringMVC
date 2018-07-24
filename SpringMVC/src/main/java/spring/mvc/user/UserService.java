package spring.mvc.user;

public interface UserService {
	public int insert(User user);

	public User login(String userid, String pwd);

	public int modify(User user);

	public void changePwd(User user);

	public void byeMember(User user);

	public int checkId(String userid);

	public int checkNickname(String nickname);
}