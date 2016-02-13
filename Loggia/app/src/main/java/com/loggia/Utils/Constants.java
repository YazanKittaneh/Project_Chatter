package com.loggia.Utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.EnumMap;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.TimeZone;
import java.util.logging.Filter;

/**
 * Created by L7 on 9/23/15.
 */
public class Constants {
    public static BackendDomain currentBackendDomain = BackendDomain.PARSE;

    /**
     * Enum list of all filter options
     * ADD ADDITIONAL FILTERS HERE
     */
    public enum FilterOptions{
        ART,FOOD,MUSIC,PARTIES,SPORTS,STUDENT
    }


}

