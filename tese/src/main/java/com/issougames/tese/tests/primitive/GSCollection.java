package com.issougames.tese.tests.primitive;

import com.gs.collections.impl.list.mutable.primitive.IntArrayList;
import com.issougames.tese.SortHelper;

import java.util.Random;

public class GSCollection{
    public static void main( String[] args )
    {
        Random random = new Random();
        IntArrayList list = new IntArrayList(SortHelper.SIZE);

        for (int i = 0; i < SortHelper.SIZE; i++) {
            list.add(random.nextInt());
        }

        list.sortThis();
    }
}
