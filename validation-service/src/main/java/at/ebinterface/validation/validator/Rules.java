package at.ebinterface.validation.validator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Servers as a wrapper for the different Schematron rules which may be checked with this service
 * @author pl
 *
 */
public class Rules {

	
	
	/** Reference  to the BRZ rules */
	public static String BRZ = "Bundesrechenzentrum";
	
	/** Reference to the SV rules */
	public static String SV = "Sozialversicherung";
	
	/** Stores the rules which are currently supported by this validation service */	
	private static final HashMap<String, String> rules;
	
	private static final List<String> rulesList;
	
	static {
		
		//Initialize the set of rules
		rules = new HashMap<String, String>();		
		//rules.put(BRZ, "/schematron/brz/brz-rules.sch");
		rules.put(SV, "/schematron/sv/sv-rules.sch");
		
		//Store the rule values in a list, used by drop down choices in the web layer
		rulesList = new ArrayList();
		//rulesList.add(BRZ);
		rulesList.add(SV);
					
	}

	/**
	 * Returns the list of currently supported rules
	 * @return
	 */
	public static List<String> getRuleslist() {
		return rulesList;
	}
	
	/**
	 * Returns the reference to the schematron file
	 */
	public static String getSchematronFile(String key) {
		return rules.get(key);
	}
	

		
	
	
	
	
	
	
	
	
}
