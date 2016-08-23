package com.dataanalysis.thread;

public class MyDataE implements Runnable{

	private String search;
	private int pageNo;
	private int searchWidth;
	private String fileName;
	
	public MyDataE(String search, int pageNo, int searchWidth, String fileName) {

		this.search = search;
		this.pageNo = pageNo;
		this.searchWidth = searchWidth;
		this.fileName = fileName;
	}
	
	Test t = new Test();

	
	@Override
	public void run() {
		try {
			t.search(search, pageNo, searchWidth, fileName);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			System.out.println("MyDataE is ended");
		}
		// TODO Auto-generated method stub
		
		
	}


}
