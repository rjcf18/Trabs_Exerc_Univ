package rjfusco.kmeal;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

/**
 * Created by ricardo on 12-07-2015.
 */
public class RecipeActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_view_recipe);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        Recipe r = (Recipe) getIntent().getExtras().get("Recipe");

        TextView name = (TextView) findViewById(R.id.recipeviewname);
        name.setText(r.getName());

        TextView mdish = (TextView) findViewById(R.id.recipeviewtype);
        mdish.setText(r.getDishType());

        TextView description = (TextView) findViewById(R.id.recipeviewdescription);
        description.setText(r.getDescription());

        TextView prep = (TextView) findViewById(R.id.recipeviewpreparation);
        prep.setText(r.getPrepareMode());

        TextView ingredients = (TextView) findViewById(R.id.recipeviewingredients);
        ingredients.setText(r.getIngredients());

        final Button genShoppingList = (Button) findViewById(R.id.genshoppinglist);

        genShoppingList.setOnClickListener(new View.OnClickListener() {


            @Override
            public void onClick(View view) {
                Toast.makeText(getApplicationContext(), "Shopping list generated", Toast.LENGTH_SHORT).show();

                genShoppingList.setVisibility(View.INVISIBLE);
                genShoppingList.setEnabled(false);

            }
        });

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main_screen, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
// Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        switch (id){
            case android.R.id.home:{
                this.finish();
                return true;
            }
        }

        return super.onOptionsItemSelected(item);
    }
}
