"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class demoClass {
    constructor() {
        this.msg = 'bonjour';
        this.numb = 12;
        console.log('Instance started');
        this.msg = this.numb.toString();
    }
    demoMsg() {
        this.numb = (this.numb + 1);
        console.log(this.numb);
    }
}
exports.default = demoClass;
//# sourceMappingURL=testModule.js.map