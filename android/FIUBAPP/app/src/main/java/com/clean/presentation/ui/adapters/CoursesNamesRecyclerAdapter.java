package com.clean.presentation.ui.adapters;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.clean.R;
import com.clean.presentation.model.CourseModel;
import com.clean.presentation.ui.dialogs.EnrollToCourseDialog;
import com.clean.presentation.ui.viewholders.ViewHolder;

import java.util.List;

/**
 * Created by fabrizio on 06/06/16.
 */
public class CoursesNamesRecyclerAdapter extends RecyclerView.Adapter<ViewHolder> {

    private final TypedValue mTypedValue = new TypedValue();
    private int mBackground;
    private List<CourseModel> mValues;
    private int mSubjectCode;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public CourseModel getValueAt(int position) {
        return mValues.get(position);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public CoursesNamesRecyclerAdapter(Context context, List<CourseModel> items) {
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
        //holder.mBoundString = mValues.get(position).get;
        final CourseModel course = mValues.get(position);
        holder.mTextView.setText("Curso " + course.getId());
        final String courseInfo = "Docentes: " + getTeachers(course) +  "\n"
                                    + "Horario: " + course.getSchedule() +  "\n"
                                    + "Vacantes: " + course.getVacancy();


        holder.mView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Context context = v.getContext();
                EnrollToCourseDialog.build(context, courseInfo, course.getId(), mSubjectCode).show();
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private String getTeachers(CourseModel course) {
        String teachers = "";
        List<String> teachersList = course.getTeachers();
        for (String teacher : teachersList) {
            teachers += teacher + ", ";
        }
        return teachers.substring(0, teachers.length()-2);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public int getItemCount() {
        return mValues.size();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public void setSubjectCode(int subjectCode) {
        mSubjectCode = subjectCode;
    }

}
