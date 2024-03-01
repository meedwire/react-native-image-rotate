import React, { useState } from 'react';

import {
  StyleSheet,
  View,
  Image,
  Text,
  SafeAreaView,
  TouchableOpacity,
} from 'react-native';
import { rotate } from 'react-native-image-rotate';
import image from './image';

export default function App() {
  const [result, setResult] = React.useState<string>();
  const [angle, setAngle] = useState(90);

  const rotateImage = async () => {
    try {
      const path = await rotate({ type: 'base64', content: image, angle });

      setResult(path);
      setAngle((prev) => (prev >= 360 ? 90 : prev + 90));
    } catch (error) {}
  };

  return (
    <SafeAreaView style={styles.safeContainer}>
      <View style={styles.container}>
        <Text style={styles.textTitle}>Simple image rotate</Text>

        <Text style={styles.textSubTitle}>Original image</Text>
        <Image
          source={{ uri: `data:image/png;base64,${image}` }}
          style={styles.image}
          resizeMode="contain"
        />

        <Text style={styles.textSubTitle}>Rotated image</Text>
        {result && (
          <Image
            source={{ uri: result }}
            style={styles.image}
            resizeMode="contain"
          />
        )}
        <TouchableOpacity style={styles.button} onPress={rotateImage}>
          <Text style={styles.textButton}>Rotate - {angle}deg</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  safeContainer: {
    flex: 1,
  },
  container: {
    flex: 1,
    backgroundColor: 'white',
    padding: 22,
  },
  image: {
    alignSelf: 'center',
    width: 200,
    height: 200,
    borderRadius: 4,
    marginTop: 8,
  },
  button: {
    marginTop: 'auto',
    alignItems: 'center',
    padding: 12,
    backgroundColor: '#868686',
    borderRadius: 22,
  },
  textButton: {
    color: 'white',
  },
  textTitle: {
    fontSize: 16,
    fontWeight: '600',
  },
  textSubTitle: {
    fontSize: 14,
    fontWeight: '400',
    color: '#868686',
    marginTop: 22,
  },
});
