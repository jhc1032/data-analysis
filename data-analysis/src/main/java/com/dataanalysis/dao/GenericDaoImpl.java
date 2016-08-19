package com.dataanalysis.dao;

import java.util.List;
import javax.inject.Inject;
import org.apache.ibatis.session.SqlSession;

// GenericDAO 인터페이스의 추상클래스들을 오버라이딩 해주어야 한다.
// 즉, 여기서 DB와 연결을 하고 SQL문을 처리해주어야 하므로 sessionTemplate을 인스턴스 변수로 갖고서 
// 이를 통해 CRUD 작업을 처리해주면 된다.
public abstract class GenericDaoImpl<E, K> implements GenericDao<E, K> {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = 
			"org.zerock.mapper.MemberMapper";
	
	@Override
	public K getTime() {
		return sqlSession.selectOne(namespace + ".getNow");
	}

	@Override
	public void register(E member) {
		sqlSession.insert(namespace + ".register", member);
	}

	@Override
	public E get(K email) {
		return sqlSession.selectOne(namespace + ".get", email);
	}

	@Override
	public List<E> getList() {
		return sqlSession.selectList(namespace + ".getList");
	}

}// class
