package com.loggia.Helpers;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.net.Uri;
import android.os.Bundle;
import android.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.DatePicker;
import android.support.v4.app.DialogFragment;
import android.widget.TextView;


import com.loggia.R;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class CalendarDialog extends DialogFragment
        implements DatePickerDialog.OnDateSetListener {



    @Override
    public Dialog onCreateDialog(Bundle savedInstanceState) {
        // Use the current date as the default date in the picker
        final Calendar c = Calendar.getInstance();
        int year = c.get(Calendar.YEAR);
        int month = c.get(Calendar.MONTH);
        int numDay = c.get(Calendar.DAY_OF_WEEK_IN_MONTH);
        int day = c.get(Calendar.DAY_OF_MONTH);

        // Create a new instance of DatePickerDialog and return it
        return new DatePickerDialog(getActivity(), this, year, month, day);
    }

    public void onDateSet(DatePicker view, int year, int month, int day) {
        TextView display_time = (TextView) getActivity().findViewById(R.id.Display_Event_Date);

        String sDay = new SimpleDateFormat("EEEE", Locale.ENGLISH).format(day);
        String sMonth = new SimpleDateFormat( "LLLL", Locale.getDefault()).format(month);

        display_time.setText(sDay + ", " + sMonth + " " + day);

    }
}
