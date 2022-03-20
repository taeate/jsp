package com.taeate.example.demo.Repository;

import com.taeate.example.demo.vo.Member;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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

    @Select("""
        select * from member AS M
        where M.loginId = #{loginId}
    """)
    Member getMemberByloginId(@Param("loginId") String loginId);

    @Select("""
        select * from member AS M
        where M.name = #{name}
        AND M.email = #{eamil}
    """)
    Member getMemberByNameandemail(@Param("name") String name, @Param("eamil") String email);

    @Update("""
        <script>
        Update `member`
        <set>
            updateDate = NOW(),
            <if test="loginPw != null ">
                loginPw = #{loginPw},
            </if>
            <if test="name != null ">
                name = #{name},
            </if>
            <if test="nickname != null ">
                nickname = #{nickname},
            </if>
            <if test="email != null ">
                email = #{email},
            </if>
            <if test="cellphoneNo != null ">
                cellphoneNo = #{cellphoneNo},
            </if>
            
        </set>
        where id = #{id}
        </script>
    """)
    void modify(int id, String loginPw, String name, String nickname, String email, String cellphoneNo);

}
