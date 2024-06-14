package com.issougames.tese.tests.primitive;

import com.issougames.tese.SortHelper;

import java.util.Arrays;
import java.util.Random;

public class JCF {
    public static void main( String[] args )
    {
        Random random = new Random();
        int[] arr = new int[SortHelper.SIZE];

        for (int i = 0; i < SortHelper.SIZE; i++) {
            arr[i] = (random.nextInt());
        }

        Arrays.sort(arr);
    }
}
