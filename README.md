# react-native-image-rotate

This package provide methods rotate images

## Installation

```sh
npm install react-native-image-rotate
```

## Usage

```tsx
import React from 'react';

import { StyleSheet, View, Image, Button } from 'react-native';
import { rotate } from 'react-native-image-rotate';
import image from './image';

export default function App() {
  const [result, setResult] = React.useState<string>();
  const [angle, setAngle] = useState(90);
  const [file, setFile] = useState<Asset>();

  const base64Rotate = async () => {
    try {
      if (!file) return;

      const path = await rotate({
        type: 'base64',
        content: file.base64,
        angle,
      });

      setResult(path);
      setAngle((prev) => (prev >= 360 ? 90 : prev + 90));
    } catch (error) {}
  };

  const fileRotate = async () => {
    try {
      if (!file) return;

      const path = await rotate({
        type: 'file',
        content: file.uri,
        angle,
      });

      setResult(path);
      setAngle((prev) => (prev >= 360 ? 90 : prev + 90));
    } catch (error) {}
  };

  const fileSelect = async () => {
    try {
      const fileSelected = await launchImageLibrary({
        mediaType: 'photo',
        includeBase64: true,
        selectionLimit: 1,
      });

      setFile(fileSelected.assets?.at(0));
      setAngle((prev) => (prev >= 360 ? 90 : prev + 90));
    } catch (error) {}
  };

  return (
    <SafeAreaView style={styles.safeContainer}>
      <View style={styles.container}>
        <Text style={styles.textTitle}>Simple image rotate</Text>

        <Text style={styles.textSubTitle}>Original image</Text>
        {file && (
          <Image
            source={{ uri: file?.uri }}
            style={styles.image}
            resizeMode="contain"
          />
        )}

        <Text style={styles.textSubTitle}>Rotated image</Text>
        {result && (
          <Image
            source={{ uri: result }}
            style={styles.image}
            resizeMode="contain"
          />
        )}
        {file && (
          <>
            <TouchableOpacity style={styles.button} onPress={base64Rotate}>
              <Text style={styles.textButton}>Rotate - {angle}deg</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.buttonFile} onPress={fileRotate}>
              <Text style={styles.textButton}>File Rotate - {angle}deg</Text>
            </TouchableOpacity>
          </>
        )}

        <TouchableOpacity
          style={[styles.buttonFile, { marginTop: file ? 22 : 'auto' }]}
          onPress={fileSelect}
        >
          <Text style={styles.textButton}>Select file</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({...});
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
