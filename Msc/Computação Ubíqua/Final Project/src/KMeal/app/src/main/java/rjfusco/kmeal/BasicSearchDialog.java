package rjfusco.kmeal;

import android.app.DialogFragment;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

/**
 * Created by ricardo on 11-07-2015.
 */
public class BasicSearchDialog extends DialogFragment{
    Button submit, cancel1;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.basic_search_dialog, null);
        submit = (Button) view.findViewById(R.id.submit1);
        cancel1 = (Button) view.findViewById(R.id.cancel1);

        getDialog().setTitle("Basic search");

        cancel1.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                dismiss();
            }
        });

        submit.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent i = new Intent(v.getContext(), SearchResultsActivity.class);
                startActivity(i);
            }
        });

        return view;
    }
}
