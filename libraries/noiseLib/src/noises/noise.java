package noises;

import interpolations.Interpolation;
import java.util.ArrayList;

public class noise {
	ArrayList values=new ArrayList();
	Interpolation type;

	//Compound Value parameters 
	int detail=4;
	float contrast=0.55f;

	public noise setInterpolation(Interpolation type) {
		this.type=type;
		return this;
	}

	public noise setDetail(int detail) {
		this.detail=detail;
		return this;
	}

	public noise setContrast(float contrast) {
		this.contrast=contrast;
		return this;
	}

	public noise(Interpolation type) {
		this.type = type;
	}

	public float getSimpleValue(float ... val) {
		return type.getValue(values, val);
	}

	public float getCompoundValue(float ... val) {
		float total=0;
		int freq=1;
		float amp=contrast;
		for (int i=0;i<detail;i++) {
			for (int e=0;e<val.length;e++) {
				val[e]*=freq;
			}
			total+=this.getSimpleValue(val)*amp;
			freq*=2;//Siempre duplicamos la frecuencia, equivalente a cambiar de octava
			amp*=contrast;
		}
		return total;
	}
}
