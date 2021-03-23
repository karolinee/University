public class Home {
    FieldBase[] fields;

    public Home(FieldBase[] f)
    {
        fields = f;
    }

    public boolean anyHome()
    {
        for(int i = 0; i < 4; i++)
        {
            if(fields[i].hasPawn())
            {
                return true;
            }
        }
        return false;
    }

    public boolean allHome()
    {
        for(int i = 0; i < 4; i++)
        {
            if(!fields[i].hasPawn())
            {
                return false;
            }
        }
        return true;
    }
}
