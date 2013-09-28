package interpolations;

import java.util.ArrayList;
import java.util.List;

public class Cubic extends Interpolation{
	public float getInterpolation(float y1, float y2, float y3, float y4, float x) {
		return (float) ((-0.5 *y1 + 1.5*y2 - 1.5*y3 + 0.5*y4)*Math.pow(x, 3)+(y1-2.5*y2+2*y3-0.5*y4)*Math.pow(x, 2) +(-0.5*y1+0.5*y3)*x+y2);
	}
	@Override
	public float getValue(ArrayList values, List<Float> dim) {
		int dimF = (int) Math.floor(dim.get(dim.size()-1));
		if (dim.size()==1) {//Caso base, una unica dimension o valor);
			while (dimF+4>values.size ()) {
				values.add(Math.random());
			}
			return getInterpolation((Float)values.get(dimF), (Float)values.get(dimF+1), (Float)values.get(dimF+2), (Float)values.get(dimF+3), dim.get(0)-dimF);
		}
		while (dimF+4>values.size ()) {
			values.add(new ArrayList());
		}
		List<Float> tmpDim=dim.subList(0, dim.size()-1);
		float val1=getValue((ArrayList)values.get(dimF), tmpDim);
		float val2=getValue((ArrayList)values.get(dimF+1), tmpDim);
		float val3=getValue((ArrayList)values.get(dimF+2), tmpDim);
		float val4=getValue((ArrayList)values.get(dimF+3), tmpDim);
		return getInterpolation(val1, val2, val3, val4, dim.get(dim.size()-1)-dimF);
	}
}
