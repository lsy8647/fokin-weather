import React, { useState } from "react";
import { Alert, View, Text } from 'react-native';
import { createDrawerNavigator, DrawerContentScrollView, DrawerItemList, DrawerItem } from "@react-navigation/drawer";
import Stack from "./Stack";

const Drawer = createDrawerNavigator();

function CustomDrawerContent(props) {
    return (
      <DrawerContentScrollView {...props}>
        <DrawerItemList {...props}
          activeBackgroundColor={'transparent'} />
  
        {/* Header */}
        <View style={{ borderColor: '#A8A8A8', borderBottomWidth: 1, padding: '5%', alignItems: 'stretch', justifyContent: 'center' }}>
          <View style={{ flexDirection: 'row', alignItems: 'center' }}>
            <Text style={{ marginLeft: '10%', color: "#3f3f3f", fontWeight: 'bold' }}>Test</Text>
          </View>
        </View>
  
        <DrawerItem
          label="Item1"
          labelStyle={{ color: '#6a6a6a', fontWeight: 'bold' }}
          onPress={() => {
            
          }}
        />
  
        <DrawerItem
          label="Item2"
          labelStyle={{ color: '#6a6a6a', fontWeight: 'bold' }}
          onPress={() => {
            
          }}
        />
  
      </DrawerContentScrollView>
    );
  }


export default () => {

    return (
      <Drawer.Navigator
        screenOptions={{ swipeEnabled: false }}
        drawerStyle={{ backgroundColor: "#ffffff", borderTopRightRadius: 20, borderBottomRightRadius: 20 }}
        drawerContent={props => <CustomDrawerContent {...props} />}>
        <Drawer.Screen name="drawerScreen" component={Stack} options={{ drawerLabel: () => null }} />
  
      </Drawer.Navigator>
    );
  };