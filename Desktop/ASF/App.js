import React from 'react';
import {
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
} from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import Drawer from './navigation/Drawer';

const App = () => {
  return (
    <>
      <StatusBar barStyle="default" />
      <NavigationContainer>
        <Drawer/>
      </NavigationContainer>
    </>
  );
};

const styles = StyleSheet.create({

});

export default App;
