/*     */ package com.koticobui.dfmc.client.com.util;
/*     */ 
/*     */ import java.io.IOException;
/*     */ import java.io.PrintStream;
/*     */ import java.io.PrintWriter;
/*     */ import java.security.MessageDigest;
/*     */ import java.util.Enumeration;
/*     */ import java.util.HashMap;
/*     */ import java.util.Iterator;
/*     */ import java.util.List;
/*     */ import java.util.Set;
/*     */ import java.util.Vector;
/*     */ import javax.servlet.http.HttpServletRequest;
/*     */ import javax.servlet.http.HttpServletResponse;
/*     */ 
/*     */ public class CommonUtil
/*     */ {
/*     */   public static boolean Check_img(String exten)
/*     */   {
/*  24 */     return exten.matches("(?i)GIF|(?i)BMP|(?i)RLE|(?i)JPG|(?i)PSD|(?i)PDD|(?i)TIF|(?i)PDF|(?i)RAW|(?i)EPS|(?i)SVG|(?i)IFF|(?i)FPX|(?i)FRM|(?i)PCX|(?i)TGA|(?i)PNG");
/*     */   }
/*     */ 
/*     */   public static String Cut_Str(String str, int num)
/*     */   {
/*  31 */     if (str.length() > num) {
/*  32 */       str = str.substring(0, num);
/*  33 */       str = str.concat("..");
/*     */     }
/*  35 */     return str;
/*     */   }
/*     */ 
/*     */   public static String nl2br(String str) {
/*  39 */     str = str.replaceAll("\r\n", "<br>");
/*  40 */     str = str.replaceAll("\r", "<br>");
/*  41 */     str = str.replaceAll("\n", "<br>");
/*  42 */     return str;
/*     */   }
/*     */ 
/*     */   public static String Req(String str1, String str, String level) throws Exception
/*     */   {
/*  47 */     String returnStr = str1;
/*     */ 
/*  49 */     String[] _etcValue = { "SELECT", "INSERT", "UPDATE", "DELETE", "UNION", "/*", "*/", "--" };
/*  50 */     String tempStr = "";
/*     */ 
/*  52 */     int strCount = 0;
/*     */     try
/*     */     {
/*  56 */       if ((str1 == null) || (str1.equals("")) || (str1.equals("null")))
/*     */       {
/*  58 */         returnStr = str;
/*     */       }
/*     */       else
/*     */       {
/*  63 */         for (int i = 0; i < _etcValue.length; i++)
/*     */         {
/*  65 */           if (returnStr.toUpperCase().indexOf(_etcValue[i]) > -1) {
/*  66 */             strCount = returnStr.toUpperCase().indexOf(_etcValue[i]);
/*  67 */             tempStr = returnStr.substring(strCount, strCount + _etcValue[i].length());
/*  68 */             returnStr = returnStr.replaceAll(tempStr, "");
/*     */           }
/*     */         }
/*     */       }
/*     */ 
/*  73 */       if (level.equals("XSS")) {
/*  74 */         returnStr = xss(returnStr);
/*  75 */         returnStr = returnStr.replaceAll("<", "&lt;");
/*  76 */         returnStr = returnStr.replaceAll(">", "&gt;");
/*  77 */         returnStr = returnStr.replaceAll("\"", "&quot;");
/*     */       }
/*     */ 
/*  80 */       if (level.equals("TEXT")) {
/*  81 */         returnStr = xss(returnStr);
/*     */       }
/*     */ 
/*  84 */       returnStr.replaceAll("'", "&#39");
/*     */     }
/*     */     catch (Exception e1) {
/*  87 */       System.out.println(e1.toString());
/*     */     }
/*     */ 
/*  90 */     return returnStr;
/*     */   }
/*     */ 
/*     */   public static String xss(String str) {
/*  94 */     if (str == null) {
/*  95 */       return null;
/*     */     }
/*  97 */     String[] FILTER = { "<iframe", "<script" };
/*  98 */     String[] FILTER_CHANGE = { "&lt;iframe", "&lt;script" };
/*     */ 
/* 100 */     if (FILTER != null) {
/* 101 */       for (int i = 0; i < FILTER.length; i++) {
/* 102 */         str = StringUtil.replaceIgnoreCase(str, FILTER[i], FILTER_CHANGE[i]);
/*     */       }
/*     */     }
/* 105 */     str = StringUtil.replaceIgnoreCase(str, "eval\\((.*)\\)", "");
/* 106 */     str = StringUtil.replaceIgnoreCase(str, "[\\\"\\'][\\s]*javascript:(.*)[\\\"\\']", "\"\"");
/* 107 */     str = StringUtil.replaceIgnoreCase(str, "[\\\"\\'][\\s]*vbscript:(.*)[\\\"\\']", "\"\"");
/* 108 */     str = StringUtil.replaceIgnoreCase(str, "document.cookie", "no_document.cookie");
/* 109 */     str = StringUtil.replaceIgnoreCase(str, "<script", "&lt;script");
/*     */ 
/* 111 */     return str;
/*     */   }
/*     */ 
/*     */   public static String[] getExecFormName() {
/* 115 */     String[] exArr = { 
/* 116 */       "smsContent", "bod_content", "bod_way_content", "txtLecture1", "txtLecture2", 
/* 117 */       "txtLecture3", "txtCulture1", "txtCulture2", "txtCulture3", "txtMap", 
/* 118 */       "strAContents", "strContents", "txtIntroduce" };
/*     */ 
/* 121 */     return exArr;
/*     */   }
/*     */ 
/*     */   public static HashMap setReqMap(HttpServletRequest p_req) throws Exception
/*     */   {
/* 126 */     HashMap map = new HashMap();
/*     */ 
/* 128 */     Enumeration enumer = p_req.getParameterNames();
/*     */ 
/* 130 */     while (enumer.hasMoreElements())
/*     */     {
/* 132 */       String key = (String)enumer.nextElement();
/*     */ 
/* 134 */       String[] value = p_req.getParameterValues(key);
/*     */ 
/* 136 */       if (value.length == 1)
/*     */       {
/* 139 */         String filterLevel = "XSS";
/* 140 */         String[] arrExep = getExecFormName();
/* 141 */         for (int i = 0; i < arrExep.length; i++) {
/* 142 */           if (arrExep[i].equals(key)) {
/* 143 */             filterLevel = "TEXT";
/*     */           }
/*     */         }
/* 146 */         map.put(key, Req(p_req.getParameter(key), "", filterLevel));
/*     */       }
/* 148 */       else if (value.length > 1) {
/* 149 */         Vector v = new Vector();
/*     */ 
/* 151 */         for (int i = 0; i < value.length; i++) {
/* 152 */           v.add(v.size(), value[i]);
/*     */         }
/*     */ 
/* 155 */         String vStr = String.valueOf(v);
/*     */ 
/* 158 */         String filterLevel = "XSS";
/* 159 */         String[] arrExep = getExecFormName();
/* 160 */         for (int i = 0; i < arrExep.length; i++) {
/* 161 */           if (arrExep[i].equals(key)) {
/* 162 */             filterLevel = "TEXT";
/*     */           }
/*     */         }
/*     */ 
/* 166 */         map.put(key, Req(vStr, "", filterLevel));
/*     */       }
/*     */     }
/*     */ 
/* 170 */     return map;
/*     */   }
/*     */ 
/*     */   public static void alertMove(HttpServletResponse response, String msg, String url)
/*     */     throws IOException
/*     */   {
/* 176 */     PrintWriter out = response.getWriter();
/* 177 */     String returnMsg = "<script>";
/*     */     try
/*     */     {
/* 180 */       if (!"".equals(msg)) {
/* 181 */         returnMsg = returnMsg + "alert('" + msg + "');";
/*     */       }
/*     */ 
/* 184 */       if ("back".equals(url)) {
/* 185 */         returnMsg = returnMsg + "history.go(-1);";
/*     */       }
/* 187 */       else if ("close".equals(url)) {
/* 188 */         returnMsg = returnMsg + "self.close();";
/*     */       }
/* 190 */       else if ("close_reload".equals(url)) {
/* 191 */         returnMsg = returnMsg + "opener.location.reload();";
/* 192 */         returnMsg = returnMsg + "self.close();";
/*     */       }
/* 194 */       else if ("iframe".equals(url)) {
/* 195 */         returnMsg = returnMsg + "parent.location.reload();";
/*     */       }
/* 197 */       else if (!"".equals(url)) {
/* 198 */         returnMsg = returnMsg + "location.href='" + url + "';";
/*     */       }
/*     */ 
/* 201 */       returnMsg = returnMsg + "</script>";
/* 202 */       out.print(returnMsg);
/*     */     }
/*     */     catch (Exception e) {
/* 205 */       System.out.println(e.toString());
/*     */     }
/*     */   }
/*     */ 
/*     */   public static void alertCloseMove(HttpServletResponse response, String msg, String url, String value) throws IOException
/*     */   {
/* 211 */     PrintWriter out = response.getWriter();
/* 212 */     String returnMsg = "<script>";
/*     */     try
/*     */     {
/* 215 */       if (!"".equals(msg)) {
/* 216 */         returnMsg = returnMsg + "alert('" + msg + "');";
/*     */       }
/* 218 */       if ("close_reload_href".equals(value)) {
/* 219 */         returnMsg = returnMsg + "opener.location.href='" + url + "';";
/* 220 */         returnMsg = returnMsg + "self.close();";
/*     */       }
/*     */ 
/* 223 */       returnMsg = returnMsg + "</script>";
/* 224 */       out.print(returnMsg);
/*     */     }
/*     */     catch (Exception e) {
/* 227 */       System.out.println(e.toString());
/*     */     }
/*     */   }
/*     */ 
/*     */   public static void returnStr(HttpServletResponse response, String str) throws IOException
/*     */   {
/* 233 */     PrintWriter out = response.getWriter();
/* 234 */     String returnMsg = "";
/*     */     try {
/* 236 */       if (!"".equals(str)) {
/* 237 */         returnMsg = returnMsg + str;
/*     */       }
/* 239 */       out.print(returnMsg);
/*     */     }
/*     */     catch (Exception e) {
/* 242 */       System.out.println(e.toString());
/*     */     }
/*     */   }
/*     */ 
/*     */   public static String getViewYn(String str) {
/* 247 */     if (str.equals("Y")) return "����";
/* 248 */     return "�����";
/*     */   }
/*     */ 
/*     */   public static String getAdminListOption() {
/* 252 */     String rtnStr = "";
/* 253 */     rtnStr = rtnStr + "<option value='10'>10�پ�����</option>\n";
/* 254 */     rtnStr = rtnStr + "<option value='20'>20�پ�����</option>\n";
/* 255 */     rtnStr = rtnStr + "<option value='50'>50�پ�����</option>\n";
/* 256 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String getFileHrefLink(String path, String usrName, String appendStr_h, String appendStr_f) {
/* 260 */     String rtnStr = "";
/* 261 */     if ((path == null) || (path.equals("")) || (path.equals("null"))) return rtnStr;
/* 262 */     if ((usrName == null) || (usrName.equals("")) || (usrName.equals("null"))) return rtnStr;
/* 263 */     if (!appendStr_h.equals("")) rtnStr = rtnStr + appendStr_h;
/* 264 */     rtnStr = rtnStr + "<a href='../include/file_download.jsp?path=" + path + "&file=" + usrName + "' target='_blank'>" + usrName + "</a>\n";
/* 265 */     rtnStr = rtnStr + "<input type='hidden' name='oldFileName' value='" + usrName + "'>\n";
/* 266 */     if (!appendStr_f.equals("")) rtnStr = rtnStr + appendStr_f;
/*     */ 
/* 268 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String getFileHrefLink(String path, String srvName, String usrName, String appendStr_h, String appendStr_f) {
/* 272 */     String rtnStr = "";
/* 273 */     if ((path == null) || (path.equals("")) || (path.equals("null"))) return rtnStr;
/* 274 */     if ((srvName == null) || (srvName.equals("")) || (srvName.equals("null"))) return rtnStr;
/* 275 */     if (!appendStr_h.equals("")) rtnStr = rtnStr + appendStr_h;
/* 276 */     rtnStr = rtnStr + "<a href='" + path + srvName + "' target='_blank'>" + usrName + "</a>\n";
/* 277 */     rtnStr = rtnStr + "<input type='hidden' name='oldFileName' value='" + srvName + "'>\n";
/* 278 */     if (!appendStr_f.equals("")) rtnStr = rtnStr + appendStr_f;
/* 279 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String getFileHrefLink(String path, String srvName, String usrName, String appendStr_h, String appendStr_f, String fileNumber) {
/* 283 */     String rtnStr = "";
/* 284 */     if ((path == null) || (path.equals("")) || (path.equals("null"))) return rtnStr;
/* 285 */     if (!appendStr_h.equals("")) rtnStr = rtnStr + appendStr_h;
/* 286 */     rtnStr = rtnStr + "<a href='" + path + srvName + "' target='_blank'>" + usrName + "</a>\n";
/* 287 */     rtnStr = rtnStr + "<input type='hidden' name='oldFileName_" + fileNumber + "' value='" + srvName + "'>\n";
/* 288 */     if (!appendStr_f.equals("")) rtnStr = rtnStr + appendStr_f;
/* 289 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String makeOptionStr(HashMap hm, String formType, String formName, String addStr) {
/* 293 */     String rtnStr = "";
/* 294 */     if (formType.equals("option")) {
/* 295 */       for (Iterator it = hm.keySet().iterator(); it.hasNext(); ) {
/* 296 */         String key = (String)it.next();
/* 297 */         String value = (String)hm.get(key);
/* 298 */         rtnStr = rtnStr + "<option value='" + key + "'>" + value + "</option>\n";
/*     */       }
/*     */     }
/* 301 */     if (formType.equals("equaloption")) {
/* 302 */       for (Iterator it = hm.keySet().iterator(); it.hasNext(); ) {
/* 303 */         String key = (String)it.next();
/* 304 */         String value = (String)hm.get(key);
/* 305 */         rtnStr = rtnStr + "<option value='" + key + "/" + value + "'>" + value + "</option>\n";
/*     */       }
/*     */     }
/* 308 */     if (formType.equals("radio")) {
/* 309 */       for (Iterator it = hm.keySet().iterator(); it.hasNext(); ) {
/* 310 */         String key = (String)it.next();
/* 311 */         String value = (String)hm.get(key);
/* 312 */         rtnStr = rtnStr + "<input type='radio' id='" + formName + "' name='" + formName + "' value='" + key + "' " + addStr + ">" + value + "&nbsp;";
/*     */       }
/*     */     }
/* 315 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String makeOptionStr(List list, String formType, String formName, String addStr) {
/* 319 */     String rtnStr = "";
/* 320 */     HashMap hm = new HashMap();
/* 321 */     if (formType.equals("option")) {
/* 322 */       for (int i = 0; i < list.size(); i++) {
/* 323 */         hm = (HashMap)list.get(i);
/* 324 */         String key = String.valueOf(hm.get("p_key"));
/* 325 */         String value = String.valueOf(hm.get("p_value"));
/* 326 */         rtnStr = rtnStr + "<option value='" + key + "'>" + value + "</option>\n";
/*     */       }
/*     */     }
/* 329 */     if (formType.equals("radio")) {
/* 330 */       for (int i = 0; i < list.size(); i++) {
/* 331 */         hm = (HashMap)list.get(i);
/* 332 */         String key = String.valueOf(hm.get("p_key"));
/* 333 */         String value = String.valueOf(hm.get("p_value"));
/* 334 */         rtnStr = rtnStr + "<input type='radio' id='" + formName + "' name='" + formName + "' value='" + key + "' " + addStr + ">" + value + "&nbsp;";
/*     */       }
/*     */     }
/* 337 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String getOptionValue(HashMap hm, String keyVal) {
/* 341 */     String rtnStr = "";
/* 342 */     for (Iterator it = hm.keySet().iterator(); it.hasNext(); ) {
/* 343 */       String key = (String)it.next();
/* 344 */       String value = (String)hm.get(key);
/* 345 */       if (!key.equals(keyVal)) continue; rtnStr = value;
/*     */     }
/* 347 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String getListSingleValue(List lt)
/*     */   {
/* 352 */     String rtnStr = "";
/* 353 */     HashMap tHm = new HashMap();
/* 354 */     List getListT = lt;
/* 355 */     tHm = (HashMap)getListT.get(0);
/* 356 */     rtnStr = String.valueOf(tHm.get("nVal"));
/*     */ 
/* 358 */     return rtnStr;
/*     */   }
/*     */ 
/*     */   public static String encryptToSHA1(String str)
/*     */   {
/* 371 */     String result = "";
/* 372 */     MessageDigest md = null;
/*     */     try
/*     */     {
/* 375 */       md = MessageDigest.getInstance("SHA-1");
/* 376 */       result = "";
/*     */ 
/* 378 */       md.update(str.getBytes());
/* 379 */       byte[] mdbyteArr = md.digest();
/*     */ 
/* 381 */       for (int i = 0; i < mdbyteArr.length; i++) {
/* 382 */         result = result + Integer.toString((mdbyteArr[i] & 0xF0) >> 4, 16);
/* 383 */         result = result + Integer.toString(mdbyteArr[i] & 0xF, 16);
/*     */       }
/*     */     } catch (Exception e) {
/* 386 */       System.out.println("Error");
/*     */     }
/* 388 */     return result;
/*     */   }
/*     */ }

/* Location:           D:\work\koda\ASIS\Koda_원본\WebContent\WEB-INF\classes\
 * Qualified Name:     com.withsystem.common.util.CommonUtil
 * JD-Core Version:    0.6.0
 */