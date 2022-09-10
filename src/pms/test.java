package pms;

import java.util.ArrayList;

public class test {
	public static void main(String[] args) {
		projectDAO pdao = new projectDAO();
		ArrayList<projectListVO> plvo = pdao.projectList("test");
		System.out.println(plvo.get(0).getProjectLeader());
	}

}
