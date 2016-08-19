package com.dataanalysis.dao;

import org.springframework.stereotype.Repository;
import com.dataanalysis.dto.Member;

@Repository
public class MemberDaoImpl extends GenericDaoImpl<Member, String> implements MemberDao {

}
