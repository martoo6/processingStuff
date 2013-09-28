package interpolations;

import java.util.ArrayList;
import java.util.List;

public class Linear extends Interpolation {
	public float getInterpolation(float y1, float y2, float x) {
		return (y2-y1)*x+y1;
	}
	@Override
	public float getValue(ArrayList values, List<Float> dim) {
		int dimF = (int) Math.floor(dim.get(dim.size()-1));
		if (dim.size()==1) {//Caso base, una unica dimension o valor
			while (dimF+2>values.size ()) {
				values.add(Math.random());
			}
			return getInterpolation((Float)values.get(dimF), (Float)values.get(dimF+1), dim.get(0)-dimF);
		}
		while (dimF+2>values.size ()) {
			values.add(new ArrayList());
		}
		List<Float> tmpList=dim.subList(0, dim.size()-1);
		float val1=getValue((ArrayList)values.get(dimF), tmpList);
		float val2=getValue((ArrayList)values.get(dimF+1), tmpList);
		return getInterpolation(val1, val2, dim.get(dim.size()-1)-dimF);
	}

}
