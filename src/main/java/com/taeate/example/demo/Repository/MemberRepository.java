package com.taeate.example.demo.Repository;

import com.taeate.example.demo.vo.Member;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface MemberRepository {

    @Insert("""
        insert into member
        set regdate = now(),
        updateDate = now(),
        loginId = #{loginId},
        loginPw = #{loginPw},
        `name` = #{name},
        nickname = #{nickname},
        cellphoneNo = #{cellphoneNo},
        email = #{email}
    """)
    void join(@Param("loginId") String loginId, @Param("loginPw") String loginPw,
             @Param("name") String name, @Param("nickname") String nickname,
            @Param("cellphoneNo") String cellphoneNo, @Param("email") String email);

    @Select("Select last_insert_id()")
    int getLastInsertId();

    @Select("""
        select * from member AS M
        where M.id = #{id}
    """)
    Member getMemberById(@Param("id") int id);

}
