package com.clean.presentation.ui.adapters;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.clean.R;
import com.clean.presentation.model.SubjectModel;
import com.clean.presentation.ui.activities.CoursesActivity;
import com.clean.presentation.ui.viewholders.ViewHolder;

import java.util.List;

/**
 * Created by fabrizio on 31/05/16.
 */
public class SubjectModelRecyclerViewAdapter extends RecyclerView.Adapter<ViewHolder> {

    private final TypedValue mTypedValue = new TypedValue();
    private int mBackground;
    private List<SubjectModel> mValues;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public SubjectModel getValueAt(int position) {
        return mValues.get(position);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public SubjectModelRecyclerViewAdapter(Context context, List<SubjectModel> items) {
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
        holder.mBoundString = mValues.get(position).getName();
        holder.mBoundInt = mValues.get(position).getCode();
        holder.mTextView.setText(mValues.get(position).getName());
        Log.e("NAME", mValues.get(position).getName());

        holder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Context context = v.getContext();
                Intent intent = new Intent(context, CoursesActivity.class);
                intent.putExtra(CoursesActivity.SUBJECT_NAME, holder.mBoundString);
                intent.putExtra(CoursesActivity.SUBJECT_CODE, holder.mBoundInt);
                context.startActivity(intent);
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public int getItemCount() {
        return mValues.size();
    }
}
