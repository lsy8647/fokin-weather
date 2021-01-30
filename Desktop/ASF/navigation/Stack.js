import React from "react";
import { createStackNavigator } from "@react-navigation/stack";
import Test from './Test';
import { TouchableOpacity, Text } from "react-native";

const Stack = createStackNavigator();

export default () => {
    return (
        <Stack.Navigator
            screenOptions={({ navigation, route }) => ({
                headerStyle:
                {
                    backgroundColor: "white",
                    borderBottomColor: "white",
                    shadowColor: "grey",
                },
                // header 텍스트 색깔 설정
                headerTintColor: "#a0a0a0",
                // 뒤로가기 버튼에 전 스택스크린이름표시여부
                headerBackTitleVisible: false,
                headerTitleAlign: "center",
                headerLeft: () => {
                    return (
                        <TouchableOpacity
                        style={{ marginLeft:10 }}
                            onPress={() => navigation.toggleDrawer()}>
                            <Text>Menu</Text>
                        </TouchableOpacity>
                    )
                }
            })}>
            <Stack.Screen name="Test" component={Test} />
        </Stack.Navigator>
    )
}