package com.dataanalysis.thread;

public class SearchBlog {

	private String search;
	
	public SearchBlog(String search) {
		this.search = search;
	}
	
	public void processSearch() {
		Test t = new Test();
		int searchWidth = 0;
		try {
			searchWidth = t.getSearchWidth(search);
		} catch (Exception e21) {
			// TODO Auto-generated catch block
			e21.printStackTrace();
		}
		
		System.out.println("searchWidth : " + searchWidth);
		
		int s1 = 1; int e1 = searchWidth;
		int s2 = e1; int e2 = e1 * 2 - 1;
		int s3 = e2; int e3 = e1 * 3 - 2;
		int s4 = e3; int e4 = e1 * 4 - 3;
		int s5 = e4; int e5 = e1 * 5 - 4;
		int s6 = e5; int e6 = e1 * 6 - 5;
		int s7 = e6; int e7 = e1 * 7 - 6;
		int s8 = e7; int e8 = e1 * 8 - 7;
		int s9 = e8; int e9 = e1 * 9 - 8;
		int s10 = e9; int e10 = e1 * 10 - 9;
		int s11 = e10; int e11 = e1 * 11 - 10;
		int s12 = e11; int e12 = e1 * 12 - 11;
		int s13 = e12; int e13 = e1 * 13 - 12;
		int s14 = e13; int e14 = e1 * 14 - 13;
		int s15 = e14; int e15 = e1 * 15 - 14;
		int s16 = e15; int e16 = e1 * 16 - 15;
		int s17 = e16; int e17 = e1 * 17 - 16;
		int s18 = e17; int e18 = e1 * 18 - 17;
		int s19 = e18; int e19 = e1 * 19 - 18;
		int s20 = e19; int e20 = e1 * 20 - 19;
		
		
		MyDataA a = new MyDataA(search, s1, e1, "testA");
		MyDataB b = new MyDataB(search, s2, e2, "testB");
		MyDataC c = new MyDataC(search, s3, e3, "testC");
		MyDataD d = new MyDataD(search, s4, e4, "testD");
		MyDataE e = new MyDataE(search, s5, e5, "testE");
		MyData1 md1 = new MyData1(search, s6, e6, "test1");
		MyData2 md2 = new MyData2(search, s7, e7, "test2");
		MyData3 md3 = new MyData3(search, s8, e8, "test3");
		MyData4 md4 = new MyData4(search, s9, e9, "test4");
		MyData5 md5 = new MyData5(search, s10, e10, "test5");
		MyData6 md6 = new MyData6(search, s11, e11, "test6");
		MyData7 md7 = new MyData7(search, s12, e12, "test7");
		MyData8 md8 = new MyData8(search, s13, e13, "test8");
		MyData9 md9 = new MyData9(search, s14, e14, "test9");
		MyData10 md10 = new MyData10(search, s15, e15, "test10");
		MyData11 md11 = new MyData11(search, s16, e16, "test11");
		MyData12 md12 = new MyData12(search, s17, e17, "test12");
		MyData13 md13 = new MyData13(search, s18, e18, "test13");
		MyData14 md14 = new MyData14(search, s19, e19, "test14");
		MyData15 md15 = new MyData15(search, s20, e20, "test15");
		
		Thread thA = new Thread(a);Thread thB = new Thread(b);Thread thC = new Thread(c);
		Thread thD = new Thread(d);Thread thE = new Thread(e);Thread th1 = new Thread(md1);
		Thread th2 = new Thread(md2);Thread th3 = new Thread(md3);Thread th4 = new Thread(md4);
		Thread th5 = new Thread(md5);Thread th6 = new Thread(md6);Thread th7 = new Thread(md7);
		Thread th8 = new Thread(md8);Thread th9 = new Thread(md9);Thread th10 = new Thread(md10);
		Thread th11 = new Thread(md11);Thread th12 = new Thread(md12);Thread th13 = new Thread(md13);
		Thread th14 = new Thread(md14);Thread th15 = new Thread(md15);
		
		thA.start();thB.start();thC.start();thD.start();thE.start();
		th1.start();th2.start();th3.start();th4.start();th5.start();
		th6.start();th7.start();th8.start();th9.start();th10.start();
		th11.start();th12.start();th13.start();th14.start();th15.start();
		
		while(thA.isAlive() || thB.isAlive() || thC.isAlive() || thD.isAlive() || thE.isAlive() ||
				th1.isAlive() || th2.isAlive() || th3.isAlive() || th4.isAlive() || th5.isAlive() ||
				th6.isAlive() || th7.isAlive() || th8.isAlive() || th9.isAlive() || th10.isAlive() ||
				th11.isAlive() || th12.isAlive() || th13.isAlive() || th14.isAlive() || th15.isAlive() ) {
		}
		
		t.mergeFiles();
		
	}

	
}
