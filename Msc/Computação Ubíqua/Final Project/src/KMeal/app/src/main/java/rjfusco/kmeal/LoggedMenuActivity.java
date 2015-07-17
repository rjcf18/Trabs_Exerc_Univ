package rjfusco.kmeal;

import android.app.FragmentManager;
import android.content.Intent;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;


public class LoggedMenuActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_logged_menu);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        final Recipe recipe1 = new Recipe("Francesinha", "Main Dish", "Lorem ipsum dolor sit amet, " +
                "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore " +
                "magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris " +
                "nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in " +
                "voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat " +
                "cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque " +
                        "laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi " +
                        "architecto beatae vitae dicta sunt explicabo.", 5, "- 2 beers\n- 300ml of " +
                "tomato sauce\n- 2 bay leaves\n- 1 teaspoon spicy sauce\n...");


        Button favorites = (Button) findViewById(R.id.favorites);
        Button logout = (Button) findViewById(R.id.logoutbtn);
        Button random = (Button) findViewById(R.id.randomrecipebtn);

        favorites.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent i = new Intent(LoggedMenuActivity.this, FavoritesActivity.class);
                startActivity(i);
            }
        });

        logout.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent i = new Intent(LoggedMenuActivity.this, MainScreenActivity.class);
                startActivity(i);
            }
        });

        random.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent i = new Intent(LoggedMenuActivity.this, RecipeActivity.class);
                i.putExtra("Recipe", recipe1);
                startActivity(i);
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

        return super.onOptionsItemSelected(item);
    }

    public void showSearchDialog(View v){
        FragmentManager manager = getFragmentManager();
        BasicSearchDialog dialog = new BasicSearchDialog();
        dialog.show(manager,"Basic Search");
    }
}
