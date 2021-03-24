#include <stdio.h>
#include <stdbool.h>
#include <gtk/gtk.h>

#define MAXIMUM 30

int height = MAXIMUM, width = MAXIMUM;
char mapa[MAXIMUM][MAXIMUM];

bool visited[MAXIMUM][MAXIMUM];
bool zajete[MAXIMUM][MAXIMUM];



bool polaczenie_z(int p1, int p2, char meta)
{

    visited[p1][p2] = true;

    int kierunki[4][2] = {{1,0},{-1,0},{0,1},{0,-1}};

    for(int i = 0 ; i < 4 ; i++)
    {
        int np1 = p1 + kierunki[i][0];
        int np2 = p2 + kierunki[i][1];

        if(mapa[np1][np2]==meta && !zajete[np1][np2])
        {
            zajete[np1][np2] = true;
            return true;
        }

        if(np1>=0 && np1<height && np2>=0 && np2 <width && !visited[np1][np2] && mapa[np1][np2]=='#')
            if(polaczenie_z(np1,np2,meta))
                return true;

    }

    return false;

};

void clear(void)
{
    for(int i = 0 ; i < MAXIMUM ; i++)
        for(int j = 0 ; j < MAXIMUM ; j++)
            visited[i][j] = false;
};


int main(int argc, char **argv)
{
    int height, width;

    int K = 0, E = 0;

    scanf("%d %d", &width, &height);

    for(int i = 0 ; i < height ; i++)
        for(int j = 0 ; j < width ; j++)
        {
            scanf(" %c",&mapa[i][j]);

            if(mapa[i][j]=='K') K++;
            if(mapa[i][j]=='E') E++;

        }

    bool kopalnie_praca[K];
    bool elektrownie_praca[E];
    bool elektrownie_kopalnia[E];

    for(int i = 0 ; i < K ; i++)
        kopalnie_praca[i] = false;


    for(int i = 0 ; i < E ; i++)
    {
        elektrownie_praca[i]=false;

        elektrownie_kopalnia[i]=false;
    }

    int iterk = 0,itere = 0;
    int k = 0,e1 = 0,e2 = 0;

    for(int i = 0 ; i < height ; i++)
        for(int j = 0 ; j < width ; j++)
        {
            if(mapa[i][j]=='K')
            {

                if(polaczenie_z(i,j,'O'))
                    kopalnie_praca[iterk] =true;
                else k++;
                clear();

                iterk++;

            }

            if(mapa[i][j]=='E')
            {

                if(polaczenie_z(i,j,'O'))
                    elektrownie_praca[itere] = true;
                else e1++;
                clear();

                if(polaczenie_z(i,j,'K'))
                    elektrownie_kopalnia[itere] = true;
                else e2++;
                clear();

                itere++;
            }



        }

    iterk = 0,itere = 0;
    gtk_init (&argc, &argv);

    GtkWidget *window=gtk_window_new(GTK_WINDOW_TOPLEVEL);
    g_signal_connect(G_OBJECT(window),"destroy",G_CALLBACK(gtk_main_quit),NULL);

    gtk_window_set_title (GTK_WINDOW (window), "MAPA");
    gtk_window_set_position(GTK_WINDOW(window),GTK_WIN_POS_CENTER);
    gtk_container_set_border_width(GTK_CONTAINER(window), 10);

    GdkColor color;

    GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 10);
    gtk_container_add(GTK_CONTAINER(window), box);


    GtkWidget *grid = gtk_grid_new();
    gtk_grid_set_row_spacing(GTK_GRID(grid),5);
    gtk_grid_set_column_spacing(GTK_GRID(grid),5);
    gtk_grid_set_row_homogeneous(GTK_GRID(grid),TRUE);
    gtk_grid_set_column_homogeneous(GTK_GRID(grid),TRUE);
    gtk_box_pack_start(GTK_CONTAINER(box), grid,0,0,0);



    GtkWidget *button;

    for(int i = 0 ; i < height; i++)
        for(int j = 0 ; j < width ; j++)
        {
            char tmp[2];
            tmp[1]='\0';
            tmp[0]=mapa[i][j];

            button = gtk_label_new(&tmp);

            GtkWidget *event = gtk_event_box_new ();
            gtk_container_add (GTK_CONTAINER(event), button);



            if(mapa[i][j]=='K')
            {
                if(kopalnie_praca[iterk])
                {
                    gdk_color_parse("green",&color);
                    gtk_widget_modify_bg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);
                }
                else
                {
                    gdk_color_parse("red",&color);
                    gtk_widget_modify_bg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);
                }

                gdk_color_parse("white",&color);
                gtk_widget_modify_fg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);

                iterk++;
            }
            if(mapa[i][j]=='E')
            {
                if(elektrownie_praca[itere] && elektrownie_kopalnia[itere])
                {
                    gdk_color_parse("green",&color);
                    gtk_widget_modify_bg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);

                }
                else if(elektrownie_kopalnia[itere])
                {
                    gdk_color_parse("orange",&color);
                    gtk_widget_modify_bg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);

                }
                else if(elektrownie_praca[itere])
                {
                    gdk_color_parse("purple",&color);
                    gtk_widget_modify_bg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);

                }
                else
                {
                    gdk_color_parse("red",&color);
                    gtk_widget_modify_bg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);
                }

                gdk_color_parse("white",&color);
                gtk_widget_modify_fg(GTK_WIDGET(event),GTK_STATE_NORMAL,&color);

                itere++;
            }

            gtk_grid_attach(GTK_GRID(grid),event,j,i,1,1);

        }

    gtk_widget_show_all(window);
    gtk_main ();


    return 0;
}

