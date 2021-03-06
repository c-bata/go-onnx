# go-onnx

Golang binding of ONNX and ONNX-ML.

## Usage

1. Export ONNX-ML IR by using [sklearn-onnx](https://github.com/onnx/sklearn-onnx)
2. Binds it to Go's struct like following code:

```go
package main

import (
	"fmt"
	"io/ioutil"
	"log"

	"github.com/c-bata/go-onnx/onnx"
)

func main() {
	b, err := ioutil.ReadFile("./rf_iris.onnx")
	if err != nil {
		log.Fatalln(err)
	}
	p := &onnx.ModelProto{}
	if err := p.XXX_Unmarshal(b); err != nil {
		log.Fatalln(err)
	}

	fmt.Printf("%#v", p)
}
```

## License

MIT License
