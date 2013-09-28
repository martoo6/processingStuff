package nucky.share;

import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

import processing.core.PApplet;

/**
 * Superclass for the Share classes
 * @author Twixz
 *
 */
abstract class Share {

	/**
	 * Charset used to talk with the server
	 */
	public static final String ENCODING = "UTF-8";
	
	public static String ERROR = "ERR";
	public static String SUCCESS = "OK";
	
	/**
	 * Parent Processing sketch (a PApplet instance)
	 */
	protected final PApplet parent;
	
	/**
	 * Some string for the Share instance, like an URL or a hostname
	 */
	protected final URL url;
	
	/**
	 * Some ID for the Share instance, like a poll ID
	 */
	protected final int id;
	
	/**
	 * Creates a new instance of a Share class with a parent sketch, a string and an id
	 * @param parent
	 * @param url
	 * @param id
	 * @throws MalformedURLException 
	 */
	Share(PApplet parent, String url, int id) throws MalformedURLException {
		if (id <= 0) throw new IllegalArgumentException();
		
		this.parent = parent;
		this.url = new URL(url);
		this.id = id;
	}

	/**
	 * Generates an HttpUrlConnection from a POST query - connects to the HTTP server and send parameters
	 * @param mode mode POST parameter
	 * @param paramNames other POST parameters names
	 * @param paramValues other POST parameters values
	 * @return
	 */
	protected HttpURLConnection request(String mode, String[] paramNames, String[] paramValues) {
		if (paramNames.length != paramValues.length) return null; // Must have one value per parameter name
	
		try { 
			String urlParameters = "mode="+mode;
			for (int i=0; i<paramNames.length; i++) {
				urlParameters = urlParameters + "&"+URLEncoder.encode(paramNames[i],ENCODING)+"="+URLEncoder.encode(paramValues[i], ENCODING);
			}
	
			// Get connection
			HttpURLConnection connection = (HttpURLConnection) url.openConnection(); 
	
			// Set connection attibutes
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setInstanceFollowRedirects(false); 
			connection.setUseCaches (false);
	
			// Method
			connection.setRequestMethod("POST"); 
			// Headers
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded"); 
			connection.setRequestProperty("Charset", "utf-8");
			connection.setRequestProperty("Content-Length", "" + Integer.toString(urlParameters.getBytes(ENCODING).length));
	
			// Writing parameters
			OutputStream wr = connection.getOutputStream ();
			wr.write(urlParameters.getBytes(ENCODING));
			wr.flush();
			wr.close();
	
			return connection;
	
	
		} catch (Exception e) {
			PApplet.println("Talk : Exception during request : "+e.getLocalizedMessage());
			return null;
		}
	}
	
}
