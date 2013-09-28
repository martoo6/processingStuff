/*
 * Share is a Processing library written by Nucky (http://www.nucky.io).
 * 
 * This software is distributed under the GNU GPL 3 license (http://www.gnu.org/licenses/gpl.html).
 * Share is provided "as is", with no warranty of any kind.
 * It should be used with Processing. Processing core library is under GNU LGPL license.
*/

package nucky.share;

import java.awt.Color;
import processing.event.MouseEvent;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.MalformedURLException;
import processing.core.*; 

/**
 * A class that allows to put a mark on a Processing sketch. Once the user submits his vote, it displays the average mark. </br>
 * To vote and display the result, it is also possible to use a custom GUI or a GUI library.</br>
 * The library requires a PHP/MySQL server with the share library PHP scripts, and the SQL table properly installed.
 * @author Nucky
 */
public class Like extends Share {

	/**
	 * Default number of buttons (max mark you can give)
	 */
	private static final int DEFAULT_HIGHEST_MARK = 5;
	/**
	 * Default background color
	 */
	private final static int DEFAULT_BACKGROUND = Color.BLACK.getRGB();
	/**
	 * Default foreground color
	 */
	private final static int DEFAULT_FOREGROUND = Color.WHITE.getRGB();
	/**
	 * Default hover color for buttons
	 */
	private final static int DEFAULT_HOVER = Color.GRAY.getRGB();
	/**
	 * Default gap between buttons and the side of the box
	 */
	private final static int GAP = 5;
	/**
	 * Default message
	 */
	private static final String DEFAULT_LABEL = "Like me ?";
	/**
	 * Max mark
	 */
	private final int highestMark;

	/**
	 * Whether the rank's buttons are visible or not
	 */
	private boolean visible = false;
	/**
	 * Wheter the user has voted or not
	 */
	private boolean hasVoted = false;

	/**
	 * The average mark given to the sketch/to this pollId
	 */
	private float mark = 0;

	/**
	 * X position of the rank box
	 */
	private int x = 0;
	/**
	 * Y position of the rank box
	 */
	private int y = 0;
	/**
	 * Width of the rank box
	 */
	private int w = GAP*6+5*10; // There is 6 gaps horizontally, one each side and one between each button
	/**
	 * Height of the rank box
	 */
	private int h = 2*GAP+10; // 2 gaps vertically
	/**
	 * Size of the rank button
	 */
	private int size = 10;

	/**
	 * Label to "prompt" the user
	 */
	private String label = DEFAULT_LABEL;
	/**
	 * Heigt of the label
	 */
	private int labelH;

	/**
	 * Background color of the rank box
	 */
	private int background = DEFAULT_BACKGROUND;
	/**
	 * Foreground color of the message and the buttons
	 */
	private int foreground = DEFAULT_FOREGROUND;
	/**
	 * Hover color of the button
	 */
	private int hover = DEFAULT_HOVER;

	/**
	 * Font, ignored if null
	 */
	private PFont font = null;
	
	/**
	 * PShape to use instead of ellipse(), ignored if null
	 */
	private PShape shape = null;

	/**
	 * PShapeS to use for each button , ignored if null
	 */
	private PShape[] shapes = null;
	
	/**
	 * Method called when the user voted
	 */
	private Method eventHandler;

	/**
	 * Creates a new Like voting box with 5 different marks (5 buttons).
	 * 
	 * @param parent The Processing sketch to use and draw to (usually <code>this</code>)
	 * @param url URL where the PHP script and SQL are installed properly
	 * @param pollId An ID number > 0 that separates different sketches from each others, or groups of different sketches from each others, so mean values are useful
	 * @throws MalformedURLException if the URL's syntax is not correct
	 * @throws IllegalArgumentException if pollId <= 0
	 */
	public Like(PApplet parent, String url, int pollId) throws MalformedURLException, IllegalArgumentException {
		super(parent, url, pollId);
		
		this.highestMark = DEFAULT_HIGHEST_MARK;
		
		createLike();
	}
	
	/**
	 * Creates a new Like voting box with highestMark different marks.
	 * 
	 * @param parent The Processing sketch to use and draw to (usually <code>this</code>)
	 * @param url URL where the PHP script and SQL are installed properly
	 * @param pollId An ID number > 0 that separates different sketches from each others, or groups of different sketches from each others, so mean values are useful
	 * @param highestMark The highest possible mark (number of buttons) between 2 and 9 inclusive
	 * @throws MalformedURLException if the URL's syntax is not correct
	 * @throws IllegalArgumentException if pollId <= 0
	 */
	public Like(PApplet parent, String url, int pollId, int highestMark) throws MalformedURLException, IllegalArgumentException {
		super(parent, url, pollId);
		
		if (highestMark > 1 && highestMark < 10)
			this.highestMark = highestMark;
		else
			this.highestMark = DEFAULT_HIGHEST_MARK;

		createLike();
	}

	/**
	 * Sets the position and size of the voting box. Note that the box will always be big enough to contain the label.
	 * @param x x position of the box
	 * @param y y position of the box
	 * @param w width of the box
	 * @param h height of the box
	 */
	public void setBounds(int x, int y, int w, int h) {
		// Remember that the sketch's methods should'nt be used here, as we have no idea of the context
		// Used PApplet methods are not drawing anything - they are only used to process width and height
		
		parent.pushStyle();

		if (font != null) parent.textFont(font);
		int labelW = PApplet.round(parent.textWidth(label))+2*GAP; // gap, right, left, gap
		labelH = PApplet.round(parent.textAscent()+parent.textDescent()+GAP); // up, down and top gap

		parent.popStyle();

		this.x = x;
		this.y = y;
		this.w = Math.max(labelW+((highestMark+1)*(GAP+1)), w); // Let's take the strict minimum width, either the space needed for the label or the space for gaps+a 1 pixel button
		this.h = Math.max(labelH+2*GAP+1, h); // Same as width

		size = Math.min((this.w-(highestMark+1)*GAP)/highestMark,(this.h-2*GAP-labelH)); // Size of a button

	}

	/**
	 * Sets the label of the voting box, a message to invite the user to give his advice
	 * @param label the message to display
	 */
	public void setLabel(String label) {
		this.label = label;
		setBounds(x, y, w, h);
	}

	/**
	 * Sets the colors of the voting box. You can use the color() method of Processing to get a valid color
	 * @param backGround the color wich fills the rectangle of the voting box
	 * @param foreGround the color wich fills the buttons and the label, and the stroke of the voting box
	 * @param hover the color wich fills the buttons when mouse is over or they display the average
	 */
	public void setColors(int backGround, int foreGround, int hover) {
		this.background = backGround;
		this.foreground = foreGround;
		this.hover = hover;
	}

	/**
	 * Sets the font to use for displaying the label. You can use createFont() or loadFont() to get the PFont you need.
	 * @param font the PFont for displaying the label
	 */
	public void setFont(PFont font) {
		this.font = font;
		setBounds(x, y, w, h);
	}

	/**
	 * Sets the voting box visible and ready to be used.
	 * @param visible true to enable the voting box, false to disable it
	 */
	public void setVisible(boolean visible) {
		this.visible = visible;
	}
	
	/**
	 * Sets a PShape (svg files) that will be used to draw all buttons. You can use loadShape() to load shapes. </br> 
	 * Note that shape's style (colors) will be disabled.
	 * @param shape the shape that will be used to draw buttons
	 */
	public void setShape(PShape shape) {
		this.shape = shape;
		shape.disableStyle();
	}
	
	/**
	 * Sets an array of PShapes (svg files) that will be used for each button. You can use loadShape() to load shapes. </br> 
	 * Note that shape's style (colors) will be disabled. </br>
	 * The given array must have the same lenght as the highestMark defined when constructing (or 5 if it was left to the default value) </br>
	 * The PShape at the index 0 of the array will be used for the first button, the PShape at index 1 will be used for the second button </br>
	 * Note that the method will have no effect if the array is not the right length or if a PShape contained in the array is null.
	 * @param shapes
	 */
	public void setShapes(PShape[] shapes) {
		if (shapes.length != highestMark) return;
		
		for (PShape shape : shapes) {
			if (shape != null) shape.disableStyle(); else return;
		}
		this.shapes = shapes;
	}

	/**
	 * Returns true if the user has voted. False will be returned if :
	 * -User didn't voted yet </br>
	 * -No internet connection or server is down </br>
	 * -User already voted for this sketch </br>
	 * -Problem occured server side (SQL connection, PHP Warning ...) </br>
	 * An error message can be printed to the console if the user votes and an error happens
	 * @return true if the user has voted successfully, false if an error happened or if he didn't vote yet
	 */
	public boolean hasVoted() {
		return hasVoted;
	}

	/**
	 * Returns the average mark. This will return 0 if an error occured, and won't refresh the value, <br/>
	 * so it will be always the same value until the user votes (if he didn't vote yet) or you call getAverage(true). <br/>
	 * This method is a shortcut for getAverage(false)
	 * When hasVoted() returns true, this methods should return an integer between 1 and highestMark (number of buttons)
	 * @return the average mark
	 */
	public float getAverage() {
		return getAverage(false);
	}
	
	/**
	 * Returns the average mark. This will return 0 if an error occured. With true, the method will send a request <br/>
	 * to fetch the last average mark. With false, it will return the mark previously stored average if there is one <br/>
	 * or fetch it from the server if there wasn't or if last time, an error occured.
	 * @param forceRefresh
	 * @return the average mark
	 */
	public float getAverage(boolean forceRefresh) {
		if (forceRefresh || mark==0) average();
		return mark;
	}
	
	/**
	 * Vote with the mark given in parameter. This is useful if you want to implement your own GUI for voting, instead of using the provided voting box.<br/>
	 * The voted() method of your sketch will be called before returning from this method.
	 * @param mark
	 */
	public void setVote(int mark) {
		if (mark > highestMark || hasVoted) return;
		
		this.mark = mark;
		vote();
	}
	
	/**
	 * Draws the voting box
	 */
	public void draw() {
		if (!visible) return;

		parent.pushStyle();
		parent.ellipseMode(PConstants.CORNER);
		parent.textAlign(PConstants.LEFT, PConstants.TOP);
		
		parent.stroke(DEFAULT_FOREGROUND);
		parent.strokeWeight(2);
		parent.fill(background);
		parent.rect(x, y, w, h);

		if (font != null) parent.textFont(font);
		parent.noStroke();
		parent.fill(foreground);
		parent.text(label, x+GAP, y+GAP);

		for (int i=0; i<highestMark; i++) {
			drawButton(i);
		}

		parent.popStyle();
	}

	/**
	 * Reacts to a mouse event
	 * @param event
	 */
	public void mouseEvent(MouseEvent event) {
		if (!visible || hasVoted) return;
		
		if (event.getAction() == MouseEvent.CLICKED) {
			for (int i=0; i<highestMark; i++) {
				if (isOverButton(i)) {
					mark = i+1;
					vote();
					return;
				}
			}
		}
	}
	
	/**
	 * Common method for constructors
	 */
	private void createLike() {
		try {
			eventHandler = parent.getClass().getMethod("voted", new Class[0]);
		} catch (Exception e) {
			eventHandler = null;
		}

		parent.registerMethod("draw", this);
		parent.registerMethod("mouseEvent", this);
	}
	
	
	/**
	 * Draws the buttons
	 * @param pos
	 */
	private void drawButton(int pos) {
		// If mouse is over and we didn't vote yet or we voted and so we display the average
		if ((isOverButton(pos) && !hasVoted) ||  (pos+1 <= Math.round(mark) && hasVoted)) parent.fill(hover); else parent.fill(foreground);

		/*
		 *  If no shape were set, use ellipse() to draw a circle, else if several shapes are set, use the right one for the
		 *  current drawn button, finally, if only one shape was defined, use this shape, wichever is the drawn button.
		 */
		if (shape == null && shapes == null)
			parent.ellipse(getButtonX(pos), y+labelH, size, size);
		else if (shapes != null)
			parent.shape(shapes[pos], getButtonX(pos), y+labelH, size, size);
		else
			parent.shape(shape, getButtonX(pos), y+labelH, size, size);
	}

	/**
	 * Sends the vote and gets the average
	 */
	private void vote() {
		if (hasVoted) return;

		try {
			readMark(request("vote", new String[]{"id", "mark"}, new String[]{String.valueOf(id), String.valueOf(mark)}).getInputStream());
			
			if (mark > 0 && mark <= highestMark) hasVoted = true; else
				PApplet.println("Like : server side error while voting : "+mark);
			
			if (eventHandler != null) {
				eventHandler.invoke(parent, new Object[0]);
			}
			
		} catch (IOException e) {
			PApplet.println("Like : IOException while voting : "+e.getLocalizedMessage());
			hasVoted = false;
			mark = 0;
		} catch (IllegalArgumentException e) {
			return;
		} catch (IllegalAccessException e) {
			return;
		} catch (InvocationTargetException e) {
			return;
		}
	}
	
	/**
	 * Gets the average from the server
	 */
	private void average() {
		if (hasVoted) return;

		try {
			readMark(request("average", new String[]{"id"}, new String[]{String.valueOf(id)}).getInputStream());

			
			if (!(mark > 0 && mark <= highestMark)) {
				PApplet.println("Like : server side error while reading average : "+mark);
				mark = 0;
			}
			
		} catch (Exception e) {
			PApplet.println("Like : IOException while reading average : "+e.getLocalizedMessage());
		}
	}
	
	/**
	 * Reads the mark from an input stream
	 * @throws IOException 
	 * @throws NumberFormatException 
	 *
	 */
	private void readMark(InputStream input) throws NumberFormatException, IOException {
		BufferedReader in = new BufferedReader(new InputStreamReader(input));
		
		String markStr = in.readLine();
		if (markStr.equals(ERROR)) throw new IOException("Server side error");

		
		mark = Float.valueOf(markStr).floatValue();
	}

	/**
	 * Gets the X position of a button
	 * @param pos
	 * @return
	 */
	private int getButtonX(int pos) {
		return x+GAP+pos*(size+GAP);
	}

	/**
	 * Returns true if the mouse is over a button
	 * @param pos
	 * @return
	 */
	private boolean isOverButton(int pos) {
		return (parent.mouseX > getButtonX(pos) && parent.mouseX < getButtonX(pos)+size
				&& parent.mouseY > y+labelH && parent.mouseY < y+h);
	}

}
