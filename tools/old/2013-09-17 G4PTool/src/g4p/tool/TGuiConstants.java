package g4p.tool;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;

public interface TGuiConstants {
	
	
	// Selection box size
	int HANDLE_SIZE		= 	6;
	
	// Mouse over constants
	int OVER_NONE			=	0x00000000;
	int OVER_COMP			=	0x00000200;
	int OVER_HORZ			=	0x00000201;
	int OVER_VERT			=	0x00000202;
	int OVER_DIAG			=	0x00000203;

	/*
	 * The next three sets are to provide simple constants 
	 * when using the combo-box for alignment and button style.
	 * 
	 * It is important that the constants start at zero and match
	 * the value index in the combo-box model. 
	 * So do NO change.
	 */
	int LEFT				= 	0x00000000;
	int RIGHT				= 	0x00000001;
	int CENTER				= 	0x00000002;

	int TOP					= 	0x00000000;
	int BOTTOM				= 	0x00000001;
	int MIDDLE				= 	0x00000002;

	int TEXT_ONLY			= 	0x00000000;
	int ICON_ONLY			= 	0x00000001;
	int TEXT_AND_ICON		= 	0x00000002;

	// Fonts
    Font displayFont 		= new Font("Sans Serif", Font.PLAIN, 11);

    
	// Drawing constants
	BasicStroke stdStroke 	= new BasicStroke(1.1f,
			BasicStroke.CAP_ROUND,	BasicStroke.JOIN_ROUND);
	
	BasicStroke selStroke 	= new BasicStroke(1.8f,
			BasicStroke.CAP_ROUND,	BasicStroke.JOIN_ROUND);
	
	BasicStroke needleStroke 	= new BasicStroke(2.3f,
			BasicStroke.CAP_ROUND,	BasicStroke.JOIN_ROUND);

	BasicStroke heavyStroke 	= new BasicStroke(2.8f,
			BasicStroke.CAP_ROUND,	BasicStroke.JOIN_ROUND);

	BasicStroke dashed 	= new BasicStroke(1.1f,
			BasicStroke.CAP_ROUND,	BasicStroke.JOIN_ROUND, 4.0f,
			new float[] {2,4, 1,2, 1,4}, 0.0f);

	Color DASHED_EDGE_COLOR		= new Color(32,32,32,128);
	
    
    Color csdrBack			= new Color(0,0,0, 8);
    Color csdrBorder		= new Color(0,0,0, 32);
    Color csdrSlideBack		= new Color(220, 220, 220);
    Color csdrSlideBorder	= new Color(64, 64, 64);
    Color csdrThumb			= new Color(255,255,0);
    
}
