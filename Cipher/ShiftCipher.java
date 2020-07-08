class ShiftCipher {
    public static void main(String[] args) {
        String c = "EAYQDMZPAYFQJF";
        // use k = 0 if you want to test every rotation
        int k = 0;

        if (k != 0) {
            printDecipheredText(k, c);
        } else {
            for (k = 0; k < 26; k++) {
                printDecipheredText(k, c);
            }
        }
    }

    static void printDecipheredText(int k, String c) {
        char[] cArr = c.toCharArray();

        System.out.print("k = " + (26 - k) + ": ");
        for (char ch : cArr) {
            System.out.print((char)((((ch - 'A') + k) % 26) + 'A'));
        }
        System.out.println("");
    }
}
