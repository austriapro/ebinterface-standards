package at.ebinterface.validation.web.utils;

import at.ebinterface.validation.validator.EbInterfaceVersion;

/**
 * Utilities used for the frontend
 * 
 * @author pl
 */
public enum Utils
{

  INSTANCE;

  /**
   * Returns a prettified String for the ebInterface version
   * 
   * @param version
   * @return Never null
   */
  public String getPrettyPrintedEbInterfaceVersion (final EbInterfaceVersion version)
  {

    if (version == EbInterfaceVersion.E3P0)
    {
      return "ebInterface 3.0";
    }
    else
      if (version == EbInterfaceVersion.E3P02)
      {
        return "ebInterface 3.02";
      }
      else
        if (version == EbInterfaceVersion.E4P0)
        {
          return "ebInterface 4.0";
        }
    return "";
  }

}
