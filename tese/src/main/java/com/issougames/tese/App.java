package com.issougames.tese;

import com.gs.collections.impl.list.mutable.FastList;
import it.unimi.dsi.fastutil.objects.ObjectArrayList;

import java.util.ArrayList;

public class App 
{
    public static void main( String[] args )
    {
       SortHelper.sort(new ArrayList<>()); // jcf
       SortHelper.sort(new FastList<>()); // gscollection
       SortHelper.sort(new ObjectArrayList<>()); // fastutil
    }


}
