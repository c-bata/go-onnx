package main

import (
	"io/ioutil"
	"log"

	"github.com/c-bata/go-onnx/onnx"
)

func main() {
	b, err := ioutil.ReadFile("./lr_diabetes.onnx")
	if err != nil {
		log.Fatalln(err)
	}
	p := &onnx.ModelProto{}
	if err := p.XXX_Unmarshal(b); err != nil {
		log.Fatalln(err)
	}
	log.Printf("%#v", p)
}
