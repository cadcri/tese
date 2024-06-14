package com.issougames.tese.tests.primitive;

import com.issougames.tese.SortHelper;
import it.unimi.dsi.fastutil.ints.IntArrayList;

import java.util.Collections;
import java.util.Random;

public class FastUtil {
    public static void main( String[] args )
    {
        Random random = new Random();
        IntArrayList list = new IntArrayList(SortHelper.SIZE);

        for (int i = 0; i < SortHelper.SIZE; i++) {
            list.add(random.nextInt());
        }

        Collections.sort(list);
    }
}
