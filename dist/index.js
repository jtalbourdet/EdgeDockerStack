"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const testModule_1 = require("./testModule");
const demo = new testModule_1.default;
function testFct() {
    demo.demoMsg();
}
setInterval(testFct, 3000);
//# sourceMappingURL=index.js.map