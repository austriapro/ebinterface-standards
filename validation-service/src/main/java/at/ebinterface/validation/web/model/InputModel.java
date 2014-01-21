package at.ebinterface.validation.web.model;

import java.io.Serializable;

/**
 * Inputmodel for the Input form on the start page
 * @author pl
 *
 */
public class InputModel implements Serializable {



  private String ruleSelector;

  public String getRuleSelector() {
    return ruleSelector;
  }

  public void setRuleSelector(final String ruleSelector) {
    this.ruleSelector = ruleSelector;
  }

}
