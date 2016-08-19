package com.dataanalysis.mapper;

import java.util.HashMap;
import java.util.List;

import com.dataanalysis.dto.Member;

public interface MemberMapper {
	
	void insertMember(Member member);
	public List<Member> selectAllMembers();
	Member selectMemberById(String email);
	Member selectMemberByIdAndPw(HashMap<String, Object> params);
	void updateMember(Member member);
	void deleteMember(String email);	
}
