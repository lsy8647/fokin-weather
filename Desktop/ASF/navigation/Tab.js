import React from "react";
import { Platform } from "react-native";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import Main from "../views/bottom/Main";
import Recycle from "../views/bottom/Recycle";
import Parking from "../views/bottom/Parking";
import Safety from "../views/bottom/Safety";
import Notice from "../views/bottom/Notice";
import { Ionicons } from "@expo/vector-icons";
import Color from "../constants/Colors";


const Tab = createBottomTabNavigator();

export default ({ route }) => {

  // 바텀 네비게이션
  return (
    <Tab.Navigator
      initialRouteName={"홈"}
      lazy={true}
      resetOnBlur={true}
      detachInactiveScreens={true}
      screenOptions={({ route }) => ({
        tabBarVisible: 'false',
        tabBarIcon: ({ focused }) => {
          let iconName = Platform.OS === "ios" ? "ios-" : "md-";
          if (route.name === "홈") {
            iconName += "business";
          } else if (route.name === "쓰레기") {
            iconName += "trash";

          } else if (route.name === "주차장") {
            iconName += "car";
          } else if (route.name === "안전알림") {
            iconName += "warning";
          } else if (route.name === "공지사항") {
            iconName += "text";
          }
          return (
            <Ionicons
              name={iconName}
              color={focused ? Color.main : "grey"} //아이콘 색상 변경 
              size={30}
            />
          );

        },
      })}

      tabBarOptions={{
        activeTintColor: Color.main, //탭의 text color변경 
        labelStyle: {
          fontWeight: 'bold',// text 의 굵기 지정
          fontSize: 10 //text 사이즈 
        },
        style: {
          backgroundColor: "white",
          height: 60,
          padding: 5,
          paddingBottom: 5,

        },
      }}
    >
      <Tab.Screen name="홈" component={Main} />
      <Tab.Screen name="쓰레기" component={Recycle} />
      <Tab.Screen name="주차장" component={Parking} />
      <Tab.Screen name="안전알림" component={Safety} />
      <Tab.Screen name="공지사항" component={Notice} />
    </Tab.Navigator>

  );
};
