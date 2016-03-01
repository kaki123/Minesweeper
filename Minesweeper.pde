

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
    for(int i=0; i<bombs.size(); i++)
    if(bombs.get(i).isMarked()==true){
        return true;
    }
    return false;
}
public void displayLosingMessage()
{
    buttons[5][5].setLabel("Y");
    buttons[5][6].setLabel("O");
    buttons[5][7].setLabel("U");
    buttons[5][8].setLabel("");
    buttons[5][9].setLabel("L");
    buttons[5][10].setLabel("O");
    buttons[5][11].setLabel("S");
    buttons[5][12].setLabel("E");
}
public void displayWinningMessage()
{
    buttons[5][5].setLabel("Y");
    buttons[5][6].setLabel("O");
    buttons[5][7].setLabel("U");
    buttons[5][8].setLabel("");
    buttons[5][9].setLabel("W");
    buttons[5][10].setLabel("I");
    buttons[5][11].setLabel("N");
    buttons[5][12].setLabel("!");

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
        if(mouseButton == RIGHT){
            marked=!marked;
        }
        clicked=true;
        
        if(bombs.contains(this)){
            stroke(255,255,255);
            displayLosingMessage();
        }

        else if(countBombs(r,c)>0){
            setLabel(str(countBombs(r,c)));  
        }

        else{
              if (isValid(r, c-1) && buttons[r][c-1].isClicked() == false) {
                buttons[r][c-1].mousePressed();
              }
              if (isValid(r, c+1) && buttons[r][c+1].isClicked() == false) {
                buttons[r][c+1].mousePressed();
              }
              if (isValid(r-1, c-1) && buttons[r-1][c-1].isClicked() == false) {
                buttons[r-1][c-1].mousePressed();
              }
              if (isValid(r-1, c) && buttons[r-1][c].isClicked() == false) {
                buttons[r-1][c].mousePressed();
              }
              if (isValid(r-1, c+1) && buttons[r-1][c+1].isClicked() == false) {
                buttons[r-1][c+1].mousePressed();
              }
              if (isValid(r+1, c) && buttons[r+1][c].isClicked() == false) {
                buttons[r+1][c].mousePressed();
              }
              if (isValid(r+1, c+1) && buttons[r+1][c+1].isClicked() == false) {
                buttons[r+1][c+1].mousePressed();
              }
              if (isValid(r+1, c-1) && buttons[r+1][c-1].isClicked() == false) {
                buttons[r+1][c-1].mousePressed();
              }
            /*for(int r1=-1;r1<2;r1++){
                for(int c1=-1;c1<2;c1++){
                    if( isValid(r + r1, c + c1) && buttons[r + r1][c + c1].isClicked()==false)
                        buttons[r + r1][c + c1].mousePressed();
                   
                }
            }*/
           /* if(isValid(r,c-1) && !buttons[r][c-1].isClicked()){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked()){
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked()){
                buttons[r-1][c].mousePressed();
            }
           if(isValid(r+1,c) && !buttons[r+1][c].isClicked()){
                buttons[r+1][c].mousePressed();
            } */
        }
            
        
      /*   else if(bombs.contains(this)){
           displayLosingMessage();
        }
        else if(countBombs(r,c)>0){
            setLabel(str(countBombs(r,c)));
        }*/
       /* else{
            if(isValid(r,c-1) && buttons[r][c-1].isMarked()){
                buttons[r][c-1].mousePressed();
            }
            if(isValid(r,c+1) && buttons[r][c+1].isMarked()){
                buttons[r][c+1].mousePressed();
            }
            if(isValid(r-1,c) && buttons[r-1][c].isMarked()){
                buttons[r-1][c].mousePressed();
            }
           if(isValid(r+1,c) && buttons[r+1][c].isMarked()){
                buttons[r+1][c].mousePressed();
            }   
        }*/
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
        if(r<=NUM_ROWS&&c<=NUM_COLS&&r>=0&&c>=0){
            return true;
        }
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



