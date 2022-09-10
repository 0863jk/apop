package pms;

public class projectListVO {
	private String projectLeader;

	private String projectId;
	private String projectName;
	private String projectSummary;
	private String[] projectNotice;
	
	public String getProjectName() {
		return projectName;
	}
	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	public String getProjectSummary() {
		return projectSummary; 
		
	}
	public void setProjectSummary(String projectSummary) {
		this.projectSummary = projectSummary;
	}
	public String[] getProjectNotice() {
		return projectNotice;
	}
	public void setProjectNotice(String[] projectNotice) {
		this.projectNotice = projectNotice;
	}
	public String getProjectId() {
		return projectId;
	}
	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	public String getProjectLeader() {
		return projectLeader;
	}
	public void setProjectLeader(String projectLeader) {
		this.projectLeader = projectLeader;
	}
	
}
