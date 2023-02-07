import React, { useCa } from 'react';

import { StyleSheet, View, Text, Image } from 'react-native';
import { rotate } from 'react-native-image-rotate';
import image from './image';

export default function App() {
  const [result, setResult] = React.useState<number | undefined>();

  const rotateImage = async () => {
    try {
      const path = await rotate({ type: 'base64', content: image, angle: 90 });

      console.log('Path', path);

      setResult(path);
    } catch (error) {
      console.log(error);
    }
  };

  React.useEffect(() => {
    rotateImage();
  }, []);

  return (
    <View style={styles.container}>
      <Text>Result: {result}</Text>
      {result && (
        <Image source={{ uri: result }} style={{ width: 200, height: 250 }} />
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
