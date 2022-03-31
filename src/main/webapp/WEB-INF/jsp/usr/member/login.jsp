<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <c:set var="pageTitle" value="로그인" />
    <%@ include file="../common/head.jspf" %>
      <section class="fixed w-full">
        <div class="hero min-h-screen bg-indigo-50">
          <div class="hero-content flex-col lg:flex-row-reverse">
            <div class="text-center lg:text-left">
              <h1 class="text-5xl font-bold text-black">Login now!</h1>
              <p class="py-6 text-black">Cozzy is a site that solves site errors that communicate with developers.
                Please log in.</p>
            </div>
            <div class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
              <div class="card-body bg-gray-900">
                <form class="table-box-type-1" method="post" action="../member/doLogin">
                  <div class="form-control">
                    <label class="label">
                      <span class="label-text text-white">ID</span>
                    </label>

                    <input name="loginId" type="text" placeholder="id" class="input input-bordered">
                  </div>
                  <div class="form-control">
                    <label class="label">
                      <span class="label-text text-white">Password</span>
                    </label>
                    <input name="loginPw" type="password" placeholder="password" class="input input-bordered">
                  </div>
                  <div class="form-control mt-6">
                    <button type="submit" class="btn btn-primary bg-blue-600">Login</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>
      <%@ include file="../common/foot.jspf" %>