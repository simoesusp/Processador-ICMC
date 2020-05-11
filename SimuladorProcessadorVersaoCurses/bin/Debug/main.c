#include <curses.h>
#include <stdlib.h> // Malloc - Calloc - Free - Rand

void explode(int xe,int ye)
{

	int z;
	double z1;
	for(z = 0; z<30; z=z+1)
	{
		mvprintw(ye,xe, "*");
		xe = xe + (int) (rand() %3 - 1);
		ye = ye + (int) (rand() %3 - 1);
		// Delay01seg
		for(z1 = 0.0; z1<4000000.0; z1=z1+2)
			z1=z1-1;
		refresh();      /* Print it on to the real screen */
	}
	move(0,0);
	refresh();
	getchar();        /* Wait for user input */
}

int main()
{
    WINDOW *w = 0;

	int key;
	double i = 0.0, j = 0.0, k = 0.0;
	int x = 1, y = 1;
	int xb = 10, yb = 10;
	int dir = 0;
	int xd = 0, yd = 0;
	//printf("ARG!");

	w = initscr();      /* Start curses mode 		  */
	noecho();   //???
    clear();
	cbreak();
	keypad(w, TRUE);
	//printw("Hello World!");    /* Print Hello World		  */
	//mvprintw(5,5, "OI");
	//refresh();      /* Print it on to the real screen */

loop:
	//if(kbhit())
	//{
	timeout(0);
	key = wgetch(w);        /* Wait for user input */

	mvprintw(y,x, " ");

	if (key == KEY_LEFT)
		x--;
	if (key == KEY_RIGHT)
		x++;
	if (key == KEY_UP)
		y--;
	if (key == KEY_DOWN)
		y++;
	if (key == 'q')
		goto fim;

	mvprintw(y,x, "X");

	mvprintw(0,0, "X= %2d  Y= %2d", x, key);
	//refresh();      /* Print it on to the real screen */
	//}

	// Move Bolinha
	mvprintw(yb,xb, " ");

//	xb = xb + (int) (rand() %3 - 1);
//
//	if(xb<0)    xb=0;
//	if(xb>79)   xb=79;
//
//	yb = yb + (int) (rand() %3 - 1);
//	if(yb<0)    yb=0;
//	if(yb>24)   yb=24;

//    dir = dir + (int) (rand() %5 - 2);
    dir = dir + (int) (rand() %3 - 1);
    if (dir < 0)
        dir = dir + 8;
    if (dir > 7)
        dir = dir - 8;

    switch(dir){
        case 0:
            xd = 0;
            yd = -1;
            break;
        case 1:
            xd = 1;
            yd = -1;
            break;
        case 2:
            xd = 1;
            yd = 0;
            break;
        case 3:
            xd = 1;
            yd = 1;
            break;
        case 4:
            xd = 0;
            yd = 1;
            break;
        case 5:
            xd = -1;
            yd = 1;
            break;
        case 6:
            xd = -1;
            yd = 0;
            break;
        case 7:
            xd = -1;
            yd = -1;
            break;
    }



    yb = yb + yd;
    xb = xb + xd;

    if (yb == -1)
        yb = 24;
    if (yb == 25)
        yb = 0;
    if (xb == -1)
        xb = 79;
    if (xb == 80)
        xb = 0;

	mvprintw(yb,xb, "O");

	mvprintw(0,15, "Xb= %2d  Yb= %2d", xb, yb);
	// Fim Move Bolinha

	refresh();      /* Print it on to the real screen */

	if((x==xb) && (y==yb))
	{
		explode(x,y);
		goto fim;
	}

// Delay01seg
	for(i = 0.0; i<10000000.0; i=i+1)
		//for(j = 0.0; j<63000.0; j=j+1)
		k=j-i;

	goto loop;

fim:
	endwin();       /* End curses mode		  */
	//printf("oRG!");
	return 0;
}



