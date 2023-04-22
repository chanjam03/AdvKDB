import com.kx.c;
import java.sql.*;
import java.io.BufferedReader;
import java.io.FileReader;

import java.nio.file.Files;
import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {

        // Parsing arguments passed from command line
        int port = Integer.parseInt(args[0]);
        String file = args[1];
        String table = args[2];

        c c = null;

        try {

            // Connecting to tickerplant
            c = new c("localhost",port);

            // Getting schema types from tickerplant
            Object query = c.k("`$ exec t from meta " + table);
            String queryString = (query.toString());
            String ret = queryString.substring(0, queryString.length() - 1);
            char[] types = ret.toCharArray();

            try {
                // Creating reader instance from filepath provided
                FileReader fp = new FileReader(file);
                BufferedReader reader = new BufferedReader(fp);
                reader.readLine();

                // Creating loop to parse through rows of csv file reader
                String delimiter = ",";
                String line;

                while ((line = reader.readLine()) != null) {

                    // Splitting values and defining new empty array of final values
                    String row[] = line.split(delimiter);
                    Object updRow[] = new Object[row.length];

                    // Parsing through row values and updating to kdb compatible
                    for (int n = 0; n < row.length; n++) {
                        switch (types[n]) {
                            case 'i':
                                updRow[n] = new int[] {Integer.parseInt(row[n])};
                                break;
                            case 'f':
                                updRow[n] = new double[] {Double.parseDouble(row[n])};
                                break;
                            case 'd':
                                updRow[n] = new Date[] {Date.valueOf(row[n])};
                                break;
                            case 'p':
                                updRow[n] = new Timestamp[] {Timestamp.valueOf(row[n].replace("D", " "))};
                                break;
                            default:
                                updRow[n] = new String[] {row[n]};
                        }
                    }

                    c.ks(".u.upd", "optTrades",updRow);

                }

            } catch (Exception e) {
                System.out.println("Error: " + e);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

    }

}

