package vendor.model;

import java.util.List;

import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.NotBlank;

import org.springframework.web.multipart.MultipartFile;

public class VendorInfo {
	
	@Pattern(regexp="^(13|14|15|16|19|28)", message="Invalid value")
	private String exemptionId;
	private	List<String> fundClass;
	private String longerThanAWeek;
	private MultipartFile[] file;
	private List<String> fileNames;
	@NotBlank
	@Pattern(regexp="^[0-9]{9}$", message="Invalid value")
	private String fein;
	
	
	public VendorInfo() {
		super();
		this.exemptionId = "19";
	}

	/**
	 * @return the file
	 */
	public MultipartFile[] getFile() {
		return file;
	}

	/**
	 * @param file the file to set
	 */
	public void setFile(MultipartFile[] file) {
		this.file = file;
	}

	private String previousBTRCOnFile;
	
	

	/**
	 * @return the previousBTRCOnFile
	 */
	public String getPreviousBTRCOnFile() {
		return previousBTRCOnFile;
	}

	/**
	 * @param previousBTRCOnFile the previousBTRCOnFile to set
	 */
	public void setPreviousBTRCOnFile(String previousBTRCOnFile) {
		this.previousBTRCOnFile = previousBTRCOnFile;
	}

	/**
	 * @return the longerThanAWeek
	 */
	public String getLongerThanAWeek() {
		return longerThanAWeek;
	}

	/**
	 * @param longerThanAWeek the longerThanAWeek to set
	 */
	public void setLongerThanAWeek(String longerThanAWeek) {
		this.longerThanAWeek = longerThanAWeek;
	}

	/**
	 * @return the exemptionId
	 */
	public String getExemptionId() {
		return exemptionId;
	}
	
	/**
	 * @param exemptionId the exemptionId to set
	 */
	public void setExemptionId(String exemptionId) {
		this.exemptionId = exemptionId;
	}

	/**
	 * @return the fundClass
	 */
	public List<String> getFundClass() {
		return fundClass;
	}

	/**
	 * @param fundClass the fundClass to set
	 */
	public void setFundClass(List<String> fundClass) {
		this.fundClass = fundClass;
	}

	public List<String> getFileNames() {
		return fileNames;
	}

	public void setFileNames(List<String> fileNames) {
		this.fileNames = fileNames;
	}

	/**
	 * @return the fein
	 */
	public String getFein() {
		return fein;
	}

	/**
	 * @param fein the fein to set
	 */
	public void setFein(String fein) {
		this.fein = fein;
	}
	
}
