import com.kx.c;
import java.io.BufferedReader;
import java.io.FileReader;

public class csvLoad {

    public static void main(String[] args) {

        int port = Integer.parseInt(args[0]);
        String file = args[1];
        String table = args[2];

        c c = null;

        try {

            c = new c("localhost",port);

            Object query = c.k("`$ exec t from meta " + table);
            String queryString = (query.toString());
            char[] types = queryString.toCharArray();

            try {

                FileReader fp = new FileReader(file);
                BufferedReader reader = new BufferedReader(fp);
                reader.readLine();

                String delimiter = ",";
                String line;

                while ((line = reader.readLine()) != null) {

                    String row[] = line.split(delimiter);

                    for (int n = 0; n < row.length; n++) {
                        switch (types[n]) {
                            case 'i':
                                row[n] = row[n] + "i";
                                break;
                            case 'f':
                                row[n] = row[n] + "f";
                                break;
                            case 'd':
                                row[n] = row[n].replace("-",".");
                                break;
                            case 'n':
                                row[n] = "0D" + row[n].split("D")[1];
                                break;
                            case 's':
                                row[n] = "`" + row[n];
                                break;
                        }
                    }

                    String msg = ".u.upd[`" + table + ";(enlist " + String.join(";enlist ",row) + ")]";
                    c.k(msg);

                }

            } catch (Exception e) {
                System.out.println("Error: " + e);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

    }

}

