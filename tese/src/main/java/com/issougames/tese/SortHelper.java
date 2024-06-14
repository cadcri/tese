package com.issougames.tese;

import java.util.Collections;
import java.util.List;
import java.util.Random;

public class SortHelper {

    public static final int SIZE = 1000000;

    public static void sort(List<MyInteger> list)
    {
        MyInteger[] arr = new MyInteger[SIZE];

        Random random = new Random();

        for (int i = 0; i < arr.length; i++) {
            arr[i] = new MyInteger(random.nextInt());
        }

        Collections.addAll(list, arr);

        Collections.sort(list);
    }


}
