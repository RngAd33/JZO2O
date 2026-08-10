package com.jzo2o.customer.utils;

import cn.hutool.jwt.JWT;
import com.jzo2o.customer.model.domain.CurrentUser;

import java.nio.charset.StandardCharsets;
import java.util.Date;

public class TokenHelper {

    private static final long TOKEN_TTL = 30 * 60 * 1000L;

    private static final String CLAIM_APP_ID = "appId";
    private static final String CLAIM_ACCESS_KEY_ID = "accessKeyId";
    private static final String CLAIM_USER = "user";
    private static final String CLAIM_ROLE = "role";

    private static final String ROLE_ADMIN = "admin";
    private static final String ROLE_USER = "user";

    /**
     * 生成运营端(管理员)token
     */
    public static String generateTokenOfAdmin(String appId, String accessKeyId, String accessKeySecret, CurrentUser currentUser) {
        return generateToken(appId, accessKeyId, accessKeySecret, currentUser, ROLE_ADMIN);
    }

    /**
     * 生成C端(普通用户)token
     */
    public static String generateTokenOfUser(String appId, String accessKeyId, String accessKeySecret, CurrentUser currentUser) {
        return generateToken(appId, accessKeyId, accessKeySecret, currentUser, ROLE_USER);
    }

    private static String generateToken(String appId, String accessKeyId, String accessKeySecret, CurrentUser currentUser, String role) {
        return JWT.create()
                .setPayload(CLAIM_APP_ID, appId)
                .setPayload(CLAIM_ACCESS_KEY_ID, accessKeyId)
                .setPayload(CLAIM_USER, currentUser)
                .setPayload(CLAIM_ROLE, role)
                .setIssuedAt(new Date())
                .setExpiresAt(new Date(System.currentTimeMillis() + TOKEN_TTL))
                .setKey(accessKeySecret.getBytes(StandardCharsets.UTF_8))
                .sign();
    }

}