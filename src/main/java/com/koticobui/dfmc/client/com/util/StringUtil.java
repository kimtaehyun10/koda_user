 package com.koticobui.dfmc.client.com.util;
 
 import java.text.DecimalFormat;
 import java.util.ArrayList;
 import java.util.Vector;
 
 public class StringUtil
 {
   private static Runtime runtime = Runtime.getRuntime();
   public static final int CHAR_POSITION_LEFT = 1;
   public static final int CHAR_POSITION_RIGHT = 2;
   public static final int MASK_JUMIN = 1;
   public static final int MASK_ACCOUNT = 2;
   public static final int MASK_CARD = 3;
 
   public static String NVL(Object obj)
   {
     if ((obj != null) && (!"null".equals(obj)) && (!"".equals(obj))) {
       return obj.toString().trim();
     }
     return "";
   }
 
   public static String NVL(Object obj, String value)
   {
     if ((obj != null) && (!"null".equals(obj)) && (!"".equals(obj))) {
       return obj.toString();
     }
     return value;
   }
 
   public static int NVL(Object obj, int value)
   {
     if ((obj != null) && (!"null".equals(obj)) && (!"".equals(obj))) {
       try {
         return Integer.parseInt(obj.toString());
       } catch (NumberFormatException e) {
         return 0;
       }
     }
 
     return value;
   }
 
   public static double NVL(Object obj, double value)
   {
     if ((obj != null) && (!"null".equals(obj)) && (!"".equals(obj))) {
       try {
         return Double.parseDouble(obj.toString());
       } catch (NumberFormatException e) {
         return 0.0D;
       }
     }
 
     return value;
   }
 
   public static boolean isNotEmpty(String str)
   {
     return (str != null) && (!str.equals(""));
   }
 
   public static String replaceZero(Object obj, String value)
   {
     if ((obj != null) && (!"null".equals(obj)) && (!"".equals(obj)) && ("0".equals(obj))) {
       return obj.toString().trim();
     }
     return value;
   }
 
   public static String makeChar(String str, String character, int pos, int point)
   {
     int len = str.getBytes().length;
     if (len >= point) return str;
 
     byte[] bytes = new byte[point];
     if (pos == 2) {
       for (int i = 0; i < bytes.length; i++) {
         if (len > i) bytes[i] = str.getBytes()[i];
         else
           bytes[i] = character.getBytes()[0];
       }
     }
     else if (pos == 1) {
       for (int i = 0; i < bytes.length; i++) {
         if (bytes.length - len > i)
           bytes[i] = character.getBytes()[0];
         else {
           bytes[i] = str.getBytes()[(i - (bytes.length - len))];
         }
       }
     }
     return new String(bytes, 0, bytes.length);
   }
 
   public static String makeChar(int num, String character, int pos, int point)
   {
     return makeChar(String.valueOf(num), character, pos, point);
   }
 
   public static ArrayList byteSubstring(String data, int offset)
   {
     ArrayList al = new ArrayList();
 
     if ((data == null) || (data.equals(""))) return al;
 
     String b = data;
     int totalDataLen = data.getBytes().length;
     int offset2 = offset;
     int strIndex = 0;
     int i = 0;
 
     if (offset == 1) {
       return al;
     }
     do
     {
       String c = "";
 
       if (totalDataLen < offset) {
         c = new String(b.getBytes(), strIndex, totalDataLen);
         offset2 = totalDataLen;
       } else {
         c = new String(b.getBytes(), strIndex, offset);
         offset2 = offset;
       }
 
       offset2 = c.getBytes().length;
 
       if (offset2 == 0) {
         break;
       }
       al.add(new String(c.getBytes(), 0, offset2));
 
       strIndex += offset2;
       totalDataLen -= offset2;
       i++;
     }
     while (totalDataLen != 0);
 
     return al;
   }
 
   public static String byteCut(String data, int bytes)
   {
     if ((data == null) || (data.length() == 0)) return data;
 
     int data_total_length_ = 0;
     StringBuffer buffer = new StringBuffer();
     for (int i = 0; i < data.length(); i++) {
       char c = data.charAt(i);
       data_total_length_ += String.valueOf(c).getBytes().length;
       if (bytes < data_total_length_) break;
       buffer.append(c);
     }
     return buffer.toString();
   }
 
   public static Object[] toArray(String str, String div)
   {
     Vector vector = null;
     int index = -1;
 
     if ((str == null) || (div == null)) return null;
     vector = new Vector();
     while (true) {
       index = str.indexOf(div);
       if (index == -1) break;
       vector.add(str.substring(0, index));
       str = str.substring(index + div.length());
     }
     vector.add(str);
 
     return vector.toArray();
   }
 
   public static String toHalfChar(String origin)
   {
     char[] target = new char[origin.length()];
     for (int i = 0; i < origin.length(); i++) {
       char incode = origin.charAt(i);
       int tmpcod1 = incode & 0xFF00;
       int tmpcod2 = incode & 0xFF;
       int tmpcod3 = incode & 0xFFFF;
       if (tmpcod3 == 12288)
         target[i] = ' ';
       else if (tmpcod1 == 65280)
       {
         target[i] = (char)(tmpcod2 + 32);
       } else target[i] = incode;
     }
     return new String(target);
   }
 
   public static String toFullChar(String src)
   {
     if (src == null) return null;
 
     StringBuffer strBuf = new StringBuffer();
     char c = '\000';
     int nSrcLength = src.length();
     for (int i = 0; i < nSrcLength; i++) {
       c = src.charAt(i);
 
       if ((c >= '!') && (c <= '~'))
         c = (char)(c + 65248);
       else if (c == ' ') {
         c = '　';
       }
 
       strBuf.append(c);
     }
     return strBuf.toString();
   }
 
   public static String toMask(int maskType, String data)
   {
     if ("".equals(NVL(data))) return "";
     String retValue = "";
     if (maskType == 1) {
       retValue = data.substring(0, 6) + "*******";
     } else if (maskType == 2) {
       int index = data.length() - 4;
       retValue = data.substring(0, index) + "****";
     } else if (maskType == 3) {
       retValue = data.substring(0, 6) + "****" + data.substring(10);
     }
     return retValue;
   }
 
   public static String tailer(int offset, String str)
   {
     if (str == null) str = "";
     if (str.length() <= offset) return "";
 
     return str.substring(offset);
   }
 
   public static int parseInt(String no)
   {
     int i = 0;
     if ((no != null) && (!no.trim().equals(""))) {
       i = Integer.parseInt(no);
     }
     return i;
   }
 
   public static long parseLong(String no)
   {
     long l = 0L;
     if ((no != null) && (!no.trim().equals(""))) {
       l = Long.parseLong(no);
     }
     return l;
   }
 
   public static String stringToMoneyFormat(String value, String formatString)
   {
     DecimalFormat format = new DecimalFormat(formatString);
 
     if ((value.split("\\-").length == 1) && (value.split("\\.").length == 1))
       return format.format(Long.parseLong(value));
     if (value.split("\\-").length == 2) {
       if (value.split("\\-")[0].equals("")) {
         return format.format(Long.parseLong(value));
       }
       return value;
     }
 
     return value;
   }
 
   public static String intToMoneyFormat(int value, String formatString)
   {
     DecimalFormat format = new DecimalFormat(formatString);
 
     return format.format(value);
   }
 
   public static String longToMoneyFormat(long value, String formatString)
   {
     DecimalFormat moneyFormat = new DecimalFormat(formatString);
 
     return moneyFormat.format(value);
   }
 
   public static String doubleToMoneyFormat(double value, String formatString)
   {
     DecimalFormat moneyFormat = new DecimalFormat(formatString);
 
     return moneyFormat.format(value);
   }
 
   public static String ko(String str)
   {
     if ((str == null) || ("".equals(str))) return ""; try
     {
       return new String(str.getBytes("8859_1"), "UTF-8"); } catch (Exception e) {
     }
     return "";
   }
 
   public static String replaceTag(String str)
   {
     StringBuffer result = new StringBuffer();
     String[] replace = new String[6];
     replace[0] = "<";
     replace[1] = ">";
     replace[2] = "'";
     replace[3] = "\"";
     replace[4] = "(";
     replace[5] = ")";
     String a = "";
     for (int i = 0; i < str.length(); i++) {
       a = str.substring(i, i + 1);
       for (int j = 0; j < replace.length; j++) {
         if (a.equals(replace[j])) {
           switch (j) { case 0:
             a = "&lt;"; break;
           case 1:
             a = "&gt;"; break;
           case 2:
             a = "&#39;"; break;
           case 3:
             a = "&quot;"; break;
           case 4:
             a = "&#40;"; break;
           case 5:
             a = "&#41;";
           }
         }
       }
       result.append(a);
     }
     str = result.toString();
     return str;
   }
 
   public static String removeHtmlTag(String i_sHTML)
   {
     String result = "";
     if ((i_sHTML == null) || ("".equals(i_sHTML))) {
       return "";
     }
 
     result = i_sHTML.replaceAll("<.+?>", "");
     result = result.replaceAll("\r", "");
     result = result.replaceAll("&nbsp;", " ");
     return result;
   }
 
   public static String removeHtmlTagRegExp(String i_sHTML) {
     String result = "";
     if ((i_sHTML == null) || ("".equals(i_sHTML))) {
       return "";
     }
 
     result = i_sHTML.replaceAll("<([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("</([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
     return result;
   }
 
   public static String removeHtmlTagBr(String i_sHTML) {
     String result = "";
     if ((i_sHTML == null) || ("".equals(i_sHTML))) {
       return "";
     }
 
     result = i_sHTML.replaceAll("<br>", "\n");
     result = result.replaceAll("<br/>", "\n");
     result = result.replaceAll("<br />", "\n");
     result = result.replaceAll("<.+?>", "");
     result = result.replaceAll("\r", "");
     result = result.replaceAll("&nbsp;", " ");
     result = result.replaceAll("\n", "<br />");
 
     return result;
   }
 
   public static boolean isNull(String str)
   {
     return (str == null) || ("".equals(str.trim()));
   }
 
   public static String nbsp2Empty(String str)
   {
     if ("&nbsp;".equals(str.trim())) return "";
     return str;
   }
 
   public static String getByteString(String i_sSource, String i_sLength) {
     return getByteString(i_sSource, Integer.parseInt(i_sLength));
   }
 
   public static String getByteString(String i_sSource, int i_iLength) {
     String result = "";
 
     if ((i_sSource == null) || ("".equals(i_sSource))) {
       return result;
     }
 
     if (i_iLength <= 0) {
       return i_sSource;
     }
 
     try
     {
       int nowLength = 0;
       int strLemgth = 0;
 
       for (int i = 0; i < i_sSource.length(); i++)
       {
         String cTmp = String.valueOf(i_sSource.charAt(i));
 
         byte[] bTmp = cTmp.getBytes("UTF-8");
         strLemgth = bTmp.length;
 
         if (strLemgth == 3)
           nowLength += 2;
         else {
           nowLength += strLemgth;
         }
         if (nowLength > i_iLength)
           break;
         result = result + cTmp;
       }
 
       if (i_sSource.length() > result.length())
         result = result + "...";
     }
     catch (Exception e) {
       result = i_sSource;
     }
 
     return result;
   }
 
   public static String lpad(String str, String addStr, int len) {
     String result = str;
     for (int i = 0; (str != null) && (addStr != null) && (str.length() < len) && ((str + addStr).length() <= len) && (result.length() < len) && (i < len); i++) {
       result = addStr + str;
     }
     return result;
   }
 }
