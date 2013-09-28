public interface ColisionDetection extends MovementObserver{
  public void calculate();
  public void init(ArrayList<Element> allElements);
  public void renderGrid();
}
