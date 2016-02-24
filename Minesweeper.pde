

import de.bezier.guido.*;
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    
    for(int rows = 0; rows< NUM_ROWS; rows++){
        for(int cols = 0; cols< NUM_COLS; cols++){
          buttons[rows][cols] = new MSButton(rows, cols);
        }
    }
    
    

            setBombs();
    
}
public void setBombs()
{
    int r= (int)(Math.random()*NUM_ROWS);
    int c= (int)(Math.random()*NUM_COLS);
    
    if(!bombs.contains(buttons[r][c])){
        bombs.add(buttons[r][c]);
        setBombs();
    }
}


public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(keyPressed==true){
            marked= false; 
        }
        else if(bombs.contains(this)){
           displayLosingMessage();
        }
        else if(countBombs(r,c)>0){
            setLabel(str(countBombs(r,c)));
        }
        else {
            if(isValid(r,c) && buttons[r][c-1].isMarked()==false){
                buttons[r][c-1].mousePressed();
            
                buttons[r][c+1].mousePressed();
         
                buttons[r-1][c].mousePressed();
           
                buttons[r+1][c].mousePressed();
             }   
        }
    }


    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r<=400&&r>0&c<=400&&c>0){
            return true;}
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for(int r=-1; r<=1; r++){
            for(int c= -1; c<=1; c++){
                 if(buttons[row+r][col+c].isValid(row, col)&& bombs.contains(buttons[row+r][col+c])){
                        numBombs++;
                 }
                     
            }
        }
        return numBombs;
    }

}



