/**
 * 
 */
package vendor.controller;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vendor.service.CaptchaService;
import vendor.service.PropertiesService;
import vendor.model.Address;
import vendor.model.BusinessInfo;
import vendor.model.ListItem;
import vendor.model.VendorInfo;
import vendor.service.VendorService;

/**
 * @author 410284
 * 
 *
 */
@Controller
@SessionAttributes({"businessInfo", "vendorInfo"})
public class VendorController {

	@Autowired
	VendorService vendorService;
	
	@Autowired
	CaptchaService captchaService;
	
	@Autowired
	PropertiesService propertiesService;

	private static final Logger logger = LoggerFactory.getLogger(VendorController.class);

	private static final String ADDRESS_VALIDATION = "AddressValidation";
	private static final String BTRC_FORM = "https://finance.lacity.org/sites/g/files/wph1051/f/2020%20BTRC%20Application_0.pdf";
	private static final String CERTIFICATE = "Certificate";
	private static final String CONFIRMATION = "Confirmation";
	private static final String EXCEPTION_PAGE = "ExceptionPage";
	// MV - URL For Coldfusion App JUST THE TEST APP.
	private static final String EAPP = "https://latax2.lacity.org/oofweb/eappreg/eappreg_criteria.cfm?exemption_id=";
	private static final String ERROR_PROMPT = "Review and correct errors encountered below.";
	private static final String EXEMPTION_FORM = "ExemptionForm";
	private static final String REGISTRATION_FORM = "RegistrationForm";
	private static final String VENDOR_FORM = "https://finance.lacity.org/sites/g/files/wph1051/f/Vendor%20Registration%202%20Page%20Packet.pdf";

	@ModelAttribute("businessInfo")
	public BusinessInfo getBusinessInfo() {
		return new BusinessInfo();
	}
	@ModelAttribute("vendorInfo")
	public VendorInfo newVendorInfo() {
		return new VendorInfo();
	}

	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
	public String showIntroduction(Model model) {	
		return "Introduction";
	}

	@RequestMapping(value = {"/exemption"}, method = RequestMethod.GET)
	public String showExemptionForm(Model model) {	
		if(model.containsAttribute("errors")) {
			model.addAttribute("org.springframework.validation.BindingResult.vendorInfo", 
					model.asMap().get("errors"));
		}
		try {
			model.addAttribute("siteKey", propertiesService.getProperties().getProperty("recaptcha.sitekey"));
			return EXEMPTION_FORM;
		} catch (DataAccessException e) {
			e.printStackTrace();
			logger.error("Database error occurred when loading exemption form");
			logger.error(e.getMessage());
			return EXCEPTION_PAGE;
		}
	}

	@RequestMapping(value = {"/exemption" }, method = RequestMethod.POST)
	public String postExemptionForm(@Validated @ModelAttribute("vendorInfo") VendorInfo vendorInfo,
			BindingResult result, HttpServletRequest request, RedirectAttributes redirectAttributes, @RequestParam("new-registration") boolean btrc) {
		try {
			captchaService.processResponse( request.getParameter("g-recaptcha-response"), request.getRemoteAddr());
		} catch (Exception captchaEx) {
			captchaEx.printStackTrace();
			logger.error(captchaEx.getMessage());
			result.reject("fieldErrors", "Captcha failed validation.  Please try again.");
			redirectAttributes.addFlashAttribute("errors", result);
			return "redirect:/exemption";
		}
		if (result.hasErrors()) {
			result.reject("fieldErrors", "Review and correct errors encountered below.");
			redirectAttributes.addFlashAttribute("errors", result);
			return "redirect:/exemption";
		} else if(btrc) {		
			String vendorFormUrl = propertiesService.getProperties().getProperty("vendor.form.url");
			return "redirect:" + vendorFormUrl;
		} else if(Boolean.parseBoolean(vendorInfo.getLongerThanAWeek())) {
			String btrcFormUrl = propertiesService.getProperties().getProperty("btrc.form.url");
			return "redirect:" + btrcFormUrl;
		} else if (vendorInfo.getFundClass().isEmpty()) {
			String eappUrl = propertiesService.getProperties().getProperty("eapp.url");
			return "redirect:" + eappUrl + vendorInfo.getExemptionId();
		} else {
			List<String> fileNameList = new ArrayList<String>();
			if(vendorInfo.getFundClass().contains("L049") && !vendorInfo.getFile()[0].isEmpty()) {
				if(!vendorService.processFile(vendorInfo.getFile()[0], result, redirectAttributes)) {
					return "redirect:/exemption";
				} else {
					fileNameList.add(vendorInfo.getFile()[0].getOriginalFilename());
				}
			}			

			if(vendorInfo.getFundClass().contains("L194") && !vendorService.processFile(vendorInfo.getFile()[1], result, redirectAttributes)) {
				return "redirect:/exemption";
			} else {
				fileNameList.add(vendorInfo.getFile()[1].getOriginalFilename());
			}

			if(vendorInfo.getFundClass().contains("L195") && !vendorService.processFile(vendorInfo.getFile()[2], result, redirectAttributes)) {
				return "redirect:/exemption";
			} else {
				fileNameList.add(vendorInfo.getFile()[2].getOriginalFilename());
			}
			vendorInfo.setFileNames(fileNameList);
			return "redirect:/application";
		}		
	}

	@RequestMapping(value = { "/application" }, method = RequestMethod.GET)
	public String showApplication(Model model) {
		if (model.containsAttribute("errors")) {
			model.addAttribute("org.springframework.validation.BindingResult.businessInfo",
					model.asMap().get("errors"));
		}
		// prevent skipping pages
		VendorInfo v = (VendorInfo) model.asMap().get("vendorInfo");
		if(null == v.getLongerThanAWeek()) {
			return "redirect:/exemption";
		}
		try {
			List<ListItem> stateList = vendorService.getStateList();
			model.addAttribute("stateList", stateList.subList(1, stateList.size()));

			List<ListItem> unitType = vendorService.getUnitTypeList();			
			Collections.sort(unitType);
			
			List<ListItem> unitTypeMailing = new ArrayList<ListItem>(unitType);
			model.addAttribute("unitTypeMailing", unitTypeMailing.subList(1, unitTypeMailing.size()));
			
			for(int i=0; i < unitType.size(); i++) {
				if(unitType.get(i).getValue().equals("POBX")) {
					unitType.remove(i);
					break;
				}
			}
			model.addAttribute("unitType", unitType.subList(1, unitType.size()));

			List<ListItem> streetType = vendorService.getStreetTypeList();
			Collections.sort(streetType);
			model.addAttribute("streetType", streetType.subList(1, streetType.size()));
			return REGISTRATION_FORM;
		} catch (DataAccessException e) {
			e.printStackTrace();
			logger.error("Database error occurred when loading application form");
			logger.error(e.getMessage());
			return EXCEPTION_PAGE;
		}
	}

	@RequestMapping(value = { "/application" }, method = RequestMethod.POST)
	public String postApplication(Model model, @Validated @ModelAttribute("businessInfo") BusinessInfo businessInfo,
			BindingResult result, RedirectAttributes redirectAttributes, @RequestParam(name="vsr", required=false) boolean vesselSpeedReduction) {
		String[] arr = {"los angeles", "losangeles", "la"};
		for(String s : arr) {
			if(businessInfo.getCity().toLowerCase().equals(s)) {
				result.rejectValue("city", "rejectCity", "Business address must be outside of Los Angeles city");				
				redirectAttributes.addFlashAttribute("errors", result);
				return "redirect:/application";
			}		
		}
		
		try {
			if(vesselSpeedReduction) {
				businessInfo.setBusinessDescription("VESSEL SPEED REDUCTION");
			}
			if (result.hasErrors()) {
				result.reject("fieldErrors", ERROR_PROMPT);
				redirectAttributes.addFlashAttribute("errors", result);
				return "redirect:/application";
			} else {
				return "redirect:/address-validation";
			}
		} catch (Exception e) {
			e.printStackTrace();	
			logger.error("Error occured when redirecting to address screen");
			logger.error(e.getMessage());
			return EXCEPTION_PAGE;
		}
	}

	@RequestMapping(value = { "/address-validation" }, method = RequestMethod.GET)
	public String addressValidation(Model model, BusinessInfo businessInfo) {
		model.addAttribute("address", new Address());
		BusinessInfo b = (BusinessInfo) model.asMap().get("businessInfo");
		if(StringUtils.isEmpty(b.getBusinessDescription())) { 
			return "redirect:/exemption"; 
		}
		if(!StringUtils.hasText(businessInfo.getUnitType()) || !StringUtils.hasText(businessInfo.getUnitNumber())) {
			businessInfo.setUnitType("");
			businessInfo.setUnitNumber("");			
		}
		if(!StringUtils.hasText(businessInfo.getUnitTypeMailing()) || !StringUtils.hasText(businessInfo.getUnitNumberMailing())) {
			businessInfo.setUnitTypeMailing("");
			businessInfo.setUnitNumberMailing("");
		}
		try {
			List<Address> addressMatches = vendorService.validateAddress(businessInfo.getStreetNumber(), 
					businessInfo.getStreetName(), 
					businessInfo.getCity(), 
					businessInfo.getState(), 
					businessInfo.getZipCode(), 
					businessInfo.getDirectionalPrefix(),
					businessInfo.getDirectionalSuffix(), 
					businessInfo.getStreetType(),
					businessInfo.getUnitType(),
					businessInfo.getUnitNumber());
			model.addAttribute("addressMatches", addressMatches);
			if(!businessInfo.isOneAddress()) {
				List<Address> addressMatchesMailing = vendorService.validateAddress(businessInfo.getStreetNumberMailing(), 
						businessInfo.getStreetNameMailing(), 
						businessInfo.getCityMailing(), 
						businessInfo.getStateMailing(), 
						businessInfo.getZipCodeMailing(), 
						businessInfo.getDirectionalPrefixMailing(),
						businessInfo.getDirectionalSuffixMailing(), 
						businessInfo.getStreetTypeMailing(),
						businessInfo.getUnitTypeMailing(),
						businessInfo.getUnitNumberMailing());
				model.addAttribute("addressMatchesMailing", addressMatchesMailing);
			}
		} catch (Exception e) {
			e.printStackTrace();	
			logger.error("Error occured on address validation GET");
			logger.error(e.getMessage());
			return "redirect:/confirmation";
		}
		return ADDRESS_VALIDATION;	
	}

	@RequestMapping(value = { "/address-validation" }, method = RequestMethod.POST)
	public String confirmAddress(@ModelAttribute("address") Address address, BindingResult result, BusinessInfo businessInfo) {
		try {
			vendorService.parseAddress(businessInfo, address);
		} catch (Exception e) {
			e.printStackTrace();	
			logger.error("Error occured on address validation POST");
			logger.error(e.getMessage());
		}
		return "redirect:/confirmation";
	}

	@RequestMapping(value = { "/confirmation" }, method = RequestMethod.GET)
	public String showConfirmation(Model model) {
		BusinessInfo b = (BusinessInfo) model.asMap().get("businessInfo");
		if(StringUtils.isEmpty(b.getBusinessDescription())) { 
			return "redirect:/exemption"; 
		}
		try {
			return CONFIRMATION;
		}
		catch (Exception e) {
			e.printStackTrace();
			logger.error("Error occured when loading confirmation screen");		
			logger.error(e.getMessage());
			return EXCEPTION_PAGE;
		}		
	}

	@RequestMapping(value = { "/confirmation" }, method = RequestMethod.POST)
	public String confirmRegistration(@ModelAttribute("businessInfo") BusinessInfo businessInfo, BindingResult result) {
		if (result.hasErrors()) {
			return EXCEPTION_PAGE;
		}
		return CONFIRMATION;
	}

	@RequestMapping(value = { "/register" }, method = RequestMethod.GET)
	public String redirectFromRegister() {
		return "redirect:/exemption";
	}

	// POST-GET-REDIRECT prevents duplicate submissions if user refreshes
	@RequestMapping(value = { "/register" }, method = RequestMethod.POST)
	public String register(Model model, @ModelAttribute("businessInfo") BusinessInfo businessInfo,
			@ModelAttribute("vendorInfo") VendorInfo vendorInfo, HttpServletRequest request ) {
		try {
			vendorService.register(businessInfo, vendorInfo, request.getHeader("X-FORWARDED-FOR"));			 
			return "redirect:/certificate";
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("Database error occurred when processing registration data");
			logger.error(e.getMessage());
			return EXCEPTION_PAGE;
		}
	}

	@RequestMapping(value = { "/certificate" }, method = RequestMethod.GET)
	public String showCertificate(Model model, SessionStatus session) {
		BusinessInfo b = (BusinessInfo) model.asMap().get("businessInfo");
		if(StringUtils.isEmpty(b.getBusinessDescription())) { 
			return "redirect:/exemption"; 
		}
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/YYYY");
		model.addAttribute("currentDate", formatter.format(calendar.getTime()));
		calendar.add(Calendar.MONTH, 6);
		model.addAttribute("expirationDate", formatter.format(calendar.getTime()));	
		session.setComplete();
		return CERTIFICATE;
	}
}