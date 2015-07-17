package rjfusco.kmeal;

import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

/**
 * Created by ricardo on 12-07-2015.
 */
public class BSearchCardViewAdapter extends RecyclerView.Adapter<BSearchCardViewAdapter.BSearchViewHolder> {

    Recipe[] recipes;

    public BSearchCardViewAdapter(Recipe[] recipes) {
        this.recipes = recipes;
    }

    // Create new views (invoked by the layout manager)
    @Override
    public BSearchViewHolder onCreateViewHolder(ViewGroup parent,
                                                                           int viewType) {
        // create a new view
        RelativeLayout v = (RelativeLayout) LayoutInflater.from(parent.getContext())
                .inflate(R.layout.recipe_layout, parent, false);
        // set the view's size, margins, paddings and layout parameters


        BSearchViewHolder vh = new BSearchViewHolder(
                v );
        return vh;
    }

    // Replace the contents of a view (invoked by the layout manager)
    @Override
    public void onBindViewHolder(BSearchViewHolder holder, int position) {
        // - get element from your dataset at this position
        // - replace the contents of the view with that element
        holder.rcpName.setText(recipes[position].getName());
        holder.dishType.setText(recipes[position].getDishType());
        holder.recipeImage.setBackgroundResource(R.drawable.rcp4);
        //holder.mImageView.setBackground(mContext.getResources().getDrawable());

    }

    // Return the size of your dataset (invoked by the layout manager)
    @Override
    public int getItemCount() {
        return recipes.length;
    }

    public class BSearchViewHolder extends RecyclerView.ViewHolder {
        // each data item is just a string in this case
        public TextView rcpName;
        public TextView dishType;
        public ImageView recipeImage;

        public BSearchViewHolder(RelativeLayout relativeLayout) {
            super(relativeLayout);

            this.rcpName = (TextView)relativeLayout.findViewById(R.id.recipename);
            this.dishType = (TextView)relativeLayout.findViewById(R.id.dishtype);
            this.recipeImage = (ImageView)relativeLayout.findViewById(R.id.rcpimage);


            relativeLayout.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(view.getContext(), RecipeActivity.class);
                    intent.putExtra("Recipe",recipes[0]);
                    //intent.putExtra("Image", R.id.rcpimage);

                    view.getContext().startActivity(intent);
                }
            });
        }


    }
}

