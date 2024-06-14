package com.issougames.tese;

public class MyInteger implements Comparable<MyInteger>{
    private int value;

    public MyInteger(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Override
    public int compareTo(MyInteger o) {
        return Integer.compare(value, o.value);
    }
}
