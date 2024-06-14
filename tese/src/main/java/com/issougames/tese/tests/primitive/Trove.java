package com.issougames.tese.tests.primitive;

import com.issougames.tese.SortHelper;
import gnu.trove.list.array.TIntArrayList;

import java.util.Random;

public class Trove {
    public static void main( String[] args )
    {
        Random random = new Random();
        TIntArrayList arr = new TIntArrayList(SortHelper.SIZE);

        for (int i = 0; i < SortHelper.SIZE; i++) {
            arr.add(random.nextInt());
        }

        arr.sort();
    }
}
