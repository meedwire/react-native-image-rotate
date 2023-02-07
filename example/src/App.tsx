import React from 'react';

import { StyleSheet, View, Image, Button } from 'react-native';
import { rotate } from 'react-native-image-rotate';
import image from './image';

export default function App() {
  const [result, setResult] = React.useState<string>();

  const rotateImage = async () => {
    try {
      const path = await rotate({ type: 'base64', content: image, angle: 90 });

      setResult(path);
    } catch (error) {}
  };

  return (
    <View style={styles.container}>
      {result && <Image source={{ uri: result }} style={styles.image} />}
      <Button title="Rotate" onPress={rotateImage} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  image: {
    alignSelf: 'center',
    width: 200,
    height: 200,
  },
});
