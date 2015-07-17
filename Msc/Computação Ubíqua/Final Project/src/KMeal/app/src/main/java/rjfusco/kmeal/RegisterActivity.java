package rjfusco.kmeal;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NavUtils;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

/**
 * Created by Ricardo on 10-07-2015.
 */
public class RegisterActivity extends ActionBarActivity {
    EditText username, email, password;
    Button register;
    String usernametext, emailtext, passwordtext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        getSupportActionBar().setHomeButtonEnabled(true);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);


        username = (EditText)findViewById(R.id.usernamer);
        email = (EditText)findViewById(R.id.emailr);
        password = (EditText)findViewById(R.id.pwordr);
        register = (Button)findViewById(R.id.register2);


        register.setOnClickListener(new View.OnClickListener() {


            @Override
            public void onClick(View view) {
                usernametext = username.getText().toString();
                emailtext = email.getText().toString();
                passwordtext = password.getText().toString();

                Intent i = new Intent(RegisterActivity.this, LoggedMenuActivity.class);
                startActivity(i);

            }
        });

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

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main_screen, menu);
        return true;
    }
}
