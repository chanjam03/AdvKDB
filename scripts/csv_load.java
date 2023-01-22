import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import kx.c;

public class CSVtoTickerplant {
    public static void main(String[] args) {
        // Connect to kdb ticker plant
        c conn = new c("localhost", 5001);
        
        try (BufferedReader br = new BufferedReader(new FileReader("data.csv"))) {
            String line;
            while ((line = br.readLine()) != null) {
                // split line into fields
                String[] fields = line.split(",");
                // Insert data into kdb ticker plant
                conn.ks("insert", "tablename", fields);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}