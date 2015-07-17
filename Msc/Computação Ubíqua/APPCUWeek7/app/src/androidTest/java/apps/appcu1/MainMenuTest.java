package apps.appcu1;

import android.graphics.Rect;
import android.test.ActivityInstrumentationTestCase2;
import android.test.ViewAsserts;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.test.ViewAsserts.*;

/**
 * <a href="http://d.android.com/tools/testing/testing_android.html">Testing Fundamentals</a>
 */
public class MainMenuTest extends ActivityInstrumentationTestCase2<MainMenu> {
    private Button startBtn;
    private Button exitBtn;
    private View textViewGame;
    private View textViewName;
    private View rltvLayout;
    private EditText nameField;


    public MainMenuTest(){
        super(MainMenu.class);
    }

    protected void setUp() throws Exception {
        super.setUp();

        MainMenu mainMenu = getActivity();
        startBtn = (Button) mainMenu.findViewById(R.id.start);
        exitBtn = (Button) mainMenu.findViewById(R.id.exit);
        textViewGame = (View) mainMenu.findViewById(R.id.textView);
        textViewName = (View) mainMenu.findViewById(R.id.textView2);
        rltvLayout = (View) mainMenu.findViewById(R.id.relativeLayout1);
        nameField = (EditText) mainMenu.findViewById(R.id.input);
    }

    // verifies the existence of the buttons, text view and input field
    public void testMainMenuLayout() {
        MainMenu mainMenu = getActivity();

        // Verifies the buttons, text views and text input field exist
        assertNotNull(mainMenu.findViewById(R.id.start));
        assertNotNull(mainMenu.findViewById(R.id.exit));
        assertNotNull(mainMenu.findViewById(R.id.textView));
        assertNotNull(mainMenu.findViewById(R.id.textView2));
        assertNotNull(mainMenu.findViewById(R.id.input));

        // Verifies the text of the authors text view
        View view = (View) mainMenu.findViewById(R.id.textView2);
        assertEquals("Incorrect name in the author textview.", "Ricardo Fusco", view.toString());

        //...
    }

    // test the start button (check if the button is within the screen boundaries)
    public void testStartButtonOnScreen() {
        int fullWidth = rltvLayout.getWidth();
        int fullHeight = rltvLayout.getHeight();

        int[] rltvLayoutLocation = new int[2];
        rltvLayout.getLocationOnScreen(rltvLayoutLocation);

        int[] viewLocation = new int[2];
        startBtn.getLocationOnScreen(viewLocation);

        Rect outRect = new Rect();
        startBtn.getDrawingRect(outRect);

        assertTrue("Start button is off the right of the screen", fullWidth
                + rltvLayoutLocation[0] > outRect.width() + viewLocation[0]);

        assertTrue("Start button is off the bottom of the screen", fullHeight
                + rltvLayoutLocation[1] > outRect.height() + viewLocation[1]);
    }

}