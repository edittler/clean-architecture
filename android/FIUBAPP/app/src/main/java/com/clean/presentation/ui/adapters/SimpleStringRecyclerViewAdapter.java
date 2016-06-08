package com.clean.presentation.ui.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;


import com.clean.R;
import com.clean.presentation.ui.activities.CoursesActivity;
import com.clean.presentation.ui.viewholders.ViewHolder;

import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */

public class SimpleStringRecyclerViewAdapter
        extends RecyclerView.Adapter<ViewHolder> {

    private final TypedValue mTypedValue = new TypedValue();
    private int mBackground;
    private List<String> mValues;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public String getValueAt(int position) {
        return mValues.get(position);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public SimpleStringRecyclerViewAdapter(Context context, List<String> items) {
        context.getTheme().resolveAttribute(R.attr.selectableItemBackground, mTypedValue, true);
        mBackground = mTypedValue.resourceId;
        mValues = items;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item, parent, false);
        view.setBackgroundResource(mBackground);
        return new ViewHolder(view);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onBindViewHolder(final ViewHolder holder, int position) {
        holder.mBoundString = mValues.get(position);
        holder.mTextView.setText(mValues.get(position));

        /*holder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Context context = v.getContext();
                Intent intent = new Intent(context, CoursesActivity.class);
                intent.putExtra(CoursesActivity.SUBJECT_CODE, holder.mBoundString);
                context.startActivity(intent);
            }
        });*/
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public int getItemCount() {
        return mValues.size();
    }
}

