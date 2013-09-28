/*
 * Share is a Processing library written by Nucky (http://www.nucky.io).
 * 
 * This software is distributed under the GNU GPL 3 license (http://www.gnu.org/licenses/gpl.html).
 * Share is provided "as is", with no warranty of any kind.
 * It should be used with Processing. Processing core library is under GNU LGPL license.
 */

package nucky.share;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;

import processing.core.PApplet;;

/**
 * A class that allows to share string messages with other sketches over a web server.
 * The library requires a PHP/SQL server with the share library PHP scripts, and the SQL table properly installed.
 * @author Nucky
 */
public class Talk extends Share {

	
	/**
	 * Default fetching rate
	 */
	private static final long DEFAULT_FETCH_RATE = 30*1000; // That's 30 seconds in miliseconds
	
	/**
	 * First fetch once the object is created
	 */
	private static final long FIRST_FETCH = 100;

	
	/**
	 * Fetching messages rate
	 */
	private final long fetchRate;

	/**
	 * Set of all the messages so we don't fire event for an already received message
	 */
	private final ArrayList<String> messages = new ArrayList<String>();
	
	/**
	 * Queue of messages waiting to be delivered to the sketch
	 */
	private final ArrayList<String> messagesQueue = new ArrayList<String>();
	
	/**
	 * Method of the sketch for hanlding incoming new messages
	 */
	private Method eventHandler;
	
	/**
	 * Timer for fetching messages async
	 */
	private Timer schedule;
	
	/**
	 * Creates a Talk object that send and receive string messages. This will try to get new messages every 30 seconds.
	 * @param parent Parent PApplet (Processing Sketch) (usually <code>this</code>)
	 * @param url URL to the HTTP server where the Share PHP scripts are installed
	 * @param talkId ID of the talk > 0 (some kind of channel id)
	 * @throws MalformedURLException if there was an error parsing the given URL
	 * @throws IllegalArgumentException if talkId <= 0
	 */
	public Talk(PApplet parent, String url, int talkId) throws MalformedURLException, IllegalArgumentException {
		super(parent, url, talkId);


		this.fetchRate = DEFAULT_FETCH_RATE;

		createTalk();
	}

	/**
	 * Creates a Talk object that send and receive ciphered string messages. This will try to get new messages every refreshRate miliseconds.
	 * @param parent Parent PApplet (Processing Sketch) (usually <code>this</code>)
	 * @param url URL to the HTTP server where the Share PHP scripts are installed
	 * @param talkId ID of the talk > 0 (some kind of channel id)
	 * @param refreshRate delay to periodically connect to the server and read new messages (in miliseconds)
	 * @throws MalformedURLException if there was an error parsing the given URL
	 * @throws IllegalArgumentException if talkId <= 0
	 */
	public Talk(PApplet parent, String url, int talkId, long refreshRate) throws MalformedURLException, IllegalArgumentException {
		super(parent, url, talkId);


		this.fetchRate = refreshRate;

		createTalk();
	}


	/**
	 * Returns true if the given string message was sent to the server
	 * @param messageToSend string to share
	 * @return true if the message was successfully sent
	 */
	public synchronized boolean sendMessage(String messageToSend) {
		HttpURLConnection connection = request("post", new String[]{"talkId","message"}, new String[]{String.valueOf(id),messageToSend});
		if (connection == null) return false;
		
		
		String result = "";
		try {
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			result = in.readLine();
			connection.disconnect();
		} catch (IOException e) {
			PApplet.println("Talk : Exception while sending message : "+e.getLocalizedMessage());
			return false;
		}

		if (result.equals(SUCCESS)) {
			messages.add(messageToSend);
			return true;
		} else return false;
	}

	/**
	 * Calls the event handler method receivedMessage
	 */
	public synchronized void pre() {
		if (eventHandler == null) return; // If there is no event handler, there is no use here
		
		for (String message : messagesQueue) {
			try {
				eventHandler.invoke(parent, new Object[]{message});
			} catch (Exception e) {

			}
		}
		
		messagesQueue.clear();
	}
	
	/**
	 * Returns an array containing all received message at the time of the invocation.
	 * @return A string array containing all the messages received.
	 */
	public synchronized String[] getMessages() {
		return messages.toArray(new String[messages.size()]);
	}
	public void dispose() {
		schedule.cancel();
	}

	/**
	 * Common method for constructors, finds event handler and start the scheduled refresh job
	 */
	private void createTalk() {
		try {
			eventHandler = parent.getClass().getMethod("messageReceived", new Class[]{String.class});
		} catch (Exception e) {
			eventHandler = null;
		}

		schedule = new Timer();
		schedule.schedule(new TimerTask() {
			@Override
			public void run() {
				fetch();
			}

		}, FIRST_FETCH, fetchRate);
		
		if (eventHandler != null) {
			parent.registerMethod("pre",this); // If there is an event handler method, it will be called during pre() for synchronization reasons
			parent.registerMethod("dispose", this); // Used to drop timer properly
		}
	}

	/**
	 * Fetches new messages from the server
	 */
	private synchronized void fetch() {
		// parent.println("fetching ...");
		
		HttpURLConnection connection = request("fetch", new String[]{"talkId"}, new String[]{String.valueOf(id)});
		if (connection == null) return;
		
		try {
			// Reading every message
			BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String last = in.readLine();
			
			if (last.equals(ERROR)) return;
			
			while (last != null) {
				String message = last;

				// If we never knew about this message, remember it and let the sketch know about it
				if (!messages.contains(message) && message != null) {
					messages.add(message); // Remember this message so we don't fire another event about it
					messagesQueue.add(message); // Remember to deliver this message at the next pre() call
				}

				last = in.readLine();
			}
			in.close();

			connection.disconnect();
			
		} catch (IOException e) {
			PApplet.println("Talk : Exception while fetching messages : "+e.getLocalizedMessage());
		}

	}



}
