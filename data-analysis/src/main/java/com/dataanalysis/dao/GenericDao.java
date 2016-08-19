package com.dataanalysis.dao;

import java.util.List;

public interface GenericDao<E, K> {

	public K getTime();
	public void register(E member);
	public E get(K email);
	public List<E> getList();
	//public void update();
	//public void delete();
	
}// interface