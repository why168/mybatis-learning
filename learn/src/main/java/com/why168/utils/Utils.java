package com.why168.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Utils {

    public static String shell(String command) {
        Process process = null;
        InputStreamReader ips = null;
        BufferedReader br = null;
        StringBuilder sb = new StringBuilder();
        String[] cmd = new String[]{"/bin/sh", "-c", command};
        try {
            //执行命令
            process = Runtime.getRuntime().exec(cmd);
            ips = new InputStreamReader(process.getInputStream());
            br = new BufferedReader(ips);
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (process != null) {
                process.destroy();
            }
            if (ips != null) {
                try {
                    ips.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return sb.toString();
    }
}
