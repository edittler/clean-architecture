package com.clean.presentation.ui.viewholders;

import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.clean.R;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ViewHolder extends RecyclerView.ViewHolder {
    public String mBoundString;
    public int mBoundInt;

    public final View mView;
    //public final ImageView mImageView;
    public final TextView mTextView;

    public ViewHolder(View view) {
        super(view);
        mView = view;
        //mImageView = (ImageView) view.findViewById(R.id.avatar);
        mTextView = (TextView) view.findViewById(android.R.id.text1);
    }

    @Override
    public String toString() {
        return super.toString() + " '" + mTextView.getText();
    }
}
