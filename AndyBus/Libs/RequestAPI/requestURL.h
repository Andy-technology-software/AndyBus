//
//  requestURL.h
//  WhereAreYou
//
//  Created by lingnet on 2017/7/5.
//  Copyright © 2017年 徐仁强. All rights reserved.
//

#ifndef requestURL_h
#define requestURL_h

#define HEADER @"http://118.190.93.43:8082/oa/"

//登陆
#define LOGINURL HEADER"login!login.action"

//上传坐标
#define positionUpload HEADER"location!positionUpload.action"

//获取轨迹
#define getTrail HEADER"location!getTrail.action"

//通讯录
#define getStaff HEADER"communication!getStaff.action"

//员工列表
#define getSubordinate HEADER"person!getSubordinate.action"

//签到
#define signin HEADER"attendance!signin.action"

//签到信息
#define getSigninInfo HEADER"attendance!getSigninInfo.action"

//通知信息
#define Notice HEADER"dynamic!notice.action"

//个人信息
#define PersonInfo HEADER"person!personalInfo.action"

//设置定位开启关闭
#define SetLocate HEADER"person!setLocationState.action"

//修改密码
#define ChangePW HEADER"person!modifyPassword.action"

//用户反馈
#define FeedBack HEADER"common!feedback.action"


//http://101.200.145.66:2001/BusService/Query_NearbyStatInfo/
//获取附近公交站站点信息
#define Query_NearbyStatInfo @"http://101.200.145.66:2001/BusService/Query_NearbyStatInfo/?"















#endif /* requestURL_h */
