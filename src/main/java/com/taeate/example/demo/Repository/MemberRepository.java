package com.taeate.example.demo.Repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

}
