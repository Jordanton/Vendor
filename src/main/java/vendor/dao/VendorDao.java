package vendor.dao;

import java.math.BigDecimal;
import java.util.List;

import vendor.model.BusinessInfo;
import vendor.model.ListItem;
import vendor.model.VendorInfo;


public interface VendorDao {
	public void register(BusinessInfo businessInfo, VendorInfo vendorInfo);
	
	public List<ListItem> getStateList();

	public List<ListItem> getUnitTypeList();
	
	public List<ListItem> getStreetTypeList();
	
	public BigDecimal generateWebFilingId();
	
	public String generateRegistrationNumber();
	
	public List<ListItem> getExemptionTypeList();
	
	public int registerFundClass(BigDecimal webFilingId, String fundClass, String taxPeriod);
}
