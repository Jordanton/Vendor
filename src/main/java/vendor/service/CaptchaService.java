package vendor.service;

public interface CaptchaService {	 
	 public void processResponse(String response, String clientIp) throws Exception;
}
