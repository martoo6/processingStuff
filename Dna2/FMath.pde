static abstract class FMath {
  static int degreesDetail;
  static float []cosineVals;
  static float []sineVals;
  static float []tangVals;
  static float step;

  static void init(int _degreesDetail) {
    degreesDetail = _degreesDetail;
    cosineVals = new float[degreesDetail];
    sineVals = new float[degreesDetail];
    tangVals = new float[degreesDetail];
    step= TWO_PI/degreesDetail;
    for (int i=0;i<degreesDetail;i++) {
      cosineVals[i]=cos(step*i);
      sineVals[i]=sin(step*i);
      tangVals[i]=tan(step*i);
    }
  }

  private static int rightAngle(float val) {
    //val= val%TWO_PI; //Ineficiente vaya uno a saber porque...
    val-=TWO_PI*floor(val/TWO_PI);
    return floor((val/TWO_PI)*degreesDetail);
    //return floor(map(val,0,TWO_PI, 0, cant-1));
  }

  public static float cosine(float val) {
    return cosineVals[rightAngle(val)];
  }
  public static float sine(float val) {
    return sineVals[rightAngle(val)];
  }
  public static float tang(float val) {
    return tangVals[rightAngle(val)];
  }
}
