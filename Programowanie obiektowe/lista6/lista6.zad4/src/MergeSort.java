public class MergeSort extends Thread {

    int[] arr;

    public MergeSort(int[] a)
    {
        arr = a;
    }
    public void run()
    {
        sort();
    }
    void sort()
    {

        if(arr.length > 1)
        {
            int m = arr.length / 2;

            int[] first = new int[m];
            int[] second = new int[arr.length - m];

            for (int i = 0; i < first.length; i++)
                first[i] = arr[i];
            for (int i = 0; i < second.length; i++)
                second[i] = arr[first.length + i];

            MergeSort firstSorter = new MergeSort(first);
            MergeSort secondSorter = new MergeSort(second);
            firstSorter.start();
            secondSorter.start();

            try
            {
                firstSorter.join();
                secondSorter.join();

                merge(first,second);
            }
            catch(Exception e){
                e.printStackTrace();
            }
        }
    }
    void merge(int[] first, int[] second)
    {
        int iFirst = 0;
        int iSecond = 0;
        int j = 0;

        while (iFirst < first.length && iSecond < second.length)
        {
            if (first[iFirst] < second[iSecond])
                arr[j++] = first[iFirst++];

            else
                arr[j++] = second[iSecond++];
        }


        while (iFirst < first.length)
            arr[j++] = first[iFirst++];

        while (iSecond < second.length)
            arr[j++] = second[iSecond++];


    }


    public static void main(String[] args)
    {
        int[]arr={2,5,1,8,9};
        MergeSort mr = new MergeSort(arr);
        mr.run();

        for(int i=0;i< 5;i++)
            System.out.println(arr[i]);
    }

}
