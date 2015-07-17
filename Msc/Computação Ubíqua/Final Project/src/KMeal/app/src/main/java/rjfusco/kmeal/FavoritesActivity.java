package rjfusco.kmeal;

import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;


/**
 * Created by ricardo on 12-07-2015.
 */
public class FavoritesActivity extends ActionBarActivity{

    Recipe[] recipes = new Recipe[4];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_favorites);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);

        Recipe recipe1 = new Recipe("Francesinha", "Main Dish", "Lorem ipsum dolor sit amet, " +
                "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore " +
                "magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris " +
                "nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in " +
                "voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat " +
                "cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque " +
                "laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi " +
                        "architecto beatae vitae dicta sunt explicabo.", 5, "- 2 beers\n- 300ml of tomato sauce\n- 2 bay leaves\n- 1 teaspoon spicy sauce\n...");

        recipes[0] = recipe1;
        recipes[1] = recipe1;
        recipes[2] = recipe1;
        recipes[3] = recipe1;

        BSearchCardViewAdapter viewadapter = new BSearchCardViewAdapter(recipes);

        RecyclerView recyclerview = (RecyclerView)findViewById(R.id.favoritesrecyclerview);
        LinearLayoutManager linearLayoutManager =  new LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false);

        recyclerview.setLayoutManager(linearLayoutManager);
        recyclerview.setAdapter(viewadapter);


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
        int id = item.getItemId();

        switch (id){
            case R.id.home:{
                NavUtils.navigateUpFromSameTask(this);
                return true;
            }
        }
        return super.onOptionsItemSelected(item);
    }

}
