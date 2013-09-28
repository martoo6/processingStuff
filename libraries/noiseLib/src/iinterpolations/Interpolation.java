package interpolations;

import java.util.ArrayList;
import java.util.List;

public abstract class Interpolation {
	public float getValue(ArrayList values, float ... dim){
		ArrayList<Float> list = new ArrayList<>();
		for(Float tmpDim:dim){
			list.add(tmpDim);
		}
	    return getValue(values, list);
	}

	public abstract float getValue(ArrayList values, List<Float> dim);
}
