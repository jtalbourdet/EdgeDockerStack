import demoClass from "./testModule" 


const demo = new demoClass


function testFct() {
    demo.demoMsg()
}

setInterval(testFct,3000)
