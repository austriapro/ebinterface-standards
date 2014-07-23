package at.ebinterface.validation.validator;

import java.util.ArrayList;
import java.util.List;

/**
 * Servers as a wrapper for the different Schematron rules which may be checked with this service
 *
 * @author pl
 */
public class Rules {


    /**
     * Stores the rules which are currently supported by this validation service.
     * Use Rule as the key in order to allow retrieval based on type and ebInterface version
     */
    private static final List<Rule> rules;


    static {

        //Initialize the set of rules
        rules = new ArrayList<Rule>();

        Rule rule1 = new Rule("Sozialversicherung (ebInterface 4p0)", EbInterfaceVersion.E4P0, "/schematron/sv/sv-rules-4p0.sch");
        rules.add(rule1);

        Rule rule2 = new Rule("Sozialversicherung (ebInterface 4p1)", EbInterfaceVersion.E4P1, "/schematron/sv/sv-rules-4p1.sch");
        rules.add(rule2);

    }


    /**
     * Get a certain rule
     *
     * @param name
     * @param version
     * @return
     */
    public static Rule getRule(String name, EbInterfaceVersion version) {
        for (Rule r : rules) {
            if (r.getName().equals(name) && r.getEbInterfaceVersion().equals(version)) {
                return r;
            }
        }
        return null;
    }


    public static List<Rule> getRules() {
        return rules;
    }
}
